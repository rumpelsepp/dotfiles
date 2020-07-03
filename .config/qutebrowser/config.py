## Documentation:
##   qute://help/configuring.html
##   qute://help/settings.html

## This is here so configs done via the GUI are still loaded.
## Remove it to not load settings done via the GUI.
config.load_autoconfig()

c.content.default_encoding = 'utf-8'
c.content.host_blocking.whitelist = []
# c.qt.highdpi = True
c.scrolling.bar = 'always'
c.tabs.background = True
c.hints.chars = 'uiaeosnrtdy'
c.editor.command = ['alacritty', '-e', 'nvim', '-f', '{file}', '-c', 'normal {line}G{column0}l']

# Open base URL of the searchengine if a searchengine shortcut is
# invoked without parameters.
c.url.open_base_url = True

c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'dict': 'https://dict.cc/?s={}',
    'man': 'https://manpages.debian.org/{}',
    'deb': 'https://packages.debian.org/search?keywords={}&searchon=names&suite=stable',
    "aw": "https://wiki.archlinux.org/?search={}",
}

# Format to use for the tab title. The following placeholders are
# defined:
#   * `{perc}`: Percentage as a string like `[10%]`.
#   * `{perc_raw}`: Raw percentage, e.g. `10`.
#   * `{current_title}`: Title of the current web page.
#   * `{title_sep}`: The string ` - ` if a title is set, empty otherwise.
#   * `{index}`: Index of this tab. * `{id}`: Internal tab ID of this tab.
#   * `{scroll_pos}`: Page scroll position:
#   * `{host}`: Host of the current web page.
#   * `{backend}`: Either ''webkit'' or ''webengine''
#   * `{private}`: Indicates when private mode is enabled.
#   * `{current_url}`: URL of the current web page.
#   * `{protocol}`: Protocol (http/https/...) of the current web page.
#   * `{audio}`: Indicator for audio/mute status.
# c.tabs.title.format = '{audio}{index}: {title}'
# Removed percentage, annoying in gnome notifications.
c.window.title_format = '{current_title}{title_sep}qutebrowser'

## Bindings for normal mode
config.bind('<Ctrl-l>', 'set-cmd-text :open -t -r {url:pretty}')
config.bind('<Alt-left>', 'back')
config.bind('<Alt-right>', 'forward')
config.bind('<Ctrl-right>', 'tab-next')
config.bind('<Ctrl-left>', 'tab-prev')
config.bind('m', 'spawn umpv {url}')
config.bind('M', 'hint links spawn umpv {hint-url}')
config.bind(';M', ';M hint --rapid links spawn umpv {hint-url}')

