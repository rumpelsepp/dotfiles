from prompt_toolkit.keys import Keys
from xonsh.built_ins import XSH


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


# TODO
def fzf_tmux_buffer():
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
    # lines="$(tmux capture-pane -pJ | sed '/^\s*$/d' | sort -ur)"
    # selection="$(fzf-tmux -p -- "${fzf_flags[@]}" <<< "$lines" | sed -E 's/^\s+|\s+$//g' | tr -d "\n")"
    # echo "$selection"


@events.on_ptk_create
def custom_keybindings(bindings, **kw):

    @bindings.add(Keys.ControlF)
    def fzf_tmux_buffer(event):
        selection = $(fzf-tmux-buffer.sh).strip()
        event.current_buffer.insert_text(selection)


def _pass_search(args):
    $[gopass list -f | grep @(args)]


aliases['pass_search'] = _pass_search


def _poetry_shell():
    from pathlib import Path
    p = $(poetry env info -p)
    source @(Path(p.strip()).joinpath("bin/activate.xsh"))


aliases['poetry_shell'] = _poetry_shell


env = XSH.env
env["LS_COLORS"] = 'rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:'
env["DYNAMIC_CWD_WIDTH"] = "20%"
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
