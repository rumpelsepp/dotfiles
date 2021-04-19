# type: ignore

# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

config.load_autoconfig()

c.qt.highdpi = True
c.scrolling.bar = 'always'
c.hints.chars = 'uiaeosnrtdy'
c.editor.command = [
    'foot',
    '--log-level warning',
    'nvim',
    '-f', '{file}',
    '-c', 'normal {line}G{column0}l',
]

# Open base URL of the searchengine if a searchengine shortcut is
# invoked without parameters.
c.url.open_base_url = True

c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'dict': 'https://dict.cc/?s={}',
    "aw": "https://wiki.archlinux.org/?search={}",
}

# Bindings for normal mode
config.bind('<Ctrl-l>', 'set-cmd-text :open -t -r {url:pretty}')
config.bind('<Alt-left>', 'back')
config.bind('<Alt-right>', 'forward')
config.bind('<Ctrl-right>', 'tab-next')
config.bind('<Ctrl-left>', 'tab-prev')
config.bind('<Ctrl-Shift-right>', 'tab-move +')
config.bind('<Ctrl-Shift-left>', 'tab-move -')
config.bind(',m', 'spawn mpv {url}')
config.bind(',M', 'hint links spawn mpv {hint-url}')
