{ lib
, fetchPypi
, buildPythonPackage
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "django-computedfields";
  version = "0.2.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-VGqZr8fS6d87HSm9weqkprADp1rRYvYuUt2JMZxZVpI=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  pythonImportsCheck = [ "computedfields" ];

  meta = with lib; {
    description = "Autoupdated database fields for model methods";
    homepage = "https://pypi.org/project/django-computedfields/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "django-computedfields";
  };
}
