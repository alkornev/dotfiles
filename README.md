Inspired by https://github.com/awnion/dotfiles

## Zellij

With `zellij` installed on `PATH`, new interactive Zsh terminals automatically
create or attach to the persistent `main` session. All terminal windows use that
same session. Closing a terminal detaches its client and leaves panes and their
processes running; reopening a terminal reattaches to them.

Use `Ctrl-o`, then `d` to detach to the outer shell. `Ctrl-q` quits the session
instead of preserving its running processes. Session persistence here applies
to closing terminals, not to keeping processes alive across a reboot.

Run `ZELLIJ_AUTO_START=false zsh` for a plain shell, or set
`ZELLIJ_AUTO_SESSION=work` before launching Zsh to use another session name.
Startup is skipped inside Zellij or tmux, for non-terminal input/output, and for
shell commands run with `zsh -c` (including `zsh -ic`).

