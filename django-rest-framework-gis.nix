{ lib
, fetchFromGitHub
, buildPythonPackage
, setuptools
, wheel
, djangorestframework
, six
}:

buildPythonPackage rec {
  pname = "django-rest-framework-gis";
  version = "0.13.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "3nids";
    repo = "django-rest-framework-gis";
    rev = "93d9718d123c2158f4d1c5f6cf461ba8f6cf89e7";
    hash = "sha256-7mI2vQ8f8RsTQ4U+QfRjfyuZpz+xVttOAfx36pl85fE=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  propagatedBuildInputs = [
    djangorestframework
    six
  ];

  pythonImportsCheck = [ "rest_framework_gis" ];

  meta = with lib; {
    description = "Geographic add-ons for Django REST Framework. Maintained by the OpenWISP Project";
    homepage = "https://github.com/3nids/django-rest-framework-gis";
    changelog = "https://github.com/3nids/django-rest-framework-gis/blob/${src.rev}/CHANGES.rst";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "django-rest-framework-gis";
  };
}
