#!/usr/bin/python3

import sys
from functools import partial
from subprocess import run


fzf_flags = [
    "-d 35%",
    "--multi",
    "--exit-0",
    "--cycle",
    "--reverse",
    "--bind='ctrl-r:toggle-all'",
    "--bind='ctrl-s:toggle-sort'",
    "--no-preview",
]
r = partial(run, shell=True, capture_output=True)
p = r('tmux capture-pane -pJ | grep -v "$(id -un)@$(hostname)" | sed "/^\s*$/d" | sort -u')

if p.stdout == b'':
    sys.exit(1)

lines = map(lambda x: x.strip(), p.stdout.decode().splitlines())
proc_in = '\n'.join(lines).encode()
p = r(['fzf-tmux', *fzf_flags], input=proc_in)
if p.stdout == b'':
    sys.exit(1)
r(['wl-copy'], input=p.stdout.strip())
