if test -z "$CONN_DATA"
    if test -z "$XDG_DATA_HOME"
        set -U CONN_DATA_DIR "$HOME/.local/share/conn"
    else
        set -U CONN_DATA_DIR "$XDG_DATA_HOME/conn"
    end
    set -U CONN_DATA "$CONN_DATA_DIR/data"
end

if test ! -e "$CONN_DATA"
    if test ! -e "$CONN_DATA_DIR"
        mkdir -p -m 700 "$CONN_DATA_DIR"
    end
    touch "$CONN_DATA"
end

if test -z "$CONN_CMD"
    set -U CONN_CMD conn
end

if test ! -z $CONN_CMD
    function $CONN_CMD -d "Connect to server"
        __conn $argv
    end
end

