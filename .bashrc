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
export PATH=$PATH:/sbin/:/usr/sbin:~/go/bin/:~/.local/bin/:/opt/nvim-linux64/bin:/usr/local/go/bin:~/Scripts:/usr/local/plan9
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
export VIDEOS="$HOME/Videos"
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
export CFLAGS="-Wall -Wextra -Werror -O0 -g -fsanitize=address -fno-omit-frame-pointer -finstrument-functions"

export LESS_TERMCAP_mb="[35m" # magenta
export LESS_TERMCAP_md="[33m" # yellow
export LESS_TERMCAP_me="" # "0m"
export LESS_TERMCAP_se="" # "0m"
export LESS_TERMCAP_so="[34m" # blue
export LESS_TERMCAP_ue="" # "0m"
export LESS_TERMCAP_us="[4m"  # underline

# IRC vars
# investigate this later
#export IRCNICK="TGG"
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

# --------------------------- smart prompt ---------------------------
#                 (keeping in bashrc for portability)
#                 totally didn't steal this from rob muhlstein
#                 https://rwxrob.github.io/

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
  local P='$' dir="${PWD##*/}" B countme short long double\
    r='\[\e[32m\]' g='\[\e[34m\]' h='\[\e[33m\]' \
    u='\[\e[32m\]' p='\[\e[32m\]' w='\[\e[32m\]' \
    b='\[\e[33m\]' x='\[\e[0m\]'

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  B=$(git branch --show-current 2>/dev/null)
  [[ $dir = "$B" ]] && B=.
  countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

  [[ $B = master || $B = main ]] && b="$r"
  [[ -n "$B" ]] && B="$g($b$B$g)"

  short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
  long="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n$g╚ $p$P$x "
  double="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "

  if (( ${#countme} > PROMPT_MAX )); then
    PS1="$double"
  elif (( ${#countme} > PROMPT_LONG )); then
    PS1="$long"
  else
    PS1="$short"
  fi
}

PROMPT_COMMAND="__ps1"

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
#alias grep="pcregrep"
_have btop && alias top=btop
alias iam=live
alias fetch=fastfetch
alias neofetch=fastfetch
alias suod=sudo
alias sduo=sudo
alias glance=glances
alias wttr='curl wttr.in'
alias price='curl rate.sx/btc'
alias evi='vi $HOME/.vimrc'
alias ewez='vi $HOME/.wezterm.lua'
alias ebash='vi $HOME/.bashrc'
alias c='clear'

_have lynx && alias lynx='lynx -cfg=~/.config/lynx/lynx.cfg'
_have podman && alias docker=podman

_have epic5 && alias irc='epic5'

_have vim && alias vi=vim && EDITOR=vim
_have nvim && alias vi=nvim && EDITOR=nvim
_have gcal && alias cal=gcal

set -o vi

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

PATH="$HOME/.raku/bin${PATH:+:${PATH}}"; export PATH;
