# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -v -V 3.6 -r requirements.txt -r requirements-dev.txt
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python36;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            if [ -e $out/${pkgs.python36.sitePackages}/pip/req/req_install.py ]; then
              sed -i \
                -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"  \
                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"  \
                $out/${pkgs.python36.sitePackages}/pip/req/req_install.py
            fi
          '';
        });
      };
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python36-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "Flask" = python.mkDerivation {
      name = "Flask-1.0.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4b/12/c1fbf4971fda0e4de05565694c9f0c92646223cff53f15b6eb248a310a62/Flask-1.0.2.tar.gz"; sha256 = "2271c0070dbcb5275fad4a82e29f23ab92682dc45f9dfbc22c02ba9b9322ce48"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Jinja2"
      self."Werkzeug"
      self."click"
      self."coverage"
      self."itsdangerous"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.palletsprojects.com/p/flask/";
        license = licenses.bsdOriginal;
        description = "A simple framework for building complex web applications.";
      };
    };

    "Flask-Cache" = python.mkDerivation {
      name = "Flask-Cache-0.13.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/91/c4/f71095437bd4b691c63f240e72a20c57e2c216085cbc271f79665885d3da/Flask-Cache-0.13.1.tar.gz"; sha256 = "90126ca9bc063854ef8ee276e95d38b2b4ec8e45fd77d5751d37971ee27c7ef4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/thadeusb/flask-cache";
        license = licenses.bsdOriginal;
        description = "Adds cache support to your Flask application";
      };
    };

    "Flask-Cors" = python.mkDerivation {
      name = "Flask-Cors-3.0.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/88/94/e529ec65fac24056e0877f39fb229db99ee2ee9018e9602f850655d6b5a0/Flask-Cors-3.0.4.tar.gz"; sha256 = "bec996f0603a0693c0ea63c8126e5f8e966bb679cf82e6104b254e9c7f3a7d08"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/corydolphin/flask-cors";
        license = licenses.mit;
        description = "A Flask extension adding a decorator for CORS support";
      };
    };

    "Flask-Login" = python.mkDerivation {
      name = "Flask-Login-0.4.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c1/ff/bd9a4d2d81bf0c07d9e53e8cd3d675c56553719bbefd372df69bf1b3c1e4/Flask-Login-0.4.1.tar.gz"; sha256 = "c815c1ac7b3e35e2081685e389a665f2c74d7e077cb93cecabaea352da4752ec"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/maxcountryman/flask-login";
        license = licenses.mit;
        description = "User session management for Flask";
      };
    };

    "Flask-Migrate" = python.mkDerivation {
      name = "Flask-Migrate-2.1.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/2f/84/9a7d3dafd45b41931f2833a28f96537cca1771583102204310a6246f750e/Flask-Migrate-2.1.1.tar.gz"; sha256 = "b709ca8642559c3c5a81a33ab10839fa052177accd5ba821047a99db635255ed"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
      self."Flask-SQLAlchemy"
      self."alembic"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/miguelgrinberg/flask-migrate/";
        license = licenses.mit;
        description = "SQLAlchemy database migrations for Flask applications using Alembic";
      };
    };

    "Flask-SQLAlchemy" = python.mkDerivation {
      name = "Flask-SQLAlchemy-2.3.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/3a/66/f5ace276517c075f102457dd2f7d8645b033758f9c6effb4e0970a90fec1/Flask-SQLAlchemy-2.3.2.tar.gz"; sha256 = "5971b9852b5888655f11db634e87725a9031e170f37c0ce7851cf83497f56e53"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
      self."SQLAlchemy"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/mitsuhiko/flask-sqlalchemy";
        license = licenses.bsdOriginal;
        description = "Adds SQLAlchemy support to your Flask application";
      };
    };

    "Jinja2" = python.mkDerivation {
      name = "Jinja2-2.10";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/56/e6/332789f295cf22308386cf5bbd1f4e00ed11484299c5d7383378cf48ba47/Jinja2-2.10.tar.gz"; sha256 = "f84be1bb0040caca4cea721fcbbbbd61f9be9464ca236387158b0feea01914a4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."MarkupSafe"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://jinja.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "A small but fast and easy to use stand-alone template engine written in pure python.";
      };
    };

    "Logbook" = python.mkDerivation {
      name = "Logbook-1.4.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/36/4b/b610bee18d5cfc4cec7dde056639994e9b34991e4c57816bfff0f3d0ac33/Logbook-1.4.0.tar.gz"; sha256 = "3c0a3ebd48e89fcdd725fe393eb9226c789dca5a4e7842d65e2f256645fd1cd9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Jinja2"
      self."SQLAlchemy"
      self."pytest"
      self."pytest-cov"
      self."redis"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://logbook.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "A logging replacement for Python";
      };
    };

    "Mako" = python.mkDerivation {
      name = "Mako-1.0.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/eb/f3/67579bb486517c0d49547f9697e36582cd19dafb5df9e687ed8e22de57fa/Mako-1.0.7.tar.gz"; sha256 = "4e02fde57bd4abb5ec400181e4c314f56ac3e49ba4fb8b0d50bba18cb27d25ae"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."MarkupSafe"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.makotemplates.org/";
        license = licenses.mit;
        description = "A super-fast templating language that borrows the  best ideas from the existing templating languages.";
      };
    };

    "MarkupSafe" = python.mkDerivation {
      name = "MarkupSafe-1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz"; sha256 = "a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/pallets/markupsafe";
        license = licenses.bsdOriginal;
        description = "Implements a XML/HTML/XHTML Markup safe string for Python";
      };
    };

    "PyYAML" = python.mkDerivation {
      name = "PyYAML-3.12";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz"; sha256 = "592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pyyaml.org/wiki/PyYAML";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "Pygments" = python.mkDerivation {
      name = "Pygments-2.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/71/2a/2e4e77803a8bd6408a2903340ac498cb0a2181811af7c9ec92cb70b0308a/Pygments-2.2.0.tar.gz"; sha256 = "dbae1046def0efb574852fab9e90209b23f556367b5a320c0bcb871c77c3e8cc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pygments.org/";
        license = licenses.bsdOriginal;
        description = "Pygments is a syntax highlighting package written in Python.";
      };
    };

    "SQLAlchemy" = python.mkDerivation {
      name = "SQLAlchemy-1.2.8";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b4/9c/411a9bac1a471bed54ec447dc183aeed12a75c1b648307e18b56e3829363/SQLAlchemy-1.2.8.tar.gz"; sha256 = "2d5f08f714a886a1382c18be501e614bce50d362384dc089474019ce0768151c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.sqlalchemy.org";
        license = licenses.mit;
        description = "Database Abstraction Library";
      };
    };

    "Werkzeug" = python.mkDerivation {
      name = "Werkzeug-0.14.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9f/08/a3bb1c045ec602dc680906fc0261c267bed6b3bb4609430aff92c3888ec8/Werkzeug-0.14.1.tar.gz"; sha256 = "c3fd7a7d41976d9f44db327260e263132466836cef6f91512889ed60ad26557c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.palletsprojects.org/p/werkzeug/";
        license = licenses.bsdOriginal;
        description = "The comprehensive WSGI web application library.";
      };
    };

    "aioamqp" = python.mkDerivation {
      name = "aioamqp-0.10.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/22/f2/2b78c982e81eb840de18a419aa5c7d10519ccd81852e91310ebcbcd3e78b/aioamqp-0.10.0.tar.gz"; sha256 = "c618af6d005942a2a8711f7548348f9028fac2673f0dc2d192310cef83486204"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/polyconseil/aioamqp";
        license = licenses.bsdOriginal;
        description = "AMQP implementation using asyncio";
      };
    };

    "aiohttp" = python.mkDerivation {
      name = "aiohttp-3.2.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/81/fa/8915137ac0603112bbb63489de90a75c69da8a138594eb6a24cb8afb14df/aiohttp-3.2.1.tar.gz"; sha256 = "1b95d53f8dac13898f0a3e4af76f6f36d540fbfaefc4f4c9f43e436fa0e53d22"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."async-timeout"
      self."attrs"
      self."chardet"
      self."idna-ssl"
      self."multidict"
      self."yarl"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/aiohttp/";
        license = licenses.asl20;
        description = "Async http client/server framework (asyncio)";
      };
    };

    "alembic" = python.mkDerivation {
      name = "alembic-0.9.9";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/89/03/756d5b8e1c90bf283c3f435766aa3f20208d1c3887579dd8f2122e01d5f4/alembic-0.9.9.tar.gz"; sha256 = "85bd3ea7633024e4930900bc64fb58f9742dedbc6ebb6ecf25be2ea9a3c1b32e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Mako"
      self."SQLAlchemy"
      self."python-dateutil"
      self."python-editor"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/zzzeek/alembic";
        license = licenses.mit;
        description = "A database migration tool for SQLAlchemy.";
      };
    };

    "amqp" = python.mkDerivation {
      name = "amqp-2.3.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ca/0a/95f9fb2dd71578cb5629261230cb5b8b278c7cce908bca55af8030faceba/amqp-2.3.2.tar.gz"; sha256 = "073dd02fdd73041bffc913b767866015147b61f2a9bc104daef172fc1a0066eb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."vine"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/py-amqp";
        license = licenses.bsdOriginal;
        description = "Low-level AMQP client for Python (fork of amqplib).";
      };
    };

    "aresponses" = python.mkDerivation {
      name = "aresponses-1.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/62/41/a915f9fbe3ea896c49ca6f0f371c32b9b817703fd5829dbc641e58a242a0/aresponses-1.0.0.tar.gz"; sha256 = "4ab6c21a33594171eb6e55e54a8dd61e7c2fc0679ab26f6c7a263fe3c3574f6c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."aiohttp"
      self."pytest-asyncio"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/circleup/aresponses";
        license = "";
        description = "Asyncio testing server. Similar to the responses library used for 'requests'";
      };
    };

    "async-lru" = python.mkDerivation {
      name = "async-lru-1.0.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/30/fc/a9a15a5fc778c425320b31da972ea241b9d660f6c95f82a2f134704a96fe/async_lru-1.0.1.tar.gz"; sha256 = "ac1f7138b54d68570391615b1ff758e189ce2b841a16653aae1255f5be5d4d0b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/wikibusiness/async_lru";
        license = licenses.mit;
        description = "Simple lru_cache for asyncio";
      };
    };

    "async-timeout" = python.mkDerivation {
      name = "async-timeout-3.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/35/82/6c7975afd97661e6115eee5105359ee191a71ff3267fde081c7c8d05fae6/async-timeout-3.0.0.tar.gz"; sha256 = "b3c0ddc416736619bd4a95ca31de8da6920c3b9a140c64dbef2b2fa7bf521287"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/async_timeout/";
        license = licenses.asl20;
        description = "Timeout context manager for asyncio programs";
      };
    };

    "atomicwrites" = python.mkDerivation {
      name = "atomicwrites-1.1.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a1/e1/2d9bc76838e6e6667fde5814aa25d7feb93d6fa471bf6816daac2596e8b2/atomicwrites-1.1.5.tar.gz"; sha256 = "240831ea22da9ab882b551b31d4225591e5e447a68c5e188db5b89ca1d487585"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/untitaker/python-atomicwrites";
        license = licenses.mit;
        description = "Atomic file writes.";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-18.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e4/ac/a04671e118b57bee87dabca1e0f2d3bda816b7a551036012d0ca24190e71/attrs-18.1.0.tar.gz"; sha256 = "e0d0eb91441a3b53dab4d9b743eafc1ac44476296a2053b6ca3af0b139faf87b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."pytest"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "backcall" = python.mkDerivation {
      name = "backcall-0.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/84/71/c8ca4f5bb1e08401b916c68003acf0a0655df935d74d93bf3f3364b310e0/backcall-0.1.0.tar.gz"; sha256 = "38ecd85be2c1e78f77fd91700c76e14667dc21e2713b63876c0eb901196e01e4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/takluyver/backcall";
        license = licenses.bsdOriginal;
        description = "Specifications for callback functions passed in to an API";
      };
    };

    "blinker" = python.mkDerivation {
      name = "blinker-1.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/1b/51/e2a9f3b757eb802f61dc1f2b09c8c99f6eb01cf06416c0671253536517b6/blinker-1.4.tar.gz"; sha256 = "471aee25f3992bd325afa3772f1063dbdbbca947a041b8b89466dc00d606f8b6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/blinker/";
        license = licenses.mit;
        description = "Fast, simple object-to-object and broadcast signaling";
      };
    };

    "boto" = python.mkDerivation {
      name = "boto-2.48.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/66/e7/fe1db6a5ed53831b53b8a6695a8f134a58833cadb5f2740802bc3730ac15/boto-2.48.0.tar.gz"; sha256 = "deb8925b734b109679e3de65856018996338758f4b916ff4fe7bb62b6d7000d1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/boto/";
        license = licenses.mit;
        description = "Amazon Web Services Library";
      };
    };

    "boto3" = python.mkDerivation {
      name = "boto3-1.7.30";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8d/da/0067b54936a995d744d37be67cae6b913b29fc45cf316a7409638a65a95f/boto3-1.7.30.tar.gz"; sha256 = "38a811f3335b08690182fdbddb07f0cb5e8f0b5bccbcf9ef606ed2a2508a9fd7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."botocore"
      self."jmespath"
      self."s3transfer"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/boto3";
        license = licenses.asl20;
        description = "The AWS SDK for Python";
      };
    };

    "botocore" = python.mkDerivation {
      name = "botocore-1.10.30";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/46/35/b542e3011ac16e3b6d9b7d5f777b500c4cc62bff853ec7960a6cad32b5da/botocore-1.10.30.tar.gz"; sha256 = "1f6d0a135c9505e0840b675e6bd6b556c85df2e63212ac6850f77edf9f68311a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."docutils"
      self."jmespath"
      self."python-dateutil"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/botocore";
        license = licenses.asl20;
        description = "Low-level, data-driven core of boto 3.";
      };
    };

    "cachetools" = python.mkDerivation {
      name = "cachetools-2.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/87/41/b3e00059f3c34b57a653d2120d213715abb4327b36fee22e59c1da977d25/cachetools-2.1.0.tar.gz"; sha256 = "90f1d559512fc073483fe573ef5ceb39bf6ad3d39edc98dc55178a2b2b176fa3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tkem/cachetools";
        license = licenses.mit;
        description = "Extensible memoizing collections and decorators";
      };
    };

    "certifi" = python.mkDerivation {
      name = "certifi-2018.4.16";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4d/9c/46e950a6f4d6b4be571ddcae21e7bc846fcbb88f1de3eff0f6dd0a6be55d/certifi-2018.4.16.tar.gz"; sha256 = "13e698f54293db9f89122b0581843a782ad0934a4fe0172d2a980ba77fc61bb7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"; sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "click" = python.mkDerivation {
      name = "click-6.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/95/d9/c3336b6b5711c3ab9d1d3a80f1a3e2afeb9d8c02a7166462f6cc96570897/click-6.7.tar.gz"; sha256 = "f15516df478d5a56180fbf80e68f206010e6d160fc39fa508b65e035fd75130b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/mitsuhiko/click";
        license = licenses.bsdOriginal;
        description = "A simple wrapper around optparse for powerful command line utilities.";
      };
    };

    "clickclick" = python.mkDerivation {
      name = "clickclick-1.2.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b8/cf/2d1fb0c967616e7cd3a8e6a3aca38bc50b50137d9bc7f46cdb3e6fe03361/clickclick-1.2.2.tar.gz"; sha256 = "4a890aaa9c3990cfabd446294eb34e3dc89701101ac7b41c1bff85fc210f6d23"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."click"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zalando/python-clickclick";
        license = licenses.asl20;
        description = "Click utility functions";
      };
    };

    "codecov" = python.mkDerivation {
      name = "codecov-2.0.15";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/77/f2/9790ee0f04eb0571841aff5ba1709c7869e82aa2145a04a3d4770807ff50/codecov-2.0.15.tar.gz"; sha256 = "8ed8b7c6791010d359baed66f84f061bba5bd41174bf324c31311e8737602788"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/codecov/codecov-python";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Hosted coverage reports for Github, Bitbucket and Gitlab";
      };
    };

    "connexion" = python.mkDerivation {
      name = "connexion-1.4.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/86/8b/72989d070c136a5b063575c6d219d7c36af15c0b23dd58a43379375a803e/connexion-1.4.2.tar.gz"; sha256 = "0fff80c9976980a5a4c24c53baca601556bd9b820c6d6d385d9c9ce0727a01b2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
      self."PyYAML"
      self."aiohttp"
      self."clickclick"
      self."decorator"
      self."inflection"
      self."jsonschema"
      self."pytest"
      self."pytest-cov"
      self."requests"
      self."six"
      self."swagger-spec-validator"
      self."testfixtures"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zalando/connexion";
        license = licenses.asl20;
        description = "Connexion - API first applications with OpenAPI/Swagger and Flask";
      };
    };

    "cookies" = python.mkDerivation {
      name = "cookies-2.2.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f3/95/b66a0ca09c5ec9509d8729e0510e4b078d2451c5e33f47bd6fc33c01517c/cookies-2.2.1.tar.gz"; sha256 = "d6b698788cae4cfa4e62ef8643a9ca332b79bd96cb314294b864ae8d7eb3ee8e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/sashahart/cookies";
        license = licenses.mit;
        description = "Friendlier RFC 6265-compliant cookie parser/renderer";
      };
    };

    "coverage" = python.mkDerivation {
      name = "coverage-4.5.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/35/fe/e7df7289d717426093c68d156e0fd9117c8f4872b6588e8a8928a0f68424/coverage-4.5.1.tar.gz"; sha256 = "56e448f051a201c5ebbaa86a5efd0ca90d327204d8b059ab25ad0f35fbfd79f1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/ned/coveragepy";
        license = licenses.asl20;
        description = "Code coverage measurement for Python";
      };
    };

    "coveralls" = python.mkDerivation {
      name = "coveralls-1.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/3e/dd/61b1365f2d1d3fc459f9e3d36d9c8824fb3c9cd6bf5ee721ca6c8f68c164/coveralls-1.3.0.tar.gz"; sha256 = "664794748d2e5673e347ec476159a9d87f43e0d2d44950e98ed0e27b98da8346"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."coverage"
      self."docopt"
      self."requests"
      self."urllib3"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/coveralls-clients/coveralls-python";
        license = licenses.mit;
        description = "Show coverage stats online via coveralls.io";
      };
    };

    "decorator" = python.mkDerivation {
      name = "decorator-4.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/6f/24/15a229626c775aae5806312f6bf1e2a73785be3402c0acdec5dbddd8c11e/decorator-4.3.0.tar.gz"; sha256 = "c39efa13fbdeb4506c476c9b3babf6a718da943dab7811c206005a4a956c080c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/micheles/decorator";
        license = licenses.bsdOriginal;
        description = "Better living through Python with decorators";
      };
    };

    "docopt" = python.mkDerivation {
      name = "docopt-0.6.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"; sha256 = "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docopt.org";
        license = licenses.mit;
        description = "Pythonic argument parser, that will make you smile";
      };
    };

    "docutils" = python.mkDerivation {
      name = "docutils-0.14";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/84/f4/5771e41fdf52aabebbadecc9381d11dea0fa34e4759b4071244fa094804c/docutils-0.14.tar.gz"; sha256 = "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = licenses.publicDomain;
        description = "Docutils -- Python Documentation Utilities";
      };
    };

    "ecdsa" = python.mkDerivation {
      name = "ecdsa-0.13";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f9/e5/99ebb176e47f150ac115ffeda5fedb6a3dbb3c00c74a59fd84ddf12f5857/ecdsa-0.13.tar.gz"; sha256 = "64cf1ee26d1cde3c73c6d7d107f835fed7c6a2904aef9eac223d57ad800c43fa"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/warner/python-ecdsa";
        license = licenses.mit;
        description = "ECDSA cryptographic signature library (pure python)";
      };
    };

    "elasticsearch" = python.mkDerivation {
      name = "elasticsearch-6.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/7b/32/645c407856c2e799d41c8a861e8d707070f82f00abf3089ccbf80b3c1e20/elasticsearch-6.2.0.tar.gz"; sha256 = "b106fa3e01750376a42f8a9882bd84d630fda58c7aba38b4fec797d11c0bd0a2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."nose"
      self."requests"
      self."urllib3"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/elastic/elasticsearch-py";
        license = licenses.asl20;
        description = "Python client for Elasticsearch";
      };
    };

    "elasticsearch-async" = python.mkDerivation {
      name = "elasticsearch-async-6.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/43/d9/edb0d872091d35255e004b15a97d643f9dbe37323b18b2b4e972354d23f4/elasticsearch-async-6.0.0.tar.gz"; sha256 = "555f9b7bc97c3f0484d940525aabd559e0c87feccefa4448a4d11ddbf4870c5f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."aiohttp"
      self."async-timeout"
      self."elasticsearch"
      self."pytest"
      self."pytest-asyncio"
      self."pytest-cov"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/elastic/elasticsearch-py-async";
        license = licenses.asl20;
        description = "Async backend for elasticsearch-py";
      };
    };

    "esFrontLine" = python.mkDerivation {
      name = "esFrontLine-1.1.14230";
      src = pkgs.fetchurl { url = "https://github.com/mozilla/esFrontLine/archive/987f924750ae1ec7bd684fc37c80003473ae9bed.tar.gz"; sha256 = "6d75a4945437dcf27655d697868f745a74a2fc0f8c77ad55af56cad945450c82"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
      self."mohawk"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/klahnakoski/esFrontLine";
        license = licenses.mpl20;
        description = "Limit restful requests to backend ElasticSearch cluster:  Queries only.";
      };
    };

    "fancycompleter" = python.mkDerivation {
      name = "fancycompleter-0.8";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/fd/e3/da39a6cfaffe578a01221261ac1d5d99c48d44f6377ff0de3a12dd332cec/fancycompleter-0.8.tar.gz"; sha256 = "d2522f1f3512371f295379c4c0d1962de06762eb586c199620a2a5d423539b12"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/antocuni/fancycompleter";
        license = licenses.bsdOriginal;
        description = "colorful TAB completion for Python prompt";
      };
    };

    "flake8" = python.mkDerivation {
      name = "flake8-3.5.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/1e/ab/7730f6d6cdf73a3b7f98a2fe3b2cdf68e9e760a4a133e083607497d4c3a6/flake8-3.5.0.tar.gz"; sha256 = "7253265f7abd8b313e3892944044a365e3f4ac3fcdcfb4298f55ee9ddf188ba0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."mccabe"
      self."pycodestyle"
      self."pyflakes"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://gitlab.com/pycqa/flake8";
        license = licenses.mit;
        description = "the modular source code checker: pep8, pyflakes and co";
      };
    };

    "flake8-coding" = python.mkDerivation {
      name = "flake8-coding-1.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ae/26/3c6304d646f8ee27d6c40bfcd9874fea870098c3ef3cf60e284ea9db29ef/flake8-coding-1.3.0.tar.gz"; sha256 = "ba01e96f879377766a3d71f3499a832b19386ce4831270bfe671ab57d0fe50be"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tk0miya/flake8-coding";
        license = licenses.asl20;
        description = "Adds coding magic comment checks to flake8";
      };
    };

    "flake8-copyright" = python.mkDerivation {
      name = "flake8-copyright-0.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/3a/22/2973cbdfd5c2df98bbd1b187c19c438653ffa75ea2ed1b0e610b344d70b6/flake8-copyright-0.2.0.tar.gz"; sha256 = "aeef26eb4d5223c9cd5b101e68175fcef6d2b353bf36da688fdde62fccfe2b73"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/savoirfairelinux/flake8-copyright";
        license = "";
        description = "Adds copyright checks to flake8";
      };
    };

    "flake8-debugger" = python.mkDerivation {
      name = "flake8-debugger-3.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/39/4b/90548607282483dd15f9ce1f4434d735ae756e16e1faf60621b0f8877fcc/flake8-debugger-3.1.0.tar.gz"; sha256 = "be4fb88de3ee8f6dd5053a2d347e2c0a2b54bab6733a2280bb20ebd3c4ca1d97"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
      self."pycodestyle"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jbkahn/flake8-debugger";
        license = licenses.mit;
        description = "ipdb/pdb statement checker plugin for flake8";
      };
    };

    "flake8-isort" = python.mkDerivation {
      name = "flake8-isort-2.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/07/ad/d8d87f1dc4f2ab398ba9e9ad603367d14ba7d614dad7dece66ae0148541b/flake8-isort-2.5.tar.gz"; sha256 = "298d7904ac3a46274edf4ce66fd7e272c2a60c34c3cc999dea000608d64e5e6e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
      self."isort"
      self."pytest"
      self."testfixtures"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gforcada/flake8-isort";
        license = licenses.gpl2;
        description = "flake8 plugin that integrates isort .";
      };
    };

    "flake8-mypy" = python.mkDerivation {
      name = "flake8-mypy-17.8.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/97/9a/cddd1363d7314bb4eb452089c6fb3092ed9fda9f3350683d1978522a30ec/flake8-mypy-17.8.0.tar.gz"; sha256 = "47120db63aff631ee1f84bac6fe8e64731dc66da3efc1c51f85e15ade4a3ba18"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."attrs"
      self."flake8"
      self."mypy"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ambv/flake8-mypy";
        license = licenses.mit;
        description = "A plugin for flake8 integrating mypy.";
      };
    };

    "flake8-quotes" = python.mkDerivation {
      name = "flake8-quotes-1.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/83/ff/0461010959158bb7d197691c696f1a85b20f2d3eea7aa23f73a8d07f30f3/flake8-quotes-1.0.0.tar.gz"; sha256 = "fd9127ad8bbcf3b546fa7871a5266fd8623ce765ebe3d5aa5eabb80c01212b26"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/zheller/flake8-quotes/";
        license = licenses.mit;
        description = "Flake8 lint for quotes.";
      };
    };

    "flask-oidc" = python.mkDerivation {
      name = "flask-oidc-1.4.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9a/de/402709ab3e67b2f52a552b4aaab66a051fec4c544d9cf0a88532f97c1634/flask-oidc-1.4.0.tar.gz"; sha256 = "0c12151139d47a562e1c5ae203fb9dbc759fe7474cc01e0238bef828ece58f4e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
      self."itsdangerous"
      self."oauth2client"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/puiterwijk/flask-oidc";
        license = licenses.bsdOriginal;
        description = "OpenID Connect extension for Flask";
      };
    };

    "flask-talisman" = python.mkDerivation {
      name = "flask-talisman-0.5.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/80/fb/aba24d703a8611deea7a00508243dd6f6a5e3512865a86ce40390096a4e6/flask-talisman-0.5.0.tar.gz"; sha256 = "e4e3ccba66895e1f46d5b62a9cc0f273731da601bc92d2b9af908011298c0e2b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/GoogleCloudPlatform/flask-talisman";
        license = "License :: OSI Approved :: Apache Software License";
        description = "HTTP security headers for Flask.";
      };
    };

    "future" = python.mkDerivation {
      name = "future-0.16.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/00/2b/8d082ddfed935f3608cc61140df6dcbf0edea1bc3ab52fb6c29ae3e81e85/future-0.16.0.tar.gz"; sha256 = "e39ced1ab767b5936646cedba8bcce582398233d6a627067d4c6a454c90cfedb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://python-future.org";
        license = licenses.mit;
        description = "Clean single-source support for Python 3 and 2";
      };
    };

    "gunicorn" = python.mkDerivation {
      name = "gunicorn-19.8.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/12/29/c7eb6f002898ec99b97e0be8b3617169d06221f26609f5cc5f1bdeb3e492/gunicorn-19.8.1.tar.gz"; sha256 = "bc59005979efb6d2dd7d5ba72d99f8a8422862ad17ff3a16e900684630dd2a10"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://gunicorn.org";
        license = licenses.mit;
        description = "WSGI HTTP Server for UNIX";
      };
    };

    "httplib2" = python.mkDerivation {
      name = "httplib2-0.11.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/fd/ce/aa4a385e3e9fd351737fd2b07edaa56e7a730448465aceda6b35086a0d9b/httplib2-0.11.3.tar.gz"; sha256 = "e71daed9a0e6373642db61166fa70beecc9bf04383477f84671348c02a04cbdf"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/httplib2/httplib2";
        license = licenses.mit;
        description = "A comprehensive HTTP client library.";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.6";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f4/bd/0467d62790828c23c47fc1dfa1b1f052b24efdf5290f071c7a91d0d82fd3/idna-2.6.tar.gz"; sha256 = "2c6a5de3089009e3da7c5dde64a141dbc8551d5b7f6cf4ed7c2568d0cc520a8f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "idna-ssl" = python.mkDerivation {
      name = "idna-ssl-1.0.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c4/3b/facf5a5009e577e7764e68a2af5ee25c63f41c78277260c2c42b8cfabf2e/idna-ssl-1.0.1.tar.gz"; sha256 = "1293f030bc608e9aa9cdee72aa93c1521bbb9c7698068c61c9ada6772162b979"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."idna"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/idna-ssl";
        license = licenses.mit;
        description = "Patch ssl.match_hostname for Unicode(idna) domains support";
      };
    };

    "inflection" = python.mkDerivation {
      name = "inflection-0.3.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/d5/35/a6eb45b4e2356fe688b21570864d4aa0d0a880ce387defe9c589112077f8/inflection-0.3.1.tar.gz"; sha256 = "18ea7fb7a7d152853386523def08736aa8c32636b047ade55f7578c4edeb16ca"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/jpvanhal/inflection";
        license = licenses.mit;
        description = "A port of Ruby on Rails inflector to Python";
      };
    };

    "inotify" = python.mkDerivation {
      name = "inotify-0.2.9";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/38/ce/f73b72c2852b819025b0e826b0dc28dddd3ecc9c58c77a47432570d77679/inotify-0.2.9.tar.gz"; sha256 = "f6ffb1c7355ec274dba10bd472662cf5b9ffbabedcce142c74443184535d7a10"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."nose"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/dsoprea/PyInotify";
        license = "GPL 2";
        description = "An adapter to Linux kernel support for inotify directory-watching.";
      };
    };

    "ipdb" = python.mkDerivation {
      name = "ipdb-0.11";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/80/fe/4564de08f174f3846364b3add8426d14cebee228f741c27e702b2877e85b/ipdb-0.11.tar.gz"; sha256 = "7081c65ed7bfe7737f83fa4213ca8afd9617b42ff6b3f1daf9a3419839a2a00a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ipython"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gotcha/ipdb";
        license = licenses.bsdOriginal;
        description = "IPython-enabled pdb";
      };
    };

    "ipython" = python.mkDerivation {
      name = "ipython-6.4.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ee/01/2a85cd07f5a43fa2e86d60001c213647252662d44a0c2e3d69471a058f1b/ipython-6.4.0.tar.gz"; sha256 = "eca537aa61592aca2fef4adea12af8e42f5c335004dfa80c78caf80e8b525e5c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Pygments"
      self."backcall"
      self."decorator"
      self."jedi"
      self."nose"
      self."pexpect"
      self."pickleshare"
      self."prompt-toolkit"
      self."requests"
      self."simplegeneric"
      self."traitlets"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://ipython.org";
        license = licenses.bsdOriginal;
        description = "IPython: Productive Interactive Computing";
      };
    };

    "ipython-genutils" = python.mkDerivation {
      name = "ipython-genutils-0.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e8/69/fbeffffc05236398ebfcfb512b6d2511c622871dca1746361006da310399/ipython_genutils-0.2.0.tar.gz"; sha256 = "eb2e116e75ecef9d4d228fdc66af54269afa26ab4463042e33785b887c628ba8"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://ipython.org";
        license = licenses.bsdOriginal;
        description = "Vestigial utilities from IPython";
      };
    };

    "isort" = python.mkDerivation {
      name = "isort-4.3.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b1/de/a628d16fdba0d38cafb3d7e34d4830f2c9cb3881384ce5c08c44762e1846/isort-4.3.4.tar.gz"; sha256 = "b9c40e9750f3d77e6e4d441d8b0266cf555e7cdabdcff33c4fd06366ca761ef8"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/timothycrosley/isort";
        license = licenses.mit;
        description = "A Python utility / library to sort Python imports.";
      };
    };

    "itsdangerous" = python.mkDerivation {
      name = "itsdangerous-0.24";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/dc/b4/a60bcdba945c00f6d608d8975131ab3f25b22f2bcfe1dab221165194b2d4/itsdangerous-0.24.tar.gz"; sha256 = "cbb3fcf8d3e33df861709ecaf89d9e6629cff0a217bc2848f1b41cd30d360519"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/mitsuhiko/itsdangerous";
        license = licenses.bsdOriginal;
        description = "Various helpers to pass trusted data to untrusted environments and back.";
      };
    };

    "jedi" = python.mkDerivation {
      name = "jedi-0.12.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ff/c9/781449489b743c67ad063e33aa68139afaa8a1a5bc348eee9f5cab39b4e1/jedi-0.12.0.tar.gz"; sha256 = "1972f694c6bc66a2fac8718299e2ab73011d653a6d8059790c3476d2353b99ad"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."docopt"
      self."parso"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/davidhalter/jedi";
        license = licenses.mit;
        description = "An autocompletion tool for Python that can be used for text editors.";
      };
    };

    "jmespath" = python.mkDerivation {
      name = "jmespath-0.9.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e5/21/795b7549397735e911b032f255cff5fb0de58f96da794274660bca4f58ef/jmespath-0.9.3.tar.gz"; sha256 = "6a81d4c9aa62caf061cb517b4d9ad1dd300374cd4706997aff9cd6aedd61fc64"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jmespath/jmespath.py";
        license = licenses.mit;
        description = "JSON Matching Expressions";
      };
    };

    "jsonschema" = python.mkDerivation {
      name = "jsonschema-2.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/58/b9/171dbb07e18c6346090a37f03c7e74410a1a56123f847efed59af260a298/jsonschema-2.6.0.tar.gz"; sha256 = "6ff5f3180870836cae40f06fa10419f557208175f13ad7bc26caa77beb1f6e02"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/Julian/jsonschema";
        license = licenses.mit;
        description = "An implementation of JSON Schema validation for Python";
      };
    };

    "kombu" = python.mkDerivation {
      name = "kombu-4.2.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/39/9f/556b988833abede4a80dbd18b2bdf4e8ff4486dd482ed45da961347e8ed2/kombu-4.2.1.tar.gz"; sha256 = "86adec6c60f63124e2082ea8481bbe4ebe04fde8ebed32c177c7f0cd2c1c9082"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."SQLAlchemy"
      self."amqp"
      self."boto3"
      self."redis"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://kombu.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Messaging library for Python.";
      };
    };

    "mccabe" = python.mkDerivation {
      name = "mccabe-0.6.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/06/18/fa675aa501e11d6d6ca0ae73a101b2f3571a565e0f7d38e062eec18a91ee/mccabe-0.6.1.tar.gz"; sha256 = "dd8d182285a0fe56bace7f45b5e7d1a6ebcbf524e8f3bd87eb0f125271b8831f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pycqa/mccabe";
        license = licenses.mit;
        description = "McCabe checker, plugin for flake8";
      };
    };

    "mohawk" = python.mkDerivation {
      name = "mohawk-0.3.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/19/22/10f696548a8d41ad41b92ab6c848c60c669e18c8681c179265ce4d048b03/mohawk-0.3.4.tar.gz"; sha256 = "e98b331d9fa9ece7b8be26094cbe2d57613ae882133cc755167268a984bc0ab3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kumar303/mohawk";
        license = licenses.mpl20;
        description = "Library for Hawk HTTP authorization";
      };
    };

    "more-itertools" = python.mkDerivation {
      name = "more-itertools-4.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c0/2f/6773347277d76c5ade4414a6c3f785ef27e7f5c4b0870ec7e888e66a8d83/more-itertools-4.2.0.tar.gz"; sha256 = "2b6b9893337bfd9166bee6a62c2b0c9fe7735dcf85948b387ec8cba30e85d8e8"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/erikrose/more-itertools";
        license = licenses.mit;
        description = "More routines for operating on iterables, beyond itertools";
      };
    };

    "mozdef-client" = python.mkDerivation {
      name = "mozdef-client-1.0.11";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/cd/9b/d783ba277e2120add2709e45db926f8e916c5933df2db9725b7787884ae5/mozdef_client-1.0.11.tar.gz"; sha256 = "86b8c7065c21ce07d3095b5772f70fa152fe97258cde22311e5db4e34f5be26d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."boto3"
      self."pytz"
      self."requests-futures"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gdestuynder/mozdef_client";
        license = licenses.mpl20;
        description = "A client library to send messages/events using MozDef";
      };
    };

    "mozilla-backend-common" = python.mkDerivation {
      name = "mozilla-backend-common-1.0.0";
      src = pkgs.lib.cleanSource ./../../lib/backend_common;
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
      self."Flask-Cache"
      self."Flask-Cors"
      self."Flask-Login"
      self."Flask-Migrate"
      self."Flask-SQLAlchemy"
      self."Jinja2"
      self."Logbook"
      self."SQLAlchemy"
      self."Werkzeug"
      self."blinker"
      self."boto"
      self."connexion"
      self."flask-oidc"
      self."flask-talisman"
      self."itsdangerous"
      self."kombu"
      self."mohawk"
      self."mozilla-cli-common"
      self."python-dateutil"
      self."python-jose"
      self."requests"
      self."taskcluster"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/garbas/mozilla-releng";
        license = "MPL2";
        description = "Services behind https://mozilla-releng.net";
      };
    };

    "mozilla-cli-common" = python.mkDerivation {
      name = "mozilla-cli-common-1.0.0";
      src = pkgs.lib.cleanSource ./../../lib/cli_common;
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Logbook"
      self."aioamqp"
      self."click"
      self."mozdef-client"
      self."python-dateutil"
      self."python-hglib"
      self."raven"
      self."structlog"
      self."taskcluster"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mozilla-releng/services";
        license = "MPL2";
        description = "Services behind https://mozilla-releng.net";
      };
    };

    "multidict" = python.mkDerivation {
      name = "multidict-4.3.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9d/b9/3cf1b908d7af6530209a7a16d71ab2734a736c3cdf0657e3a06d0209811e/multidict-4.3.1.tar.gz"; sha256 = "5ba766433c30d703f6b2c17eb0b6826c6f898e5f58d89373e235f07764952314"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/multidict";
        license = licenses.asl20;
        description = "multidict implementation";
      };
    };

    "mypy" = python.mkDerivation {
      name = "mypy-0.600";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/61/e7/9a56ab208992335c3f46f13764e751330b6643209488dbe3f680081cef37/mypy-0.600.tar.gz"; sha256 = "bc251cb31bc236d9fe4bcc442c994c45fff2541f7161ee52dc949741fe9ca3dd"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."typed-ast"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.mypy-lang.org/";
        license = licenses.mit;
        description = "Optional static typing for Python";
      };
    };

    "nose" = python.mkDerivation {
      name = "nose-1.3.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/58/a5/0dc93c3ec33f4e281849523a5a913fa1eea9a3068acfa754d44d88107a44/nose-1.3.7.tar.gz"; sha256 = "f1bffef9cbc82628f6e7d7b40d7e255aefaa1adb6a1b1d26c69a8b79e6208a98"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://readthedocs.org/docs/nose/";
        license = licenses.lgpl2;
        description = "nose extends unittest to make testing easier";
      };
    };

    "oauth2client" = python.mkDerivation {
      name = "oauth2client-4.1.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/50/30/f89a4fc014a03e180840d432e73ffb96da422f2a8094ff3539f0f0c46661/oauth2client-4.1.2.tar.gz"; sha256 = "bd3062c06f8b10c6ef7a890b22c2740e5f87d61b6e1f4b1c90d069cdfc9dadb5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."httplib2"
      self."pyasn1"
      self."pyasn1-modules"
      self."rsa"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/google/oauth2client/";
        license = licenses.asl20;
        description = "OAuth 2.0 client library";
      };
    };

    "parso" = python.mkDerivation {
      name = "parso-0.2.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4b/86/bc857ddcc892968b954620f18ce90a943368ee9fe84595911501da898798/parso-0.2.1.tar.gz"; sha256 = "f0604a40b96e062b0fd99cf134cc2d5cdf66939d0902f8267d938b0d5b26707f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/davidhalter/parso";
        license = licenses.mit;
        description = "A Python Parser";
      };
    };

    "pdbpp" = python.mkDerivation {
      name = "pdbpp-0.9.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e6/cc/8bf81f5e53daa4a90d696fa430c2f4e709656e2bf953686bd15c0746616f/pdbpp-0.9.2.tar.gz"; sha256 = "dde77326e4ea41439c243ed065826d53539530eeabd1b6615aae15cfbb9fda05"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Pygments"
      self."fancycompleter"
      self."wmctrl"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/antocuni/pdb";
        license = licenses.bsdOriginal;
        description = "pdb++, a drop-in replacement for pdb";
      };
    };

    "pexpect" = python.mkDerivation {
      name = "pexpect-4.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/89/43/07d07654ee3e25235d8cea4164cdee0ec39d1fda8e9203156ebe403ffda4/pexpect-4.6.0.tar.gz"; sha256 = "2a8e88259839571d1251d278476f3eec5db26deb73a70be5ed5dc5435e418aba"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ptyprocess"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pexpect.readthedocs.io/";
        license = licenses.isc;
        description = "Pexpect allows easy control of interactive console applications.";
      };
    };

    "pickleshare" = python.mkDerivation {
      name = "pickleshare-0.7.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/69/fe/dd137d84daa0fd13a709e448138e310d9ea93070620c9db5454e234af525/pickleshare-0.7.4.tar.gz"; sha256 = "84a9257227dfdd6fe1b4be1319096c20eb85ff1e82c7932f36efccfe1b09737b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pickleshare/pickleshare";
        license = licenses.mit;
        description = "Tiny 'shelve'-like database with concurrency support";
      };
    };

    "pluggy" = python.mkDerivation {
      name = "pluggy-0.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/11/bf/cbeb8cdfaffa9f2ea154a30ae31a9d04a1209312e2919138b4171a1f8199/pluggy-0.6.0.tar.gz"; sha256 = "7f8ae7f5bdf75671a718d2daf0a64b7885f74510bcd98b1a0bb420eb9a9d0cff"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pluggy";
        license = licenses.mit;
        description = "plugin and hook calling mechanisms for python";
      };
    };

    "prompt-toolkit" = python.mkDerivation {
      name = "prompt-toolkit-1.0.15";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8a/ad/cf6b128866e78ad6d7f1dc5b7f99885fb813393d9860778b2984582e81b5/prompt_toolkit-1.0.15.tar.gz"; sha256 = "858588f1983ca497f1cf4ffde01d978a3ea02b01c8a26a8bbc5cd2e66d816917"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
      self."wcwidth"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jonathanslenders/python-prompt-toolkit";
        license = licenses.bsdOriginal;
        description = "Library for building powerful interactive command lines in Python";
      };
    };

    "ptyprocess" = python.mkDerivation {
      name = "ptyprocess-0.5.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/51/83/5d07dc35534640b06f9d9f1a1d2bc2513fb9cc7595a1b0e28ae5477056ce/ptyprocess-0.5.2.tar.gz"; sha256 = "e64193f0047ad603b71f202332ab5527c5e52aa7c8b609704fc28c0dc20c4365"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pexpect/ptyprocess";
        license = "";
        description = "Run a subprocess in a pseudo terminal";
      };
    };

    "py" = python.mkDerivation {
      name = "py-1.5.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f7/84/b4c6e84672c4ceb94f727f3da8344037b62cee960d80e999b1cd9b832d83/py-1.5.3.tar.gz"; sha256 = "29c9fab495d7528e80ba1e343b958684f4ace687327e6f789a94bf3d1915f881"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://py.readthedocs.io/";
        license = licenses.mit;
        description = "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };

    "pyasn1" = python.mkDerivation {
      name = "pyasn1-0.4.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/0d/33/3466a3210321a02040e3ab2cd1ffc6f44664301a5d650a7e44be1dc341f2/pyasn1-0.4.3.tar.gz"; sha256 = "fb81622d8f3509f0026b0683fe90fea27be7284d3826a5f2edf97f69151ab0fc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/etingof/pyasn1";
        license = licenses.bsdOriginal;
        description = "ASN.1 types and codecs";
      };
    };

    "pyasn1-modules" = python.mkDerivation {
      name = "pyasn1-modules-0.2.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ab/76/36ab0e099e6bd27ed95b70c2c86c326d3affa59b9b535c63a2f892ac9f45/pyasn1-modules-0.2.1.tar.gz"; sha256 = "af00ea8f2022b6287dc375b2c70f31ab5af83989fc6fe9eacd4976ce26cd7ccc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pyasn1"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/etingof/pyasn1-modules";
        license = licenses.bsdOriginal;
        description = "A collection of ASN.1-based protocols modules.";
      };
    };

    "pycodestyle" = python.mkDerivation {
      name = "pycodestyle-2.3.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e1/88/0e2cbf412bd849ea6f1af1f97882add46a374f4ba1d2aea39353609150ad/pycodestyle-2.3.1.tar.gz"; sha256 = "682256a5b318149ca0d2a9185d365d8864a768a28db66a84a2ea946bcc426766"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pycodestyle.readthedocs.io/";
        license = licenses.mit;
        description = "Python style guide checker";
      };
    };

    "pyflakes" = python.mkDerivation {
      name = "pyflakes-1.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/26/85/f6a315cd3c1aa597fb3a04cc7d7dbea5b3cc66ea6bd13dfa0478bf4876e6/pyflakes-1.6.0.tar.gz"; sha256 = "8d616a382f243dbf19b54743f280b80198be0bca3a5396f1d2e1fca6223e8805"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/PyCQA/pyflakes";
        license = licenses.mit;
        description = "passive checker of Python programs";
      };
    };

    "pytest" = python.mkDerivation {
      name = "pytest-3.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/67/6a/5bcdc22f8dbada1d2910d6e1a3a03f6b14306c78f81122890735b28be4bf/pytest-3.6.0.tar.gz"; sha256 = "39555d023af3200d004d09e51b4dd9fdd828baa863cded3fd6ba2f29f757ae2d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."atomicwrites"
      self."attrs"
      self."more-itertools"
      self."pluggy"
      self."py"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pytest.org";
        license = licenses.mit;
        description = "pytest: simple powerful testing with Python";
      };
    };

    "pytest-asyncio" = python.mkDerivation {
      name = "pytest-asyncio-0.8.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c9/28/032baa7ba981928ec31faeb700b19fd7d3434bedff6aaff30b2e630dd82d/pytest-asyncio-0.8.0.tar.gz"; sha256 = "f32804bb58a66e13a3eda11f8942a71b1b6a30466b0d2ffe9214787aab0e172e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pytest-asyncio";
        license = licenses.asl20;
        description = "Pytest support for asyncio.";
      };
    };

    "pytest-cov" = python.mkDerivation {
      name = "pytest-cov-2.5.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/24/b4/7290d65b2f3633db51393bdf8ae66309b37620bc3ec116c5e357e3e37238/pytest-cov-2.5.1.tar.gz"; sha256 = "03aa752cf11db41d281ea1d807d954c4eda35cfa1b21d6971966cc041bbf6e2d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pytest-cov";
        license = licenses.bsdOriginal;
        description = "Pytest plugin for measuring coverage.";
      };
    };

    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.6.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/54/bb/f1db86504f7a49e1d9b9301531181b00a1c7325dc85a29160ee3eaa73a54/python-dateutil-2.6.1.tar.gz"; sha256 = "891c38b2a02f5bb1be3e4793866c8df49c7d19baabf9c1bad62547e0b4866aca"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://dateutil.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Extensions to the standard Python datetime module";
      };
    };

    "python-editor" = python.mkDerivation {
      name = "python-editor-1.0.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/65/1e/adf6e000ea5dc909aa420352d6ba37f16434c8a3c2fa030445411a1ed545/python-editor-1.0.3.tar.gz"; sha256 = "a3c066acee22a1c94f63938341d4fb374e3fdd69366ed6603d7b24bed1efc565"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/fmoo/python-editor";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Programmatically open an editor, capture the result.";
      };
    };

    "python-hglib" = python.mkDerivation {
      name = "python-hglib-2.6.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f9/39/4d8fa780f71347c3e25c6192f87e13a0265f44b9b8d0a36de550bf39e172/python-hglib-2.6.1.tar.gz"; sha256 = "7c1fa0cb4d332dd6ec8409b04787ceba4623e97fb378656f7cab0b996c6ca3b2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.mercurial-scm.org/wiki/PythonHglibs";
        license = licenses.mit;
        description = "Mercurial Python library";
      };
    };

    "python-jose" = python.mkDerivation {
      name = "python-jose-3.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f4/92/9f4c77930c18f02931b266229f865273283f8eaaf590ea2abd3f03f89f44/python-jose-3.0.0.tar.gz"; sha256 = "e8255fb3cc524c04f4c790547a6215468f2a32d3a866424175523359e69f3aeb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ecdsa"
      self."future"
      self."rsa"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/mpdavis/python-jose";
        license = licenses.mit;
        description = "JOSE implementation in Python";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2018.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/10/76/52efda4ef98e7544321fd8d5d512e11739c1df18b0649551aeccfb1c8376/pytz-2018.4.tar.gz"; sha256 = "c06425302f2cf668f1bba7a0a03f3c1d34d4ebeef2c72003da308b3947c7f749"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "raven" = python.mkDerivation {
      name = "raven-6.9.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8f/80/e8d734244fd377fd7d65275b27252642512ccabe7850105922116340a37b/raven-6.9.0.tar.gz"; sha256 = "3fd787d19ebb49919268f06f19310e8112d619ef364f7989246fc8753d469888"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
      self."Flask-Login"
      self."Logbook"
      self."aiohttp"
      self."blinker"
      self."coverage"
      self."flake8"
      self."nose"
      self."pytest"
      self."pytest-cov"
      self."pytz"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/getsentry/raven-python";
        license = licenses.bsdOriginal;
        description = "Raven is a client for Sentry (https://getsentry.com)";
      };
    };

    "redis" = python.mkDerivation {
      name = "redis-2.10.6";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/09/8d/6d34b75326bf96d4139a2ddd8e74b80840f800a0a79f9294399e212cb9a7/redis-2.10.6.tar.gz"; sha256 = "a22ca993cea2962dbb588f9f30d0015ac4afcc45bee27d3978c0dbe9e97c6c0f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/andymccurdy/redis-py";
        license = licenses.mit;
        description = "Python client for Redis key-value store";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.18.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b0/e1/eab4fc3752e3d240468a8c0b284607899d2fbfb236a56b7377a329aa8d09/requests-2.18.4.tar.gz"; sha256 = "9c443e7324ba5b85070c4a818ade28bfabedf16ea10206da1132edaa6dda237e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."certifi"
      self."chardet"
      self."idna"
      self."urllib3"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://python-requests.org";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };

    "requests-futures" = python.mkDerivation {
      name = "requests-futures-0.9.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/2c/f0/d9a6d4472286405956dd5ac6279fe932a86151df9816bc35afe601495819/requests-futures-0.9.7.tar.gz"; sha256 = "a9ca2c3480b6fac29ec5de59c146742e2ab2b60f8c68581766094edb52ea7bad"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ross/requests-futures";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Asynchronous Python HTTP for Humans.";
      };
    };

    "responses" = python.mkDerivation {
      name = "responses-0.9.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/67/cb/0a5390f7b8944cfa7e4079a839adba964d858d27a60af7b2683248148339/responses-0.9.0.tar.gz"; sha256 = "c6082710f4abfb60793899ca5f21e7ceb25aabf321560cc0726f8b59006811c9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cookies"
      self."coverage"
      self."flake8"
      self."pytest"
      self."pytest-cov"
      self."requests"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/getsentry/responses";
        license = licenses.asl20;
        description = "A utility library for mocking out the `requests` Python library.";
      };
    };

    "rq" = python.mkDerivation {
      name = "rq-0.10.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/06/2c/0766b2b102d3bef2bbf613b5db74f924924c6ad5ca15e2babbd828a4d904/rq-0.10.0.tar.gz"; sha256 = "31a5f04d1410111617ae78756b86fc6b0cf300fe7445843ea3758b86d9f67bc5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."click"
      self."redis"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/nvie/rq/";
        license = licenses.bsdOriginal;
        description = "RQ is a simple, lightweight, library for creating background jobs, and processing them.";
      };
    };

    "rsa" = python.mkDerivation {
      name = "rsa-3.4.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/14/89/adf8b72371e37f3ca69c6cb8ab6319d009c4a24b04a31399e5bd77d9bb57/rsa-3.4.2.tar.gz"; sha256 = "25df4e10c263fb88b5ace923dd84bf9aa7f5019687b5e55382ffcdb8bede9db5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pyasn1"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://stuvel.eu/rsa";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Pure-Python RSA implementation";
      };
    };

    "s3transfer" = python.mkDerivation {
      name = "s3transfer-0.1.13";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9a/66/c6a5ae4dbbaf253bd662921b805e4972451a6d214d0dc9fb3300cb642320/s3transfer-0.1.13.tar.gz"; sha256 = "90dc18e028989c609146e241ea153250be451e05ecc0c2832565231dacdf59c1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."botocore"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/s3transfer";
        license = licenses.asl20;
        description = "An Amazon S3 Transfer Manager";
      };
    };

    "simplegeneric" = python.mkDerivation {
      name = "simplegeneric-0.8.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/3d/57/4d9c9e3ae9a255cd4e1106bb57e24056d3d0709fc01b2e3e345898e49d5b/simplegeneric-0.8.1.zip"; sha256 = "dc972e06094b9af5b855b3df4a646395e43d1c9d0d39ed345b7393560d0b9173"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cheeseshop.python.org/pypi/simplegeneric";
        license = licenses.zpl21;
        description = "Simple generic functions (similar to Python's own len(), pickle.dump(), etc.)";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.11.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"; sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "slugid" = python.mkDerivation {
      name = "slugid-1.0.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/dd/96/b05c6d357f8d6932bea2b360537360517d1154b82cc71b8eccb70b28bdde/slugid-1.0.7.tar.gz"; sha256 = "6dab3c7eef0bb423fb54cb7752e0f466ddd0ee495b78b763be60e8a27f69e779"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://taskcluster.github.io/slugid.py";
        license = licenses.mpl20;
        description = "Base64 encoded uuid v4 slugs";
      };
    };

    "structlog" = python.mkDerivation {
      name = "structlog-18.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/2a/ba/de51bd39a473d6dc6dd98689d1e31cf2df24d16f7c09911bae895ed27f12/structlog-18.1.0.tar.gz"; sha256 = "ff1e7aae015b346060c03b1cc4a1f29d428de7d858eaf06ea93ee35ac51071a0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."pytest"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.structlog.org/";
        license = licenses.mit;
        description = "Structured Logging for Python";
      };
    };

    "swagger-spec-validator" = python.mkDerivation {
      name = "swagger-spec-validator-2.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e3/2f/3767da696617ee72190361805dff4bca68a611d4673de848857654789534/swagger-spec-validator-2.1.0.tar.gz"; sha256 = "dc9219c6572ce0def6e1c160ca253c0e7fcde75812628f0c0199334f85bd138e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."jsonschema"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/Yelp/swagger_spec_validator";
        license = licenses.asl20;
        description = "Validation of Swagger specifications";
      };
    };

    "taskcluster" = python.mkDerivation {
      name = "taskcluster-3.0.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/64/49/9758e26959454dce6d824a416fb84b990782c3303e39249fa792ea65106d/taskcluster-3.0.1.tar.gz"; sha256 = "ec7d5f9afb6462cc22b694d354fa8172142343c88e06212daaeeb06890ba17fb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."aiohttp"
      self."async-timeout"
      self."mohawk"
      self."requests"
      self."six"
      self."slugid"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/taskcluster/taskcluster-client.py";
        license = "";
        description = "Python client for Taskcluster";
      };
    };

    "testfixtures" = python.mkDerivation {
      name = "testfixtures-6.0.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/58/8d/0cbe2a577cb4d27825d7946514d627e0a40812ac95d587da039f58933004/testfixtures-6.0.2.tar.gz"; sha256 = "f8827cfc91e5cc9ac669727fdd48a85880f391b935a0a212b5cedb807879feec"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."coveralls"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Simplistix/testfixtures";
        license = licenses.mit;
        description = "A collection of helpers and mock objects for unit tests and doc tests.";
      };
    };

    "traitlets" = python.mkDerivation {
      name = "traitlets-4.3.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a5/98/7f5ef2fe9e9e071813aaf9cb91d1a732e0a68b6c44a32b38cb8e14c3f069/traitlets-4.3.2.tar.gz"; sha256 = "9c4bd2d267b7153df9152698efb1050a5d84982d3384a37b2c1f7723ba3e7835"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."decorator"
      self."ipython-genutils"
      self."pytest"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://ipython.org";
        license = licenses.bsdOriginal;
        description = "Traitlets Python config system";
      };
    };

    "typed-ast" = python.mkDerivation {
      name = "typed-ast-1.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/52/cf/2ebc7d282f026e21eed4987e42e10964a077c13cfc168b42f3573a7f178c/typed-ast-1.1.0.tar.gz"; sha256 = "57fe287f0cdd9ceaf69e7b71a2e94a24b5d268b35df251a88fef5cc241bf73aa"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/python/typed_ast";
        license = licenses.asl20;
        description = "a fork of Python 2 and 3 ast modules with type comment support";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.22";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ee/11/7c59620aceedcc1ef65e156cc5ce5a24ef87be4107c2b74458464e437a5d/urllib3-1.22.tar.gz"; sha256 = "cc44da8e1145637334317feebd728bd869a35285b93cbb4cca2577da7e62db4f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."certifi"
      self."idna"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };

    "vine" = python.mkDerivation {
      name = "vine-1.1.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/32/23/36284986e011f3c130d802c3c66abd8f1aef371eae110ddf80c5ae22e1ff/vine-1.1.4.tar.gz"; sha256 = "52116d59bc45392af9fdd3b75ed98ae48a93e822cee21e5fda249105c59a7a72"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/vine";
        license = licenses.bsdOriginal;
        description = "Promises, promises, promises.";
      };
    };

    "wcwidth" = python.mkDerivation {
      name = "wcwidth-0.1.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/55/11/e4a2bb08bb450fdbd42cc709dd40de4ed2c472cf0ccb9e64af22279c5495/wcwidth-0.1.7.tar.gz"; sha256 = "3df37372226d6e63e1b1e1eda15c594bca98a22d33a23832a90998faa96bc65e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jquast/wcwidth";
        license = licenses.mit;
        description = "Measures number of Terminal column cells of wide-character codes";
      };
    };

    "wmctrl" = python.mkDerivation {
      name = "wmctrl-0.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/01/c6/001aefbde5782d6f359af0a8782990c3f4e751e29518fbd59dc8dfc58b18/wmctrl-0.3.tar.gz"; sha256 = "d806f65ac1554366b6e31d29d7be2e8893996c0acbb2824bbf2b1f49cf628a13"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/antocuni/wmctrl";
        license = licenses.bsdOriginal;
        description = "A tool to programmatically control windows inside X";
      };
    };

    "yarl" = python.mkDerivation {
      name = "yarl-1.2.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/6b/0f/7551d131e3a116bdb8e23bde3f34613cd3ad719f28dcf996c922fe285925/yarl-1.2.4.tar.gz"; sha256 = "437c51e7e31d9fa462ad99f829fb8282eccba836d67868ab61a513d20ec467b7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."idna"
      self."multidict"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/yarl/";
        license = licenses.asl20;
        description = "Yet another URL library";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  overrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
    
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [overrides] else [] ) ++ commonOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )