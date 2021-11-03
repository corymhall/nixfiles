{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, importlib-metadata
, jsonpickle
, wrapt
, requests
, future
, botocore
}:

buildPythonPackage rec {
  pname = "git-remote-codecommit";
  version = "1.15.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "cd99d44a94f9adf8c5f15110d830f62af5fe644030fecc0df68cbda4880a5214";
  };

  propagatedBuildInputs = [
    jsonpickle wrapt requests future botocore
  ] ++ lib.optionals (pythonOlder "3.8") [
    importlib-metadata
  ];

  meta = {
    description = "An implementation of Git Remote Helper that makes it easier to interact with AWS CodeCommit";
    license = lib.licenses.asl20;
    homepage = "https://github.com/aws/git-remote-codecommit";
  };

  doCheck = false;
}
