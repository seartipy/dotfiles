#! /bin/bash
{

lxde_install() {
    is_linux || return 1

    slog "lxde setup"

    is_ubuntu && sudo apt-get install -y rofi

    fcopy ~/seartipy/dotfiles/templates/desktops/lxde/lubuntu-rc.xml ~/.config/openbox/lubuntu-rc.xml
    fcopy ~/seartipy/dotfiles/templates/desktops/lxde/lubuntu-rc.xml ~/.config/openbox/lxde-rc.xml
    fcopy ~/seartipy/dotfiles/templates/desktops/lxde/autostart ~/.config/lxsession/Lubuntu/autostart
}

xfce_install() {
    is_linux || return 1

    slog "xfce setup"

    is_ubuntu && sudo apt-get install -y rofi

    fcopy ~/seartipy/dotfiles/templates/desktops/xfce4/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
    fcopy ~/seartipy/dotfiles/templates/desktops/xfce4/xsettings.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    fcopy ~/seartipy/dotfiles/templates/desktops/xfce4/xfwm4.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
}

}
