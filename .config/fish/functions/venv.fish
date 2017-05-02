function venv
    switch (echo $argv[1])
    case "create"
        python3 -m venv "$HOME/.venvs/$argv[2]"
    case "use"
        source "$HOME/.venvs/$argv[2]/bin/activate.fish"
    case "*"
        echo "usage: venv create|use VENV"
    end
end

function venv2
    switch (echo $argv[1])
    case "create"
        python2 -m venv "$HOME/.venvs2/$argv[2]"
    case "use"
        source "$HOME/.venvs2/$argv[2]/bin/activate.fish"
    case "*"
        echo "usage: venv2 create|use VENV"
    end
end
