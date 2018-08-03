# -*- coding: utf-8 -*-
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
from pprint import pprint

from cli_common import log
from shipit_code_coverage_backend.services.active_data import ActiveDataCoverage
from shipit_code_coverage_backend.v2.base import NoResults
from shipit_code_coverage_backend.v2.base import active_data

logger = log.get_logger(__name__)


def coverage_in_push(files, push):
    '''
    Load coverage for several files, on a specific push
    Aggregate covered lines directly through ES "painless"
    '''
    assert isinstance(files, (list, tuple))
    assert isinstance(push, int)

    filters = [
        # Filter by files
        {'terms': {ActiveDataCoverage.FIELD_FILENAME: files}},

        # Filter by push
        {'term': {ActiveDataCoverage.FIELD_PUSH: push}},
    ]
    query = ActiveDataCoverage.base_query(filters)
    query.update({
        'size': 0,
        'aggs': {
            'files': {
                'terms': {'field': ActiveDataCoverage.FIELD_FILENAME},

                'aggs': {
                    'covered': {
                        'scripted_metric': {
                            'init_script': 'params._agg.covered = []',

                            # Merge all the covered lines, per ES shard
                            'map_script': 'params._agg.covered.addAll(doc[\'source.file.covered.~n~\'])',

                            # Make a set per shard
                            'combine_script': 'return params._agg.covered.stream().distinct().collect(Collectors.toList())',

                            # Merge all sets into a unique result per file (top aggregation)
                            'reduce_script': 'return params._aggs.stream().flatMap(Collection::stream).distinct().sorted().collect(Collectors.toList())'
                        }
                    }
                }
            },
        },
    })
    out = active_data.search('coverage_files_push', query, timeout=100)

    return {
        bucket['key']: list(map(int, bucket['covered']['value']))
        for bucket in out['aggregations']['files']['buckets']
    }


def changes_on_files(files, push, revision_index, branch_name):
    '''
    List all the operations that happened on some files, in a push
    '''
    assert isinstance(files, (list, tuple))
    assert isinstance(push, int)
    query = {
        'query': {
            'bool': {

                # Files intersection
                'should': [
                    {'match': {'changeset.files': f}}
                    for f in files
                ],

                'must': [
                    # After our commit
                    {'range': {
                        'index': {'gt': revision_index},
                    }},

                    # Same push and repo
                    {'match': {'push.id': push}},
                    {'match': {'branch.name': branch_name}},
                ]
            }
        },

        # Only load moves
        '_source': ['changeset.moves', 'changeset.description'],

        # Probably should use scan/scroll
        'size': 100,
    }
    try:
        others = active_data.search('commits_above', body=query, index='repo')
    except NoResults:
        others = None

    if others:

        # Group by files, with only our interesting files
        return {
            filename: [
                move['changes']
                for other in others['hits']['hits']
                for move in other['_source']['changeset']['moves']
                if move['new']['name'].endswith(filename) or move['old']['name'].endswith(filename)
            ]
            for filename in files
        }


def coverage_diff(changeset):
    '''
    List all the coverage changes introduced by a diff
    '''

    print('DIFF', changeset)

    # Load revision from MC
    rev = active_data.get_changeset(changeset)

    print('-' * 80)
    print('REVISION:')
    pprint(rev)

    files = rev['changeset']['files']
    push = rev['push']['id']
    logger.info('Looking up coverage', files=files, push=push)

    # Load all the other commits on this push, above this changeset
    # and for these files
    changes = changes_on_files(files, push, rev['index'], rev['branch']['name'])

    print('-' * 80)
    print('Changes:')
    pprint(changes)

    print('-' * 80)
    print('FILES PUSH:')
    pprint(coverage_in_push(files, push))
    return {}
