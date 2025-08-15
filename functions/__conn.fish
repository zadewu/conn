function __conn -d "Connect to server" --argument-names cmd
    switch "$cmd"
        case "" --help
            __conn_help general
        case add
            __conn_add $argv[2..-1]
        case ls list
            __conn_list $argv[2..-1]
        case \*
            set -l options id= extra-args= user=
            if not argparse $options -- $argv
                return 1
            end

            set -l server_name (string trim -- (string split ' ' -- (string join ' ' $argv))[1])

            if test -z "$server_name"
                __conn_help general
                return 0
            end

            if not test -f "$CONN_DATA"
                echo "No server list found at $CONN_DATA"
                return 1
            end

            set -l line (grep -E "^$server_name\|" "$CONN_DATA")
            if test -z "$line"
                echo "Error: No server with name '$server_name' found. Use [add] command to add new server."
                echo ""
                __conn_help add
                return 1
            end

            set -l name (echo $line | cut -d'|' -f1)
            set -l user (echo $line | cut -d'|' -f2)
            set -l host (echo $line | cut -d'|' -f3)

            if string match -q "*{{id}}*" $host
                if not set -q _flag_id
                    echo "Error: Server requires --id=value"
                    return 1
                end
                set host (string replace '{{id}}' $_flag_id $host)
            end
            if set -q _flag_user
                set user $_flag_user
            end

            # Split --extra-args into separate args
            set -l extra_args
            if set -q _flag_extra_args
                set extra_args (string split -- ' ' $_flag_extra_args)
            end

            echo "Running: ssh $user@$host $extra_args"
            command ssh $user@$host $extra_args
    end
end
