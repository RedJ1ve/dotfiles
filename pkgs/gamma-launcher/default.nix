{
  pkgs,
  python311Packages,
  lib,
  inputs',
}:
python311Packages.buildPythonApplication rec {
  pname = "gamma-launcher";
  version = "1.7";

  src = pkgs.fetchFromGitHub {
    owner = "mord3rca";
    repo = "${pname}";
    rev = "6b282f527553f3a35c50d37b65929a50093d7474";
    sha256 = "sha256-BehMRnu+l/b/dlzwHDDW1Y7P4ulFAn+K/kBRV+oqfzI=";
  };

  build-system = with python311Packages; [
    setuptools
  ];

  dependencies = with python311Packages; [
    distutils
    inputs'.nixpkgs-py7zr.legacyPackages.python311Packages.py7zr
    # py7zr
    tqdm
  ];

  meta = {
    description = "S.T.A.L.K.E.R GAMMA Launcher";
    homepage = "https://github.com/Mord3rca/gamma-launcher";
    liscense = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    mainProgram = "gamma-launcher";
  };
}
