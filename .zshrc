case $- in
	*i*) ;;
	*) return;;
esac

autoload -Uz compinit && compinit
autoload -U colors && colors
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

zstyle ':completion:*' match-list 'm:{a-z}-{A-Za-z}'
zstyle ':completion:*' menu select

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt SHARE_HISTORY
setopt HIST_FIND_NO_DUPS

bindkey -v

export KEYTIMEOUT=1

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

autoload -Uz vcs_info
setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' formats ' (%b)'

function zle-keymap-select zle-line-init {
	case ${KEYMAP} in
		vicmd)
			echo -ne '\e[1 q'
			VI_MODE='%F{yellow}[N]%f'
			;;
		viins|main)
			echo -ne '\e[5 q'
			VI_MODE='%F{green}[I]%f'
			;;
		esac
		zle reset-prompt
	}
zle -N zle-line-init
zle -N zle-keymap-select

echo -ne '\e[5 q'

precmd() { vcs_info }
PROMPT='%F{yellow}%n@%F{magenta}%m%f ${VI_MODE} %F{magenta}%~%f%F{red}${vcs_info_msg_0_}$f 
%F{green}%# %f%F{gray}'

export PATH=$PATH:/sbin/:/usr/sbin:~/go/bin/:~/.local/bin/:/usr/local/go/bin/:~/Scripts:~/.cargo/bin/
#export GITUSER
#export REPOS
#export GHREPOS
#export DOTFILES
#export IRCNICK
#export IRCSERVER
export SCRIPTS
export SNIPPETS
export HELP_BROWSER=w3m
export CLICOLOR=1
export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi
export HRULEWIDTH=101
export GOPATH="$HOME/.local/go"
export GOBIN="$HOME/.local/bin"
export GOPROXY=direct
#export NVIM_SCREENKEY=1
export CGO_ENABLED=0
export PYTHONDONTWRITEBYTECODE=2
export LC_COLLATE=C
export CFLAGS="-Wall -Wextra -Werror -O2 -g -fsanitize=address -fno-omit-frame-point -finstrument-functions"

if (( ${+commands[dircolors]} )); then
	if [[ -r "$HOME/.dir_colors" ]]; then
		eval "$(dircolors -b "$HOME/.dir_colors")"
	else
		eval "$(dircolors -b)"
	fi
fi

setopt DOTGLOB

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
	source /usr/share/git-core/contrib/completion/git-prompt.sh
elif [ -f /etc/zsh_completion.d/git-prompt ]; then
	source /etc/zsh_completion.d/git-prompt
fi

unalias -a
alias l="ls"
alias la="ls -al"
alias '?'=duck
alias '??'=google 
alias dot='cd $DOTFILES'
alias scripts='cd $SCRIPTS'
alias snippets='cd $SNIPPETS'
alias ls='ls -h --color=auto'
alias free='free-h'
alias df='df -h'
alias diff='diff --color'
alias temp='cd $(mktemp -d)'
alias view='vi -R'
alias grep='pcregrep'

. "$HOME/.local/bin/env"
. "$HOME/.cargo/env"
