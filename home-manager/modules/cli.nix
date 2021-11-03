{ config, pkgs, libs, ... }:

let
  tmux-cdk = pkgs.writeShellScriptBin "tmux-cdk" ''${builtins.readFile ../configs/bin/cdk}'';
  tmux-cdk-build = pkgs.writeShellScriptBin "tmux-cdk-build" ''${builtins.readFile ../configs/bin/tmux-cdk-build}'';
  tmux-windowizer = pkgs.writeShellScriptBin "tmux-windowizer" ''${builtins.readFile ../configs/bin/tmux-windowizer}'';
  tmux-sender = pkgs.writeShellScriptBin "tmux-sender" ''${builtins.readFile ../configs/bin/tmux-sender}'';
  tmux-sessionizer = pkgs.writeShellScriptBin "tmux-sessionizer" ''${builtins.readFile ../configs/bin/tmux-sessionizer}'';
  shellAliases = {
    nv = "nvim";
    nb = "npm run build";
    gst = "git status";
    gpsup = "git push --set-upstream origin $(git_current_branch)";
    gcm = "git checkout main";
    gcmsg = "git commit -m";
    gp = "git push";
    gl = "git pull";
    gcam = "git commit -a -m";
    gco = "git checkout";
    gcb = "git checkout -b";
    switch = "nix-shell --run \"home-manager switch\"";
    ga = "git add";
    gcl = "git clone";
    canl = "av ss -- aws codeartifact login --tool npm --repository node --namespace @codeartifact --domain hallcor";
    capl ="av ss -- aws codeartifact login --tool pip --repository python --domain hallcor";
  };
in {
  home.packages = with pkgs; [
    tmux-cdk
    tmux-cdk-build
    tmux-sessionizer
    tmux-windowizer
    tmux-sender
    gcc
    fzf
    zsh
    ripgrep
    zplug
    bat
    tmux
    direnv
    awscli2
    yarn
    nodejs-14_x
    aws-vault
    gh
    unzip
    graphviz
    glances
    hugo
    xclip
    tree
    gnumake
    stdenv
    zip
    terraform
    terraformls
    fd
    maven
    adoptopenjdk-openj9-bin-11
    ncdu
  ];

  #programs.direnv = {
  #  enable = true;
  #  enableZshIntegration = true;
  #};

  nixpkgs.config.allowUnfree = true;
  # programs.java = {
  #   enable = true;
  # };

  programs.bash = {
    enable = true;
    sessionVariables = rec {
      PATH = "$HOME/.npm-packages/bin:$PATH";
      EDITOR = "vim";
      AWSCDK = "$HOME/work/aws-cdk";
    };
  };

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;

    #defaultKeymap = "vi";
    history.extended = true;

    sessionVariables = rec {
      PATH = "$HOME/.npm-packages/bin:$PATH";
      KEYTIMEOUT = "1";
      ENHANCD_FILTER = "fzf";
      ENHANCD_COMPLETION_BEHAVIOR = "list";
      EDITOR = "vim";
      AWSCDK = "$HOME/work/aws-cdk";
    };

    zplug = {
      enable = true;
      plugins = [
        {
          name = "zsh-users/zsh-autosuggestions";
        }
        {
          name = "zsh-users/zsh-completions";
        }
        #{
        #  name = "agkozak/zsh-z";
        #}
        {
          name = "changyuheng/fz";
          tags = [
              "defer:1"
          ];
        }
        {
          name = "rupa/z";
          tags = [
            "use:z.sh"
          ];
        }
        {
          name = "b4b4r07/enhancd";
          tags = [
              "use:init.sh"
          ];
        }
        {
          name = "zpm-zsh/ls";
        }
        {
          name = "romkatv/powerlevel10k";
          tags = [
            "as:theme"
            "depth:1"
          ];
        }
        {
          name = "zdharma/fast-syntax-highlighting";
          tags = [
            "defer:2"
          ];
        }
        {
          name = "zsh-users/zsh-history-substring-search";
        }
      ];
    };


    # Called whenever zsh is initialized
    initExtra = ''
      export PATH="$HOME/go/bin:$PATH"
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "\$\{XDG_CACHE_HOME:-\$HOME/.cache\}/p10k-instant-prompt-\$\{(%):-%n\}.zsh" ]]; then
      source "\$\{XDG_CACHE_HOME:-\$HOME/.cache\}/p10k-instant-prompt-\$\{(%):-%n\}.zsh"
      fi


      # Load secrets
      [ -f ~/.localrc ] && . ~/.localrc
      # Nix setup (environment variables, etc.)
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi

      # functions
      function av() {aws-vault --backend=file exec "$@[1, -1]"}

      function p() { fd -t d "$1" | fzf | cd }

      # vim mode
      bindkey -v
      bindkey '^ ' autosuggest-accept
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # `v` is already mapped to visual mode, so we need to use a different key to
      # # open Vim
      bindkey -M vicmd "^V" edit-command-line

      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.config/.p10k.zsh ]] || source ~/.config/.p10k.zsh

      # enable aws cli autocomplete
      autoload bashcompinit && bashcompinit
      complete -C '$(which aws_completer)' aws
    '';

    envExtra = ''

    '';
    };

  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  xdg.configFile.".p10k.zsh".source = ../configs/p10k/p10k.zsh;
  xdg.configFile."dircolors".source = pkgs.LS_COLORS.outPath + "/src/dir_colors";
  xdg.configFile."kitty/kitty.conf".source = ../configs/terminal/kitty.conf;
  home.file.".npmrc".source = ../configs/npm/npmrc;

}
