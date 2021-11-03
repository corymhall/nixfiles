{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    neovim-nightly
    gopls
    nodePackages.pyright
  ];

  programs.neovim = {
    package = pkgs.neovim-nightly;
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraConfig = ''
      if &compatible
              set nocompatible
      endif
      lua require("init")
    '';
  };

  xdg.configFile."nvim/lua".source = ../configs/neovim/lua;
  xdg.configFile."nvim/ftdetect".source = ../configs/neovim/ftdetect;
  xdg.configFile."nvim/ftplugin".source = ../configs/neovim/ftplugin;}
