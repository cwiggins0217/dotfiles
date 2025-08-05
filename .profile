if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

. "$HOME/.local/bin/env"

# opam configuration
test -r /home/cwiggins/.opam/opam-init/init.sh && . /home/cwiggins/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
