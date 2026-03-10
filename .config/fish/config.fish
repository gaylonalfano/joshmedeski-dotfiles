#
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly command line
# https://fishshell.com/
# cSpell:words shellcode pkgx direnv

# brew shellenv cached in conf.d/brew.fish
# Regenerate with: /opt/homebrew/bin/brew shellenv > ~/.config/fish/conf.d/brew.fish

if status --is-interactive
    if not set -q TMUX
        sesh_start
    end
end

# TODO: waiting for fish support
# https://github.com/pkgxdev/pkgx/issues/845
# source (pkgx --shellcode)

command -q starship; and starship init fish | source # https://starship.rs/
command -q zoxide; and zoxide init fish | source # 'ajeetdsouza/zoxide'
command -q fzf; and fzf --fish | source
command -q fnm; and fnm --log-level quiet env --use-on-cd | source # "Schniz/fnm"
command -q direnv; and direnv hook fish | source # https://direnv.net/
command -q fx; and fx --comp fish | source # https://fx.wtf/
set -g direnv_fish_mode eval_on_arrow # trigger direnv at prompt, and on every arrow-based directory change (default)

set -U fish_greeting # disable fish greeting
# FIX: sesh connect won't actually start tmux
# function fish_greeting
#     if test -n "$TMUX"
#         return
#     else
#       sesh connect \"\$(sesh list -i | fzf --no-sort --ansi --prompt '⚡  ' --no-border --bind 'tab:down,btab:up' --preview-window 'right:60%:noborder' --preview 'sesh preview {}')\"
#     end
# end


set -U fish_key_bindings fish_vi_key_bindings
# set -U LANG en_US.UTF-8
# set -U LC_ALL en_US.UTF-8

set -Ux BAT_THEME "Catppuccin Latte" # 'sharkdp/bat' cat clone
set -Ux EDITOR nvim # 'neovim/neovim' text editor
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"

set -Ux FZF_DEFAULT_OPTS (printf '%s ' \
    '--layout=reverse' \
    '--info=hidden' \
    '--ansi' \
    '--pointer=👉' \
    '--gutter=" "' \
    '--color=current-bg:-1' \
    '--color=current-fg:blue' \
    '--color=gutter:-1' \
    '--color=header-bg:-1' \
    '--color=header-border:cyan' \
    '--color=hl+:yellow' \
    '--color=hl:yellow' \
    '--color=input-border:yellow' \
    '--color=list-border:blue' \
    '--color=pointer:blue' \
    '--color=preview-border:cyan' | string collect)

# NOTE: "noborus/ov" 🎑Feature-rich terminal-based text viewer. It is a so-called terminal pager.
# set -Ux PAGER ov
# TODO: fix colors of nvimpager
# set -Ux PAGER "~/.local/bin/nvimpager" # 'lucc/nvimpager'
set -e PAGER nvimpager
# set -Ux PAGER 'bat --paging=always'


# golang - https://golang.google.cn/
set -Ux GOPATH "$HOME/go"
fish_add_path $GOPATH/bin
fish_add_path $HOME/.rustup/toolchains/nightly-aarch64-apple-darwin/bin

fish_add_path $HOME/.config/bin # my custom scripts
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/Library/Python/3.9/bin
fish_add_path $HOME/.local/share/bob/nvim-bin

# github-copilot-cli not installed, removed dynamic lookup

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
#     eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" hook $argv | source
# else
#     if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
#         . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
#     else
#         set -x PATH /opt/homebrew/Caskroom/miniconda/base/bin $PATH
#     end
# end
# # <<< conda initialize <<<
export PATH="/Users/joshmedeski/.gdvm/bin/current_godot:/Users/joshmedeski/.gdvm/bin:$PATH"


# Mole completions cached in completions/mole.fish
# Regenerate with: mole completion fish > ~/.config/fish/completions/mole.fish
