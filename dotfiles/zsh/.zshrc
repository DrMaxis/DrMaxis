# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)


alias branches="git branch --all "									# List both remote-tracking branches and local branches.

alias remotes="git remote --verbose" 								# Be a little more verbose and show remote url after name.

alias contributors="git shortlog --summary --numbered"	            # List contributors with number of commits

alias amend="git commit --amend --no-edit"					        # Amend the currently staged files to the latest commit.

alias go="!f() { git checkout -b \"$1\" 2> /dev/null || git checkout \"$1\"; }; f"	# Switch to a branch, creating it if necessary

alias fb="!f() { git branch -a --contains $1; }; f"             # Find branches containing commit									

alias ft="!f() { git describe --always --contains $1; }; f"		# Find tags containing commit				

alias fc="!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short -S$1; }; f"			# Find commits by source code

alias fm="!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short --grep=$1; }; f" 	# Find commits by commit message

alias dm="!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d" # Remove branches that have already been merged with master (a.k.a. ‘delete merged’)

alias s="git status"					

alias sb="git status -s -b"													    
  
alias cl="clear"

alias ga="git add"

# Exa
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"

# HTTP requests with xh!
alias http="xh"

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# VIM

alias v="/opt/homebrew/bin/nvim"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Ranger

function ranger {
	local IFS=$'\t\n'
	local tempfile="$(mktemp -t tmp.XXXXXX)"
	local ranger_cmd=(
		command
		ranger
		--cmd="map Q chain shell echo %d > "$tempfile"; quitall"
	)

	${ranger_cmd[@]} "$@"
	if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
		cd -- "$(cat "$tempfile")" || return
	fi
	command rm -f -- "$tempfile" 2>/dev/null
}

alias rr='ranger'

# Navigation

cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# ZSHRC

alias zshconfig="v ~/.zshrc"
alias ohmyzsh="v ~/.oh-my-zsh"


# Sources

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"


source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
