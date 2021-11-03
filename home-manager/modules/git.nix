{ config, lib, pkgs, ... }:

let
in {
  programs.git = {
    enable = true;
    userName = "corymhall";
    userEmail = "43035978+corymhall@users.noreply.github.com";
    extraConfig = {
      core.editor = "nvim";
      credential.helper = "store";
      push.default = "simple";
      pull.rebase = true;
      fetch.prune = true;
      diff.colorMoved = "zebra";
      github.user = "corymhall";
      init.defaultBranch = "main";
      commit.template = "~/.gitmessage";
    };
  };
  home.file.".gitmessage".source = ../configs/git/gitmessage;
}
