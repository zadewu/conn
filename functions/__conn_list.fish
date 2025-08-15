function __conn_list -d "List servers in $CONN_DATA"
    if not test -f $CONN_DATA
        echo "No servers found."
        return 1
    end
    set -l options noheader nameonly
    argparse $options -- $argv

    set -l name_only 0
    if set -q _flag_nameonly
        set name_only 1
    end

    # Print header
    set -l print_header 1
    if set -q _flag_noheader
        set print_header 0
    end

    if test $print_header -eq 1
        printf "%-20s %-10s %-40s\n" "NAME" "USER" "HOST"
        printf "%-20s %-10s %-40s\n" "----" "----" "----"
    end
    # Read each line, split on '|', and print with padding
    if test $name_only -eq 0
        while read -l line
            set -l fields (string split '|' $line)
            printf "%-20s %-10s %-40s\n" $fields[1] $fields[2] $fields[3]
        end < $CONN_DATA
    else
        while read -l line
            set -l fields (string split '|' $line)
            printf "%s\n" $fields[1]
        end < $CONN_DATA
    end
end