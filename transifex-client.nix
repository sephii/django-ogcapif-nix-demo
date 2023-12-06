{ lib
, python3
, fetchPypi
, gitpython
, python-slugify
, requests
, six
, urllib3
, setuptools
, wheel
, buildPythonPackage
}:

buildPythonPackage rec {
  pname = "transifex-client";
  version = "0.14.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-EdyVzv6Q6/DO83ScjH2FudOJwFvQ4zib8RdoXfVivVw=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  propagatedBuildInputs = [
    gitpython
    python-slugify
    requests
    six
    urllib3
  ];

  pythonImportsCheck = [ "txclib" ];

  meta = with lib; {
    description = "A command line interface for Transifex";
    homepage = "https://pypi.org/project/transifex-client/#history";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ ];
    mainProgram = "transifex-client";
  };
}
