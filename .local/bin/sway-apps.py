#!/usr/bin/python3

import json
from subprocess import Popen, PIPE, run
import re
import sys


def get_tree():
    proc = run(['swaymsg', '-t', 'get_tree'], capture_output=True)
    return json.loads(proc.stdout)


def traverse(data, out):
    if 'nodes' not in data:
        return

    if data['type'] == 'con':
        if 'window_properties' in data:
            props = data['window_properties']
            out.append((f'{props["class"]}: {props["title"]}'))
        elif 'app_id' in data and 'app_id' != '':
            out.append((f'{data["app_id"]}: {data["name"]}'))

    for node in data['nodes']:
        if 'nodes' in node:
            traverse(node, out)


def main():
    apps = []
    traverse(get_tree(), apps)
    in_data = '\n'.join(apps).encode()

    with Popen(['fzf'], stdout=PIPE, stdin=PIPE) as proc:
        stdout, _ = proc.communicate(in_data)
        if proc.returncode != 0:
            sys.exit(1)
        app = re.escape(stdout.decode().split(':')[1].strip())

    run(['swaymsg', f'[title="{app}"] focus'])


if __name__ == '__main__':
    main()
