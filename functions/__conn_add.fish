function __conn_add -d "Add new server"
    set -l options n/name= u/user= h/host= d/dynamic help
    if not argparse -n add $options -- $argv
        return 1
    end

    if set -q _flag_help
        __conn_help add
        return 0
    end

    set -l missing
    for req in _flag_name _flag_user _flag_host
        if not set -q $req
            set missing $missing (string replace "_flag_" "" $req)
        end
    end

    if test -n "$missing"
        echo "add: missing required option(s): $missing" >&2
        return 1
    end

    # Build host
    set -l user $_flag_user
    set -l name $_flag_name
    set -l host_value $_flag_host

    if set -q _flag_dynamic
        set host_value "{{id}}.$host_value"
    end

    set -l tmpfile (mktemp $CONN_DATA.XXXXXX)

    # If the data file exists, read it. If not, still allow adding the first entry.
    if test -f $CONN_DATA
        command awk -F "|" -v name="$name" -v user="$user" -v host="$host_value" '
            BEGIN { found=0 }
            {
                if ($1 == name) {
                    found=1
                }
                print
            }
            END {
                if (found) {
                    print "Error: server name \"" name "\" already exists" > "/dev/stderr"
                    exit 1
                }
                print name "|" user "|" host
            }
        ' "$CONN_DATA" >"$tmpfile"
    else
        echo "$name|$user|$host_value" >"$tmpfile"
    end

    if test $status -eq 0
        if test -n "$CONN_OWNER"
            chown $CONN_OWNER:(id -ng $CONN_OWNER) $tmpfile
        end
        command mv $tmpfile $CONN_DATA
        or command rm $tmpfile
    else
        command rm $tmpfile
    end
end
