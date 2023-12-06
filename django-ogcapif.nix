{ lib
, fetchPypi
, fetchFromGitHub
, buildPythonPackage
, setuptools
, setuptools-scm
, wheel
, django
, django-computedfields
, djangorestframework
, djangorestframework-gis
, psycopg2
, pyproj
, pyyaml
, transifex-client
, uritemplate
, git
}:

buildPythonPackage rec {
  pname = "django-ogcapif";
  version = "0.2.1";
  pyproject = true;

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  postPatch = ''
    substituteInPlace requirements.txt --replace 'git+https://github.com/3nids/django-rest-framework-gis@93d9718d123c2158f4d1c5f6cf461ba8f6cf89e7' django-rest-framework-gis
  '';

  # PyPI release is broken (package name is django_ogcapif but it tries to
  # import stuff from django_oapif)
  # src = fetchPypi {
  #   inherit pname version;
  #   hash = "sha256-Dm+n+XvMIp7s9Kns8a6WufIp1neclNYS4c44/d0yu+Q=";
  # };

  src = fetchFromGitHub {
    owner = "opengisch";
    repo = "django-ogcapif";
    rev = "refs/tags/${version}";
    hash = "sha256-NMlDGermVxzFhWn87VOLmgekq6bjkfKPnMXCYq4PV14=";
  };

  nativeBuildInputs = [
    git
    setuptools
    setuptools-scm
    wheel
  ];

  propagatedBuildInputs = [
    django
    django-computedfields
    djangorestframework
    djangorestframework-gis
    psycopg2
    pyproj
    pyyaml
    transifex-client
    uritemplate
  ];

  # passthru.optional-dependencies = with python3.pkgs; {
  #   dev = [
  #     debugpy
  #     django-debug-toolbar
  #     flameprof
  #     gprof2dot
  #     pre-commit
  #   ];
  # };

  pythonImportsCheck = [ "django_oapif" ];

  meta = with lib; {
    description = "Easily expose your Django models through an OGCAPI-Features endpoint";
    homepage = "https://pypi.org/project/django-ogcapif/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "django-ogcapif";
  };
}
