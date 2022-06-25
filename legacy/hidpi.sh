gnome_hidpi() {
    is_linux || return 1
    has_cmd gnome-session || return 1
    has_cmd gsettings || return 1

    slog "Setting gnome HIDPI"
    gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gdk/WindowScalingFactor': <2>}"

    local xres=$(xdpyinfo | grep dimensions | uniq | awk '{print $2}' |  cut -d 'x' -f1)
    [ "$xres" -ge 2800 ] && gsettings set org.gnome.desktop.interface scaling-factor 2
    [ "$xres" -ge 3840 ] && gsettings set org.gnome.desktop.interface text-scaling-factor .9
}

mate_hidpi() {
    slog "Setting mate HIDPI"
    dconf write /org/mate/desktop/font-rendering/dpi "160.0"
}

x11_hidpi() {
    slog "Setting X11 HIDPI(~/.Xresources)"
    scopy ~/.seartipy/templates/desktops/xresources ~/.Xresources
}

hidpi_install() {
    gnome_hidpi
    mate_hidpi
    x11_hidpi
}
