flush_stdin() {
    while read -s -e -t 1; do : ; done
}

read_line() {
    local line=''
    flush_stdin

    read -p "$1" line
    echo "$line"
}

ask_yN() {
    flush_stdin
    local yn=''
    read -p "$1 ([y/N])" -n 1 -r
    echo
    case "$REPLY" in
        y|Y ) echo "yes";;
        * ) echo "no"
    esac
}

ask_Yn() {
    flush_stdin
    local yn=''
    read -p "$1 ([y/N])" -n 1 -r
    echo
    case "$REPLY" in
        n|N ) echo "no";;
        * ) echo "yes"
    esac
}

git_interactive() {
    local user_name=$(read_line "Enter git user name : ")
    git config --global user.name "$user_name"

    local email_id=$(read_line "Enter git email id : ")
    git config --global user.email "$email_id"
}
