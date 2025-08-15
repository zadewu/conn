# ===== Default: conn <TAB> (server names) =====
complete \
    --command $CONN_CMD \
    --no-files \
    --arguments "($CONN_CMD list --nameonly --noheader)" \
    --condition "not __fish_seen_subcommand_from add list ls"

# ===== Subcommand: add =====
complete \
    --command $CONN_CMD \
    --exclusive \
    --condition __fish_use_subcommand \
    --arguments add \
    --description "Add servers"

# Options for `conn add`
complete \
    --command $CONN_CMD \
    --exclusive \
    --condition '__fish_seen_subcommand_from add' \
    --short n --long name \
    --description "Server name"

complete \
    --command $CONN_CMD \
    --exclusive \
    --condition '__fish_seen_subcommand_from add' \
    --short u --long user \
    --description "Login user"

complete \
    --command $CONN_CMD \
    --exclusive \
    --condition '__fish_seen_subcommand_from add' \
    --short h --long host \
    --description "Server host"

complete \
    --command $CONN_CMD \
    --exclusive \
    --condition '__fish_seen_subcommand_from add; and __fish_seen_argument --host; and not __fish_seen_argument --dynamic' \
    --short d --long dynamic \
    --description "Mark host as dynamic ({{id}}.host)"

# ===== Subcommand: list / ls =====
complete \
    --command $CONN_CMD \
    --exclusive \
    --condition __fish_use_subcommand \
    --arguments "list/ls" \
    --description "List servers"

# Options for `conn list` and `conn ls`
complete \
    --command $CONN_CMD \
    --exclusive \
    --condition '__fish_seen_subcommand_from list ls' \
    --long nameonly \
    --description "Show only names"

complete \
    --command $CONN_CMD \
    --exclusive \
    --condition '__fish_seen_subcommand_from list ls' \
    --long noheader \
    --description "Hide table header"
