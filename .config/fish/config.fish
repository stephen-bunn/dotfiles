set fish_greeting
set -gx GPG_TTY (tty)
set -gx EDITOR nvim
set -gx TERMINAL alacritty
set -gx PYENV_ROOT $HOME/.pyenv
set -gx NVM_DIR $HOME/.nvm
set -gx LC_ALL en_US.UTF-8
set -gx VIRTUALFISH_HOME $HOME/.local/share/virtualenvs

# PATH updates
set -gx PATH $HOME/.local/bin $HOME/.diff-so-fancy/bin $PYENV_ROOT/shims $PYENV_ROOT/bin $HOME/.cargo/bin $PATH

alias top htop
alias vim nvim
alias vi nvim
alias v nvim

source $HOME/.config/fish/nnn.fish
source $HOME/.config/fish/fzf.fish
source $HOME/.config/fish/n.fish

pyenv init - | source
starship init fish | source
