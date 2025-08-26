# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins - make sure 'forgit' plugin is cloned to ~/.oh-my-zsh/custom/plugins/forgit
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting 
    fast-syntax-highlighting
    zsh-autocomplete
    forgit
    )

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"


# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Use fd (a faster alternative to find) for fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git --exclude node_modules"

# Customize fzf UI
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --preview 'bat --style=numbers --color=always --line-range :500 {}'
  --preview-window=right:60%
"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Forgit configuration to use delta for previews
#export FORGIT_DIFF_PREVIEW_COMMAND='delta'
#export FORGIT_LOG_PREVIEW_COMMAND='delta'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# ---- ALIASES ----
alias cd="z"
alias config="/usr/bin/git --git-dir=/home/linuxer/.cfg/ --work-tree=/home/linuxer"
alias activate-pyenv='source ~/py-env/bin/activate'
