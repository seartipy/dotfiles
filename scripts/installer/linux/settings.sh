function hidpi-conf {
    local xres=$(xdpyinfo | grep dimensions | uniq | awk '{print $2}' |  cut -d 'x' -f1)
    if [ $xres -ge 2800 ]; then
        gsettings set org.gnome.desktop.interface scaling-factor 2
        gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gdk/WindowScalingFactor': <2>}"
    fi
    if [ $xres -ge 3800 ]; then
        gsettings set org.gnome.desktop.interface text-scaling-factor .8
    fi
}

function gnome-extensions {
    if [ $(which gnome-shell) ] && [ $USER == "pervez" ]; then
        gsettings set org.gnome.shell disable-extension-version-validation "true"

        gsettings set org.gnome.shell enabled-extensions "['windowsNavigator@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com']"

        wget -O ~/bin/shell-extension-install https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnome-extension/shell-extension-install
        chmod +x ~/bin/shell-extension-install

        local gnomever=$(gnome-shell --version | awk '{print $3}' | cut -d'.' -f1-2)

        shell-extension-install $gnomever 294 # shellshape
        shell-extension-install $gnomever 97  # coverflow alt-tab
        shell-extension-install $gnomever 442 # drop down terminal
        shell-extension-install $gnomever 413 # app keys
        shell-extension-install $gnomever 361 # emacs manager

        gsettings --schemadir ~/.local/share/gnome-shell/extensions/drop-down-terminal@gs-extensions.zzrough.org/ set org.zzrough.gs-extensions.drop-down-terminal real-shortcut "['F11']"

        gsettings --schemadir ~/.local/share/gnome-shell/extensions/shellshape@gfxmonk.net/data/glib-2.0/schemas set org.gnome.shell.extensions.net.gfxmonk.shellshape.prefs default-layout 'vertical'
    fi
}

function gnome-settings-pervez {
    if [ $(which gnome-shell) ] && [ $USER == "pervez" ]; then
        gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "@as []"
        gsettings set org.gnome.desktop.wm.keybindings switch-input-source "@as []"
        gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "@as []"
        gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab']"
        gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver ''
        gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'ctrl:lctrl_meta']"
        gsettings set org.gnome.desktop.interface gtk-key-theme Emacs

        gsettings set org.gnome.desktop.privacy remove-old-temp-files true
        gsettings set org.gnome.desktop.privacy remove-old-trash-files true
        gsettings set  org.gnome.desktop.screensaver lock-enabled false
        gsettings set  org.gnome.desktop.screensaver ubuntu-lock-on-suspend false
        gsettings set org.gnome.desktop.interface clock-show-date true
        gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
        gsettings set org.gnome.shell.calendar show-weekdate true
        gsettings set org.gnome.SessionManager logout-prompt false

        [ -e ~/.config/gtk-3.0/settings.ini ] || printf "[Settings]\ngtk-application-prefer-dark-theme=1\n" > ~/.config/gtk-3.0/settings.ini
        gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 1800
        gsettings set org.gnome.desktop.session idle-delay 180
    fi
}

function gnome-settings-all {
    if [ $(which gnome-shell) ]; then
        dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/login-shell true
        gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false
        gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false
        gsettings set org.gnome.system.locale region 'en_US.UTF-8'
    fi
}

hidpi-conf
gnome-settings-all
gnome-settings-pervez
gnome-extensions
