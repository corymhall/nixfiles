# Shell configuration for tmux

{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    #terminal = "xterm-256color";
    secureSocket = false;
    keyMode = "vi";
    #newSession = true;
    #prefix = "C-a";
    shell = "\$SHELL";
    terminal = "screen-256color";
    #shortcut = "a";

    #extraConfig = builtins.readFile ./tmux/tmux.conf;
    plugins = with pkgs; [
      #tmuxPlugins.resurrect
      tmuxPlugins.cpu
      tmuxPlugins.yank
      tmuxPlugins.pain-control
      tmuxPlugins.prefix-highlight
      tmuxPlugins.sessionist
      tmuxPlugins.extrakto
      #tmuxPlugins.nord
      #{
        #plugin = tmuxPlugins.continuum;
        #extraConfig = ''
          #set -g @continuum-restore 'on'
          #set -g @continuum-boot 'on'
          #set -g @continuum-save-interval '10'
          #set -g @resurrect-capture-pane-contents 'on'
        #'';
      #}
    ];
    extraConfig = ''
#unbind C-b
set-option -g prefix C-b
bind-key -n C-a send-prefix

# hide status bar on demand
bind C-s if -F '#{s/off//:status}' 'set status off' 'set status on'

bind-key -r i run-shell "tmux neww bash ~/tmux-cht.sh"
bind-key -r K run-shell "tmux-sessionizer /home/hallcor/work/aws-cdk"
bind-key -r N run-shell "tmux-sessionizer /home/hallcor/personal/nixfiles"

set -g base-index 1

bind r source-file ~/.config/tmux/tmux.conf

bind | split-window -h
bind - split-window -v
bind c new-window -c "#{pane_current_path}"
unbind '"'
unbind %

bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

bind C-j display-popup -E "\
    tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
    sed '/^$/d' |\
    fzf --reverse --header jump-to-session --preview 'tmux capture-pane -pt {}'  |\
    xargs tmux switch-client -t"

# switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
set-option -sa terminal-overrides ',xterm-256color:RGB'
set -g mouse on
set-option -sg escape-time 0
set-option -ga terminal-overrides ",*Tc"

# https://raw.githubusercontent.com/sainnhe/dotfiles/master/.tmux/tmuxline/everforest-dark.tmux.conf
set -g status-justify "left"
set -g status "on"
set -g status-left-style "none"
set -g message-command-style "fg=#999f93,bg=#4a555b"
set -g status-right-style "none"
set -g pane-active-border-style "fg=#a7c080"
set -g status-style "none,bg=#374247"
set -g message-style "fg=#999f93,bg=#4a555b"
set -g pane-border-style "fg=#4a555b"
set -g status-right-length "100"
set -g status-left-length "100"
setw -g window-status-activity-style "none,fg=#a7c080,bg=#374247"
setw -g window-status-separator ""
setw -g window-status-style "none,fg=#999f93,bg=#374247"

set -g status-bg black

#black=#868d80
#green=#a7c080
#cyan=#87c095
#white=#d8caac
#background=#323d43

#+-------+
#+ Status +
#+-------+
#+--- Bars ---+
# - nord everforest
set -g status-left "#[fg=#2f383e,bg=#a7c080] #S #[fg=#a7c080,bg=black,nobold,noitalics,nounderscore]"
set -g status-right "#{prefix_highlight}#[fg=#323d43,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=#323d43] %Y-%m-%d #[fg=white,bg=#323d43,nobold,noitalics,nounderscore]#[fg=white,bg=#323d43] %H:%M #[fg=#a7c080,bg=#323d43,nobold,noitalics,nounderscore]#[fg=#323d43,bg=#a7c080,bold] #H "

#+--- Windows ---+
# - nord everforest
set -g window-status-format "#[fg=black,bg=#323d43,nobold,noitalics,nounderscore] #[fg=white,bg=#323d43]#I #[fg=white,bg=#323d43,nobold,noitalics,nounderscore] #[fg=white,bg=#323d43]#W #F #[fg=#323d43,bg=black,nobold,noitalics,nounderscore]"
set -g window-status-current-format "#[fg=black,bg=cyan,nobold,noitalics,nounderscore] #[fg=black,bg=cyan]#I #[fg=black,bg=cyan,nobold,noitalics,nounderscore] #[fg=black,bg=cyan]#W #F #[fg=cyan,bg=black,nobold,noitalics,nounderscore]"
set -g window-status-separator ""


# https://github.com/arcticicestudio/nord-tmux/blob/develop/src/nord-status-content.conf
#+----------------+
#+ Plugin Support +
#+----------------+
#+--- tmux-prefix-highlight ---+
set -g @prefix_highlight_output_prefix "#[fg=brightcyan]#[bg=black]#[nobold]#[noitalics]#[nounderscore]#[bg=brightcyan]#[fg=black]"
set -g @prefix_highlight_output_suffix ""
set -g @prefix_highlight_copy_mode_attr "fg=brightcyan,bg=black,bold"
    '';
  };
  home.file."tmux-cht.sh".source = ../configs/cht.sh/tmux-cht.sh;
  home.file.".tmux-cht-languages".source = ../configs/cht.sh/tmux-cht-languages;
  home.file.".tmux-cht-command".source = ../configs/cht.sh/tmux-cht-command;
}
