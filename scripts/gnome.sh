shell_extension_install() {
    has_cmd unzip || return 1

    # set gnome shell extension site URL
    local GNOME_SITE="https://extensions.gnome.org"

    # gnome shell target version
    local GNOME_VERSION="$1"

    # set extension ID (from command line parameter)
    local EXTENSION_ID="$2"

    # installation path is in user home directory
    local EXTENSION_PATH="$HOME/.local/share/gnome-shell/extensions";
    smd "$EXTENSION_PATH"

    # get extension description
    wget --quiet --header='Accept-Encoding:none' -O /tmp/extension.txt "${GNOME_SITE}/extension-info/?pk=${EXTENSION_ID}&shell_version=${GNOME_VERSION}"

    # get extension UUID
    EXTENSION_UUID=$(cat /tmp/extension.txt | grep "uuid" | sed 's/^.*uuid[\": ]*\([^\"]*\).*$/\1/')

    if ls "$EXTENSION_PATH" | grep "$EXTENSION_UUID" > /dev/null; then
        return 1
    fi

    # get extension download URL
    EXTENSION_URL=$(cat /tmp/extension.txt | grep "download_url" | sed 's/^.*download_url[\": ]*\([^\"]*\).*$/\1/')

    if [ "$EXTENSION_URL" != "" ]; then
        # download extension archive
        wget --quiet --header='Accept-Encoding:none' -O /tmp/extension.zip "${GNOME_SITE}${EXTENSION_URL}"

        # unzip extension to installation folder
        mkdir -p "${EXTENSION_PATH}/${EXTENSION_UUID}"
        unzip -n /tmp/extension.zip -d "${EXTENSION_PATH}/${EXTENSION_UUID}"

        # list enabled extensions
        EXTENSION_LIST=$(gsettings get org.gnome.shell enabled-extensions | sed 's/^.\(.*\).$/\1/')

        # check if extension is already enabled
        EXTENSION_ENABLED=$(echo ${EXTENSION_LIST} | grep ${EXTENSION_UUID})

        if [ "$EXTENSION_ENABLED" = "" ]; then
            # enable extension
            gsettings set org.gnome.shell enabled-extensions "[${EXTENSION_LIST},'${EXTENSION_UUID}']"

            # extension is not available
            echo "Extension with ID ${EXTENSION_ID} has been enabled. Restart Gnome Shell to take effect."
        fi
    else
        # extension is not available
        echo "Extension with ID ${EXTENSION_ID} is not available for Gnome Shell ${GNOME_VERSION}"
    fi

    # remove temporary files
    rm -f /tmp/extension.txt
    rm -f /tmp/extension.zip
}

