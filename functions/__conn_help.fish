function __conn_help -d "Print help" --argument-names cmd
    function __print_help --argument-names usage desc
        set pad 20
        # Build the printf format string dynamically
        set fmt (string join "" "%" "-" $pad "s")
        set usage_str (printf $fmt $usage)

        # Wrap the description at terminal width, indenting subsequent lines
        set term_width (tput cols)
        set wrap_width (math $term_width - $pad)

        set line ""
        for word in (string split " " $desc)
            if test (string length -- $line) -eq 0
                set line $word
            else if test (math (string length -- $line) + (string length -- $word) + 1) -gt $wrap_width
                printf "%s%s\n" "$usage_str" "$line"
                set usage_str (printf $fmt "")
                set line $word
            else
                set line "$line $word"
            end
        end
        if test -n "$line"
            printf "%s%s\n" "$usage_str" "$line"
        end
    end

    switch "$cmd"
        case general
            printf "Usage: conn [<server_name>|<COMMAND>]\n"
            __print_help "<server_name>" "Connect to a server define in $CONN_DATA"
            __print_help "[--id]" "Require id when host is dynamic"
            __print_help "[--user]" "Login as this user instead of saved user"
            __print_help "[--extra-args='ssh opts']" "Define extra SSH args"
            printf "--- COMMANDS ---\n"
            __print_help add "Add new server into $CONN_DATA"
            __print_help "ls/list" "List servers"
        case add
            printf "Usage: conn add [OPTIONS]\n"
            __print_help "-n, --name" "Specify the unique name for server"
            __print_help "-u, --user" "Specify the login user"
            __print_help "-h, --host" "Specify the server hostname"
            __print_help "-d, --dynamic" "Use placeholder '{{id}}' in hostname. e.g., '{{id}}.example.com'"
    end
end
