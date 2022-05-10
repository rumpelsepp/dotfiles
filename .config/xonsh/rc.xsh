import re
from prompt_toolkit.keys import Keys
from xonsh.built_ins import XSH

# https://stackoverflow.com/a/50790119
url_regex = re.compile(r'\b((?:https?://)?(?:(?:www\.)?(?:[\da-z\.-]+)\.(?:[a-z]{2,6})|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:(?:[0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?:(?::[0-9a-fA-F]{1,4}){1,6})|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(?:ffff(?::0{1,4}){0,1}:){0,1}(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])))(?::[0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])?(?:/[\w\.-]*)*/?)\b')

# https://github.com/xonsh/xonsh/issues/3639#issuecomment-654215680
@events.on_ptk_create
def alt_right_fill_word_suggestion(bindings, **kw):
    import re
    from prompt_toolkit.application.current import get_app
    from prompt_toolkit.filters import Condition

    @Condition
    def suggestion_available():
        app = get_app()
        return (
            app.current_buffer.suggestion is not None and app.current_buffer.suggestion.text
            and app.current_buffer.document.is_cursor_at_the_end
        )

    @bindings.add("escape", "right", filter=suggestion_available)
    def _fill(event):
        """
        Fill partial suggestion.
        """
        b = event.current_buffer

        t = re.split(r"([^\s/]+[\s/]+)", b.suggestion.text)
        b.insert_text(next(x for x in t if x))


def fzf_tmux_buffer() -> str:
    fzf_flags = [
        "-d" "35%",
        "--multi",
        "--exit-0",
        "--cycle",
        "--reverse",
        "--bind=ctrl-r:toggle-all",
        "--bind=ctrl-s:toggle-sort",
        "--no-preview",
    ]
    lines = sorted(set($(tmux capture-pane -pJ).strip().splitlines()))
    if len(lines) == 0:
        return ""
    return $(echo @('\n'.join(lines)) | fzf-tmux -p -- @(fzf_flags)).strip()


def url_popup() -> None:
    buffer = $(tmux capture-pane -pJ)
    urls = set(url_regex.findall(buffer))
    if len(urls) == 0:
        return
    $(tmux display-popup echo @('\n'.join(urls)))


def poetry_shell():
    from pathlib import Path
    source @(Path($(poetry env info -p).strip()).joinpath("bin/activate.xsh"))


env = XSH.env
if $(gsettings get org.gnome.desktop.interface color-scheme).strip() == "'prefer-dark'":
    env["LS_COLORS"] = 'rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:'
env["DYNAMIC_CWD_WIDTH"] = "30%"
env["AUTO_PUSHD"] = True

aliases['hd'] = "hexdump -C"
aliases['la'] = "ls -lah"
aliases['ip'] = "ip --color=auto"
aliases['now'] = "date +%F_%T"
aliases['now-raw'] = "date +%Y%m%d%H%M"
aliases['today'] = "date +%F"
aliases['o'] = "gio open"

xontrib load prompt_ret_code
xontrib load fish_completer