gnome_extensions() {
    is_linux || return 1
    has_cmd gnome-session || return 1
    has_cmd gnome-shell || return 1

    if is_ubuntu; then
        sudo apt-get install -y chrome-gnome-shell
    fi

    gsettings set org.gnome.shell disable-extension-version-validation "true"

    local gnomever=$(gnome-shell --version | awk '{print $3}' | cut -d'.' -f1-2)

    shell_extension_install $gnomever 10   # window navigator
    shell_extension_install $gnomever 21   # workspace indicator
    shell_extension_install $gnomever 28   # gtile
    shell_extension_install $gnomever 97   # coverflow alt-tab
    shell_extension_install $gnomever 294  # shellshape
    # shell_extension_install $gnomever 413  # app keys like unity
    shell_extension_install $gnomever 442  # drop down terminal
    shell_extension_install $gnomever 657  # shelltile
    shell_extension_install $gnomever 690  # easy screen casting
    shell_extension_install $gnomever 704  # all windows in top bar
    shell_extension_install $gnomever 885  # transparent top bar
    shell_extension_install $gnomever 973  # app switcher
    shell_extension_install $gnomever 1018 # text scaler
    shell_extension_install $gnomever 1036 # enable/disable extensions
    shell_extension_install $gnomever 1160 # dash to dock
    shell_extension_install $gnomever 1166 # extension update notifier

    gsettings set org.gnome.shell enabled-extensions "['windowsNavigator@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com', 'CoverflowAltTab@palatis.blogspot.com', 'drop-down-terminal@gs-extensions.zzrough.org', 'dash-to-panel@jderose9.github.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'EasyScreenCast@iacopodeenosee.gmail.com', 'ShellTile@emasab.it', 'text-scaler@gnome-shell-extensions.mariospr.org', 'switcher@landau.fi', 'all-windows@ezix.org', 'gTile@vibou']"

    # dash to panel
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas set org.gnome.shell.extensions.dash-to-panel panel-size 32
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas set org.gnome.shell.extensions.dash-to-panel appicon-margin 4
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas set org.gnome.shell.extensions.dash-to-panel panel-position 'TOP'
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas set org.gnome.shell.extensions.dash-to-panel hot-keys true
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas set org.gnome.shell.extensions.dash-to-panel hotkeys-overlay-combo 'ALWAYS'

    #drop down terminal
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/drop-down-terminal@gs-extensions.zzrough.org/ set org.zzrough.gs-extensions.drop-down-terminal real-shortcut "['F12']"

    #switcher
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/switcher@landau.fi/schemas set org.gnome.shell.extensions.switcher show-switcher "['<Super>w']"
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/switcher@landau.fi/schemas set org.gnome.shell.extensions.switcher font-size "uint32 18"
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/switcher@landau.fi/schemas set org.gnome.shell.extensions.switcher matching "uint32 1"
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/switcher@landau.fi/schemas set org.gnome.shell.extensions.switcher workspace-indicator "true"
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/switcher@landau.fi/schemas set org.gnome.shell.extensions.switcher activate-immediately "true"
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/switcher@landau.fi/schemas set org.gnome.shell.extensions.switcher activate-by-key "uint32 2"

    #shellshape
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/shellshape@gfxmonk.net/data/glib-2.0/schemas set org.gnome.shell.extensions.net.gfxmonk.shellshape.prefs default-layout 'vertical'
    gsettings  --schemadir ~/.local/share/gnome-shell/extensions/shellshape@gfxmonk.net/data/glib-2.0/schemas set org.gnome.shell.extensions.net.gfxmonk.shellshape.keybindings next-layout "['<Mod4>Space']"
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/shellshape@gfxmonk.net/data/glib-2.0/schemas set org.gnome.shell.extensions.net.gfxmonk.shellshape.keybindings prev-layout "['<Mod4><Shift>Space']"
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/shellshape@gfxmonk.net/data/glib-2.0/schemas set org.gnome.shell.extensions.net.gfxmonk.shellshape.keybindings swap-current-window-with-main "['<Mod4>Return']"
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/shellshape@gfxmonk.net/data/glib-2.0/schemas set org.gnome.shell.extensions.net.gfxmonk.shellshape.keybindings focus-main-window "['<Mod4>m']"
}

gnome_settings() {
    is_linux || return 1
    has_cmd gnome-session || return 1

    dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/login-shell true
    gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false
    gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false
    gsettings set org.gnome.system.locale region 'en_US.UTF-8'

    gsettings set org.gnome.desktop.interface clock-format '12h'

    gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver ''
    # https://askubuntu.com/questions/493404/ubuntu-14-04-vmware-6-left-ctrl-and-right-shift-not-functioning
    gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

    gsettings set org.gnome.desktop.privacy remove-old-temp-files true
    gsettings set org.gnome.desktop.privacy remove-old-trash-files true
    gsettings set org.gnome.desktop.screensaver lock-enabled false

    is_ubuntu && gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false

    gsettings set org.gnome.desktop.interface clock-show-date true
    gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false

    [ -e ~/.config/gtk-3.0/settings.ini ] || printf "[Settings]\ngtk-application-prefer-dark-theme=1\n" > ~/.config/gtk-3.0/settings.ini
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 1800
    gsettings set org.gnome.desktop.session idle-delay 180

    gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'emacs.desktop', 'org.gnome.Terminal.desktop', 'firefox.desktop', 'org.gnome.Software.desktop', 'gnome-tweak-tool.desktop']"
}

