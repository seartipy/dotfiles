alias srm=rm -f

create_emacs_apps() {
    cat <<EOF  | osacompile -o /Applications/EmacsDaemon.app
tell application "Terminal"
   do shell script "/Applications/Emacs.app/Contents/MacOS/Emacs --daemon"
end tell
EOF

    cat <<EOF | osacompile -o /Applications/EmacsClient.app
tell application "Terminal"
    try
        do shell script "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c -n &"
        tell application "Emacs" to activate
    on error
        do shell script "/Applications/Emacs.app/Contents/MacOS/Emacs"
    end try
end tell
EOF

}

create_emacs_commands() {
    srm ~/bin/emacs
    echo '/Applications/Emacs.app/Contents/MacOS/Emacs "$@"' > ~/bin/emacs
    chmod +x ~/bin/emacs
    srm ~/bin/emacsclient
    ln -s /Applications/Emacs.app/Contents/MacOS/bin/emacsclient ~/bin/emacsclient
}

set_icon() {
    local iconSource=$1
    local iconDestination=$2
    local icon=/tmp/`basename $iconSource`
    local rsrc=/tmp/icon.rsrc

    srm $rsrc $icon

    # Create icon from the iconSource
    cp $iconSource $icon

    # Add icon to image file, meaning use itself as the icon
    sips -i $icon

    # Take that icon and put it into a rsrc file
    DeRez -only icns $icon > $rsrc

    # Apply the rsrc file to
    SetFile -a C $iconDestination

    if [ -f $iconDestination ]; then
        # Destination is a file
        Rez -append $rsrc -o $iconDestination
    elif [ -d $iconDestination ]; then
        # Destination is a directory
        # Create the magical Icon\r file
        touch $iconDestination/$'Icon\r'
        Rez -append $rsrc -o $iconDestination/Icon?
        SetFile -a V $iconDestination/Icon?
    fi

    srm $rsrc $icon
}

set_emacs_icons() {
    curl -L https://raw.githubusercontent.com/nashamri/spacemacs-logo/master/spacemacs.icns > ~/spacemacs.icns

    [[ -f ~/spacemacs.icns ]] || return 1
    set_icon ~/spacemacs.icns /Applications/EmacsDaemon.app
    set_icon ~/spacemacs.icns /Applications/EmacsClient.app

    srm ~/spacemacs.icns
}
