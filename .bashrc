#!/usr/bin/bash

# check for interactive tty
case $- in
  *i*) ;; # interactive
  *) return ;;
esac


# ---------- local utility functions

_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

# better compatibility and portability
# env vars
export PATH=$PATH:/sbin/:/usr/sbin:~/go/bin/:~/.local/bin/:/opt/nvim-linux64/bin:/usr/local/go/bin:~/Scripts:~/.cache/rebar3/bin/:~/.cargo/bin/:~/.rakubrew/bin/
export XDG_RUNTIME_DIR=/run/user/`id -u` # for sway. there is probably a better way to do this.
export EDITOR=vim
export GITUSER="$USER"
export REPOS="$HOME/Repos"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dot"
export SCRIPTS="$DOTFILES/scripts"
export SNIPPETS="$DOTFILES/snippets"
export HELP_BROWSER=lynx
export DESKTOP="$HOME/Desktop"
export DOCUMENTS="$HOME/Documents"
export DOWNLOADS="$HOME/Downloads"
export TEMPLATES="$HOME/Templates"
export PUBLIC="$HOME/Public"
export PRIVATE="$HOME/Private"
export PICTURES="$HOME/Pictures"
export MUSIC="$HOME/Music"
#export VIDEOS="$HOME/Videos"
export PDFS="$HOME/usb/pdfs"
export VIRTUALMACHINES="$HOME/VirtualMachines"
export WORKSPACES="$HOME/Workspaces" # container home dirs for mounting
export TERM=xterm-256color
export HRULEWIDTH=73
export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"
export GOPROXY=direct
export CGO_ENABLED=0
export PYTHONDONTWRITEBYTECODE=2
export LC_COLLATE=C
export CFLAGS="-Wall -Wextra -Werror -O2 -g -fsanitize=address -fno-omit-frame-pointer -finstrument-functions"

export LESS_TERMCAP_mb="[35m" # magenta
export LESS_TERMCAP_md="[33m" # yellow
export LESS_TERMCAP_me="" # "0m"
export LESS_TERMCAP_se="" # "0m"
export LESS_TERMCAP_so="[34m" # blue
export LESS_TERMCAP_ue="" # "0m"
export LESS_TERMCAP_us="[4m"  # underline

# IRC vars
# investigate this later
#export IRCNICK="cwiggins"
#export IRCSERVER="irc.libera.chat"

# clear screen
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

[[ -d /.vim/spell ]] && export VIMSPELL=("$HOME/.vim/spell/*.add")

# dircolors
if _have dircolors; then
  if [[ -r "$HOME/.dir_colors" ]]; then
    eval "$(dircolors -b "$HOME/.dir_colors")"
  else
    eval "$(dircolors -b)"
  fi 
fi

# shell options
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob

stty stop undef # disable control-s accidental stops

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000

shopt -s histappend



if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
elif [ -f /etc/bash_completion.d/git-prompt ]; then
  source /etc/bash_completion.d/git-prompt
fi
 # ------- BASH PROMPT--------
 # stole from from rob muhlstein 
 # https://github.com/rwxrob/dot

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
	local P='$' dir="${PWD##*/}" B countme short long double \
		r='\[\e[31m\]' h='\[\e[34m\]' \
		u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
		b='\[\e[36m\]' x='\[\e[0m\]' \
		g="\[\033[38;2;90;82;76m\]"

	[[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
	[[ $PWD = / ]] && dir=/
	[[ $PWD = "$HOME" ]] && dir='~'

	B=$(git branch --show-current 2>/dev/null)
	[[ $dir = "$B" ]] && B=.
	countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

	[[ $B == master || $B == main ]] && b="$r"
	[[ -n "$B" ]] && B="$g($b$B$g)"

	short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
	long="${g}╔$u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n${g}╚$p$P$x "
	double="${g}╔$u\u$g$PROMPT_AT$h\h$g:$w$dir\n${g}║$B\n${g}╚$p$P$x "

	if ((${#countme} > PROMPT_MAX)); then
		PS1="$double"
	elif ((${#countme} > PROMPT_LONG)); then
		PS1="$long"
	else
		PS1="$short"
	fi

        [[ "$VENVS[$PWD]}" =~ ^y ]] && PS1="{PS1//\$/🐍}"

	if _have tmux && [[ -n "$TMUX" ]]; then
		tmux rename-window "$(wd)"
	fi
}

wd() {
	dir="${PWD##*/}"
	parent="${PWD%"/${dir}"}"
	parent="${parent##*/}"
	echo "$parent/$dir"
} && export wd

found-venv() { test -e .venv/bin/activate; }
venv-is-on() { [[ "$(which python)" =~ \.venv\/bin\/python$ ]]; }

declare -A VENVS
export VENVS

llenv() {
  found-venv || return
  venv-is-on && return
  test -n "${VENVS[$PWD]}" && return
  read -rp "Want to activate the .venv? [Y/N]" answer
  answer=${answer,,}
  test -z "$answer" && answer=y
  VENVS["$PWD"]="$answer"
  if [[ $answer =~ ^y ]]; then
    . .venv/bin/activate
  fi 
}

PROMPT_COMMAND="llenv; __ps1"

# aliases
unalias -a
alias l="ls"
alias la="ls -al"
alias '?'=duck
alias '??'=google
alias '???'=bing
alias dot='cd $DOTFILES'
alias scripts='cd $SCRIPTS'
alias snippets='cd $SNIPPETS'
alias ls='ls -h --color=auto'
alias free='free -h'
alias df='df -h'
alias chmox='chmod +x'
alias diff='diff --color'
alias sshh='sshpass -f $HOME/.sshpass ssh '
alias temp='cd $(mktemp -d)'
alias view='vi -R' # which is usually linked to vim
alias clear='printf "\e[H\e[2J"'
alias c='printf "\e[H\e[2J"'
alias coin="clip '(yes|no)'"
alias grep="pcregrep"
_have btop && alias top=btop
alias iam=live
_have fastfetch && alias fetch=fastfetch
_have fastfetch && alias neofetch=fastfetch
alias neo='neo -D'
alias suod=sudo
alias sduo=sudo
alias glance=glances
alias wttr='curl wttr.in'
alias price='curl rate.sx/btc'
alias evi='vi $HOME/.vimrc'
alias ewez='vi $HOME/.wezterm.lua'
alias ebash='vi $HOME/.bashrc'

_have doas && alias sudo=doas

_have lynx && alias lynx='lynx -cfg=~/.config/lynx/lynx.cfg'
_have podman && alias docker=podman

_have weechat && alias irc='weechat'

_have vim && alias vi=vim && EDITOR=vim
_have nvim && alias vi=nvim && EDITOR=nvim
_have gcal && alias cal=gcal

#set -o vi

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

. "$HOME/.local/bin/env"
. "$HOME/.cargo/env"
eval "$(/home/cwiggins123/.rakubrew/bin/rakubrew init Bash)"