gnome_keybindings() {
    is_linux || return 1
    has_cmd gnome-session || return 1

    gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "@as []"
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source "@as []"
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "@as []"
    gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab']"
    gsettings set org.gnome.shell.keybindings toggle-message-tray "@as []"
    gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['F11']"

    gsettings set org.gnome.desktop.wm.keybindings minimize "['<Primary><Alt>KP_0']"
    gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up', '<Primary><Alt>KP_5']"

    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down  "['<Super><Shift>Page_Down', '<Super><Shift><Control>Down']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up  "['<Super><Shift>Page_Up', '<Super><Shift><Control>Up']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down  "['<Super>Page_Down', '<Super><Control>Down']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up  "['<Super>Page_Up', '<Super><Control>Up']"

    # gsettings set org.gnome.desktop.remote-access.require-encryption false
}

gnome_install() {
    sudo apt-get install -y ubuntu-gnome-default-settings ubuntu-gnome-desktop
    sudo apt purge -y gnome-shell-extension-ubuntu-dock

    gnome_extensions
    gnome_settings
    gnome_keybindings
}

add_numix_ppa() {
    is_ubuntu || return 1
    ppa_exists numix && return 0

    slog "Adding numix ppa"
    sudo add-apt-repository ppa:numix/ppa -y
}

ubuntu_themes_install() {
    is_ubuntu || return 1

    slog "Installing themes"

    add_numix_ppa
    sudo apt-get update

    sudo apt-get install -y numix-icon-theme-circle arc-theme
}

themes_install() {
    ubuntu_themes_install

    if has_cmd gnome-shell; then
        slog "Setting Arc theme and Numix Circle theme for gnome"
        gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
        gsettings set org.gnome.desktop.interface icon-theme 'Numix-Circle'
        gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
    fi

    if has_cmd mate-session; then
        slog "Setting Arc theme and Numix Circle theme for mate"
        dconf write /org/mate/desktop/interface/icon-theme "'Numix-Circle'"
        dconf write /org/mate/marco/general/theme "'Arc-Dark'"
    fi
}

git_credential_gnome_keyring_install() {
    is_ubuntu || return 1

    slog "git credential - gnome-keyring"
    sudo apt-get install libsecret-1-0 libsecret-1-dev
    cd /usr/share/doc/git/contrib/credential/libsecret && sudo make
    git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
}

seartipy_ctrl_alt_set() {
    is_linux || return 1
    has_cmd gnome-session && gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'ctrl:lctrl_meta']"
    has_cmd mate-session && dconf write /org/mate/desktop/peripherals/keyboard/kbd/options "['ctrl\tctrl:lctrl_meta', 'caps\tcaps:ctrl_modifier']"
}

seartipy_ctrl_alt_reset() {
    is_linux || return 1
    has_cmd gnome-session && gsettings set org.gnome.desktop.input-sources xkb-options "@as []"
    has_cmd mate-session && dconf write /org/mate/desktop/peripherals/keyboard/kbd/options '@as []'
}

seartipy_ctrl_caps_set() {
    is_linux || return 1
    has_cmd gnome-session && gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
    has_cmd mate-session && dconf write /org/mate/desktop/peripherals/keyboard/kbd/options "['ctrl\tctrl:nocaps', 'caps\tcaps:none']"
}

seartipy_ctrl_caps_reset() {
    seartipy_ctrl_alt_reset
}

#
# aliases

alias cas=seartipy_ctrl_alt_set
alias car=seartipy_ctrl_alt_reset
alias ccs=seartipy_ctrl_caps_set
alias ccr=seartipy_ctrl_caps_reset
