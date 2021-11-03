{ config, pkgs, libs, ... }:

let
  my-python-package = ps: ps.callPackage ../packages/git-remote-codecommit.nix {};
  python-with-my-packages = pkgs.python3.withPackages(ps: with ps; [
    (my-python-package ps)
    pip
    flake8
  ]);


in {
  home.packages = with pkgs; [
    dotnet-sdk_3
    poetry
    python-with-my-packages
  ];

  programs.go = {
    enable = true;
    goPrivate = ["github.com/corymhall"];
  };

}
