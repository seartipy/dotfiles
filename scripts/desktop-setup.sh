#! /bin/bash
{
source "$HOME/seartipy/dotfiles/scripts/utils.sh"

#
# GNOME

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
    scopy ~/seartipy/dotfiles/templates/desktops/xresources ~/.Xresources
}

hidpi_install() {
    gnome_hidpi
    mate_hidpi
    x11_hidpi
}

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
    elif is_fedora; then
        sudo dnf install -y chrome-gnome-shell
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
}

gnome_install() {
    sudo apt-get install -y ubuntu-gnome-default-settings ubuntu-gnome-desktop
    sudo apt purge gnome-shell-extension-ubuntu-dock

    gnome_extensions
    gnome_settings
    gnome_keybindings
}

# 

mate_settings() {
    is_linux || return 1
    has_cmd mate-session || return 1

    slog "Mate settings"

    dconf write /org/mate/desktop/font-rendering/antialiasing "'rgba'"
    dconf write /org/mate/desktop/font-rendering/hinting "'slight'"

    dconf write /org/mate/desktop/peripherals/keyboard/kbd/options "['terminate\tterminate:ctrl_alt_bksp', 'ctrl\tctrl:nocaps', 'caps\tcaps:none']"

    dconf write /org/mate/caja/preferences/click-policy "'single'"
    dconf write /org/mate/caja/preferences/executable-text-activation "'launch'"

    dconf write /org/mate/power-manager/sleep-computer-ac "1800"
    dconf write /org/mate/power-manager/sleep-display-ac "300"

    dconf write /org/mate/power-manager/lock-use-screensaver "false"
    dconf write /org/mate/power-manager/lock-suspend "false"
    dconf write /org/mate/terminal/profiles/default/login-shell "true"
    dconf write /org/mate/terminal/global/use-menu-accelerators "false"
    dconf write /org/mate/terminal/profiles/default/default-show-menubar "false"
}

mate_keybindings() {
    is_linux || return 1
    has_cmd mate-session || return 1

    slog "Mate keybindings"

    dconf write /org/mate/marco/global-keybindings/panel-run-dialog "'<Mod4>space'"
    dconf write /org/mate/marco/window-keybindings/tile-to-side-e "'<Mod4>Right'"
    dconf write /org/mate/marco/window-keybindings/tile-to-side-w "'<Mod4>Left'"

    dconf write /org/mate/marco/global-keybindings/switch-to-workspace-1 "'<Primary>1'"
    dconf write /org/mate/marco/global-keybindings/switch-to-workspace-2 "'<Primary>2'"
    dconf write /org/mate/marco/global-keybindings/switch-to-workspace-3 "'<Primary>3'"
    dconf write /org/mate/marco/global-keybindings/switch-to-workspace-4 "'<Primary>4'"

    dconf write /org/mate/marco/window-keybindings/move-to-workspace-1 "'<Shift><Mod4>exclam'"
    dconf write /org/mate/marco/window-keybindings/move-to-workspace-2 "'<Shift><Mod4>at'"
    dconf write /org/mate/marco/window-keybindings/move-to-workspace-3 "'<Shift><Mod4>numbersign'"
    dconf write /org/mate/marco/window-keybindings/move-to-workspace-4 "'<Shift><Mod4>dollar'"

    dconf write /org/mate/marco/global-keybindings/switch-to-workspace-left "'<Primary><Mod4>Left'"
    dconf write /org/mate/marco/global-keybindings/switch-to-workspace-right "'<Primary><Mod4>Right'"
    dconf write /org/mate/marco/global-keybindings/switch-to-workspace-up "'<Primary><Mod4>Up'"
    dconf write /org/mate/marco/global-keybindings/switch-to-workspace-down "'<Primary><Mod4>Down'"

    dconf write /org/mate/marco/window-keybindings/move-to-workspace-left "'<Primary><Shift><Mod4>Left'"
    dconf write /org/mate/marco/window-keybindings/move-to-workspace-right "'<Primary><Shift><Mod4>Right'"
    dconf write /org/mate/marco/window-keybindings/move-to-workspace-up "'<Primary><Shift><Mod4>Left'"
    dconf write /org/mate/marco/window-keybindings/move-to-workspace-up "'<Primary><Shift><Mod4>Up'"
    dconf write /org/mate/marco/window-keybindings/move-to-workspace-down "'<Primary><Shift><Mod4>Down'"

    dconf write /org/mate/marco/window-keybindings/toggle-fullscreen "'F11'"
    dconf write /org/mate/marco/window-keybindings/toggle-maximized "'<Mod4>F11'"
    dconf write /org/mate/marco/window-keybindings/activate-window-menu "'disabled'"
}

mate_install() {
    mate_settings
    mate_keybindings
}

mac_settings() {
    is_mac || return 1

    slog "Mac settings"

    # https://github.com/mathiasbynens/dotfiles/blob/978fb2696860ebe055a0caec425c67be0ad73319/.osx

    # Disable Resume system-wide
    defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

    # Check for software updates daily, not just once per week
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1


    # Disable Notification Center and remove the menu bar icon
    launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

    # Disable smart quotes as they’re annoying when typing code
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

    # Disable smart dashes as they’re annoying when typing code
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

    # Trackpad: enable tap to click for this user and for the login screen
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Disable “natural” (Lion-style) scrolling
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

    # Increase sound quality for Bluetooth headphones/headsets
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

    # Disable press-and-hold for keys in favor of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    # Set a blazingly fast keyboard repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 0

    # Enable HiDPI display modes (requires restart)
    sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

    # Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
    defaults write com.apple.finder QuitMenuItem -bool true

    # Set Desktop as the default location for new Finder windows
    # For other paths, use `PfLo` and `file:///full/path/here/`
    defaults write com.apple.finder NewWindowTarget -string "PfDe"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

    # Show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

    # Finder: show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Avoid creating .DS_Store files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # Disable disk image verification
    defaults write com.apple.frameworks.diskimages skip-verify -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

    # Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false

    # Enable AirDrop over Ethernet and on unsupported Macs running Lion
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

    # Show the ~/Library folder
    chflags nohidden ~/Library

    # Set the icon size of Dock items to 36 pixels
    defaults write com.apple.dock tilesize -int 36

    # Minimize windows into their application’s icon
    defaults write com.apple.dock minimize-to-application -bool true

    # Show indicator lights for open applications in the Dock
    defaults write com.apple.dock show-process-indicators -bool true

    # Disable Dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true

    # Don’t show Dashboard as a Space
    defaults write com.apple.dock dashboard-in-overlay -bool true

    # Don’t automatically rearrange Spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Set Safari’s home page to `about:blank` for faster loading
    defaults write com.apple.Safari HomePage -string "about:blank"

    # Prevent Safari from opening ‘safe’ files automatically after downloading
    defaults write com.apple.Safari AutoOpenSafeDownloads -bool false


    # Allow hitting the Backspace key to go to the previous page in history
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

    # Disable Safari’s thumbnail cache for History and Top Sites
    defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

    # Enable Safari’s debug menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Hide Spotlight tray-icon (and subsequent helper)
    #sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
    # Disable Spotlight indexing for any volume that gets mounted and has not yet
    # been indexed before.
    # Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
    sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
    # Change indexing order and disable some file types
    defaults write com.apple.spotlight orderedItems -array \
             '{"enabled" = 1;"name" = "APPLICATIONS";}' \
             '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
             '{"enabled" = 1;"name" = "DIRECTORIES";}' \
             '{"enabled" = 1;"name" = "PDF";}' \
             '{"enabled" = 0;"name" = "DOCUMENTS";}' \
             '{"enabled" = 0;"name" = "EVENT_TODO";}' \
             '{"enabled" = 0;"name" = "BOOKMARKS";}' \
             '{"enabled" = 0;"name" = "MUSIC";}' \
             '{"enabled" = 0;"name" = "MOVIES";}' \
             '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
             '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
             '{"enabled" = 0;"name" = "SOURCE";}'

    # Only use UTF-8 in Terminal.app
    defaults write com.apple.terminal StringEncodings -array 4

    # Don’t display the annoying prompt when quitting iTerm
    defaults write com.googlecode.iterm2 PromptOnQuit -bool false

}

#
# themes

fedora_themes_install() {
    is_fedora || return 1

    slog "Installing themes"

    sudo dnf copr -y enable numix/numix
    sudo dnf install -y numix-icon-theme-circle

    sudo dnf config-manager --add-repo http://download.opensuse.org/repositories/home:Horst3180/Fedora_24/home:Horst3180.repo
    sudo dnf install -y arc-theme

    sudo dnf install -y conky
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

    sudo apt-get install -y numix-icon-theme-circle arc-theme conky-all
}

themes_install() {
    ubuntu_themes_install
    fedora_themes_install

    is_debian && return 1

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

ppas_check() {
    if [ -n "$THEMES" ]; then
        ppa_check numix
        ppa_check teejee2008
    fi
}

# 
# FONTS

font_exists() {
    if is_mac; then
        is_mac && ls ~/Library/Fonts 2> /dev/null | grep "$1" > /dev/null
    else
        (ls ~/.local/share/fonts 2> /dev/null | grep "$1" > /dev/null) || (ls ~/.fonts 2> /dev/null | grep "$1" > /dev/null)
    fi
}

mononoki_font() {
    if ! font_exists "mononoki"; then
        slog "Installing mononoki fonts"

        srm /tmp/mononoki.zip
        wget  --quiet -O /tmp/mononoki.zip https://github.com/madmalik/mononoki/releases/download/1.2/mononoki.zip
        srm /tmp/seartipy-mononoki-fonts
        unzip /tmp/mononoki.zip -d /tmp/seartipy-mononoki-fonts

        is_mac && cp /tmp/seartipy-mononoki-fonts/*.ttf ~/Library/Fonts

        if is_linux; then
            smd ~/.fonts
            cp /tmp/seartipy-mononoki-fonts/*.ttf ~/.fonts
            fc-cache -f ~/.fonts
        fi

        rm -f /tmp/mononoki.zip
        rm -rf /tmp/seartipy-mononoki-fonts
    fi
}

powerline_fonts() {
    if ! font_exists "Powerline"; then
        slog "Installing powerline patched fonts"
        fclone https://github.com/powerline/fonts.git /tmp/seartipy-powerline-fonts
        cd /tmp/seartipy-powerline-fonts && ./install.sh
        cd
        rm -rf /tmp/seartipy-powerline-fonts
    fi
}

fonts_install() {
    powerline_fonts
    mononoki_font
}

fonts_check() {
    font_exists "Powerline" || warn "powerline fonts not installed"
    font_exists "mononoki" > /dev/null || warn "mononoki font not installed"
}

#
# XMONAD

xmonad_fedora_install() {
    is_fedora || return 1

    slog "Installing xmonad"
    sudo dnf install -y xmonad ghc-xmonad-devel ghc-xmonad-contrib ghc-xmonad-contrib-devel xmobar dmenu
}

xmonad_ubuntu_install() {
    is_apt || return 1

    slog "Installing xmonad"
    sudo apt-get install -y xmonad libghc-xmonad-contrib-dev xmobar suckless-tools rofi
}

xmonad_fix() {
    rm -rf ~/.ghc
    xmonad --recompile
}

xmonad_install() {
    is_linux || return 1

    slog "xmonad setup"

    xmonad_fedora_install
    xmonad_ubuntu_install

    slog "moving ~/.xmonad to $BACKUP_DIR"
    smv ~/.xmonad $BACKUP_DIR

    smd ~/.xmonad

    slog "Linking ~/seartipy/dotfiles/xmonad.hs to ~/.xmonad/xmonad.hs"
    sln ~/seartipy/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs

    if has_cmd mate-session; then
        slog "setting xmonad as mate's window manager"
        dconf write /org/mate/desktop/session/required-components/windowmanager "'xmonad'"
    fi

    is_apt || return 1

    xmonad_fix
}

xmonad_check() {
    is_linux || return 1

    cmd_check xmonad dmenu
    is_ubuntu && cmd_check rofi
    ln_check ~/seartipy/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs
}

# 
# i3

i3_ubuntu_install() {
    is_apt ||  return 1

    sudo apt-get install -y i3-wm rofi suckless-tools i3status
}

i3_fedora_install() {
    is_fedora || return 1

    sudo dnf install -y i3 i3status
}

i3_install() {
    is_linux || return 1

    slog "i3 setup"

    i3_ubuntu_install
    i3_fedora_install

    scopy ~/seartipy/dotfiles/templates/desktops/i3-config ~/.i3/config
}

# 
# KDE

kde_install() {
    is_linux || return 1

    slog "kde setup"

    is_ubuntu && sudo apt-get install -y rofi

    fcopy ~/seartipy/dotfiles/templates/desktops/kde/kwinrc ~/.config/kwinrc
    fcopy ~/seartipy/dotfiles/templates/desktops/kde/kglobalshortcutsrc  ~/.config/kglobalshortcutsrc
}

# 
# OPENBOX

lxde_install() {
    is_linux || return 1

    slog "lxde setup"

    is_ubuntu && sudo apt-get install -y rofi

    fcopy ~/seartipy/dotfiles/templates/desktops/lxde/lubuntu-rc.xml ~/.config/openbox/lubuntu-rc.xml
    fcopy ~/seartipy/dotfiles/templates/desktops/lxde/lubuntu-rc.xml ~/.config/openbox/lxde-rc.xml
    fcopy ~/seartipy/dotfiles/templates/desktops/lxde/autostart ~/.config/lxsession/Lubuntu/autostart
}

# 
# XFCE

xfce_install() {
    is_linux || return 1

    slog "xfce setup"

    is_ubuntu && sudo apt-get install -y rofi

    fcopy ~/seartipy/dotfiles/templates/desktops/xfce4/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
    fcopy ~/seartipy/dotfiles/templates/desktops/xfce4/xsettings.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    fcopy ~/seartipy/dotfiles/templates/desktops/xfce4/xfwm4.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
}

# 
# MAC

amethyst_install() {
    is_mac || return 1
    brew cask install amethyst
    [ -f ~/seartipy/dotfiles/amethyst ] || return 1

    slog "Moving ~/.amethyst to $BACKUP_DIR"
    smv ~/.amethyst "$BACKUP_DIR"

    slog "Linking ~/seartipy/dotfiles/amethyst to ~/.amethyst"

    sln ~/seartipy/dotfiles/amethyst ~/.amethyst
}

mac_install() {
    is_mac || return 1

    amethyst_install
    mac_settings
}

#

git_credential_gnome_keyring_install() {
    is_ubuntu || return 1

    slog "git credential - gnome-keyring"
    sudo apt-get install -y libgnome-keyring-dev
    sudo make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring
    git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
}


git_credential_libsecret_install() {
    is_fedora || return 1

    slog "git credential - libsecret"
    sudo dnf install -y libsecret
    git config --global credential.helper libsecret
}

git_install() {
    git_credential_gnome_keyring_install
    git_credential_libsecret_install
}

# 

select_defaults() {
    FONTS="fonts"
    is_ubuntu || return 1
    echo "enabled=0" | sudo tee /etc/default/apport > /dev/null

}

select_everything() {
    select_defaults

    GIT="git"
    XMONAD="xmonad"
    I3="i3"
    LXDE="lxde"
    XFCE="xfce"
    GNOME="gnome"
    XMONAD="xmonad"
    MAC="mac"
    MATE="mate"
    THEMES="themes"
    HIDPI="hidpi"
}

script_options() {
    if [ $# -eq 0 ]; then
        select_everything
    else
        select_defaults
    fi

    while [ $# -gt 0 ]; do
        case $1 in
            xmonad)
                XMONAD="xmonad"
                shift
                ;;
            i3)
                I3="i3"
                shift
                ;;
            lxde)
                LXDE="lxde"
                shift
                ;;
            xfce)
                XFCE="xfce"
                shift
                ;;
            gnome)
                GNOME="gnome"
                shift
                ;;
            kde)
                KDE="kde"
                shift
                ;;
            mac)
                MAC="mac"
                shift
                ;;
            git)
                GIT="git"
                shift
                ;;
            mate)
                MATE="mate"
                shift
                ;;
            themes)
                THEMES="themes"
                shift
                ;;
            hidpi)
                HIDPI="hidpi"
                shift
                ;;
            nofonts)
                FONTS=""
                shift
                ;;
            nodefaults)
                FONTS=""
                shift;;
            *)
                err_exit "unknown option: $1"
                ;;
        esac
    done
}

installer() {
    script_options "$@"

    [ -n "$FONTS" ] && fonts_install
    [ -n "$THEMES" ] && themes_install
    [ -n "$HIDPI" ] && hidpi_install

    [ -n "$MAC" ] && mac_install

    [ -n "$XMONAD" ] && xmonad_install
    [ -n "$I3" ] && i3_install

    [ -n "$LXDE" ] && lxde_install
    [ -n "$XFCE" ] && xfce_install

    [ -n "$GNOME" ] && gnome_install
    [ -n "$KDE" ] && kde_install
    [ -n "$MATE" ] && mate_install

    [ -n "$GIT" ] && git_install
}

post_installer_check() {
    [ -n "$FONTS" ] && fonts_check
    # [ -n "$THEMES" ] && themes_check
    # [ -n "$HIDPI" ] && hidpi_check

    # [ -n "$MAC" ] && mac_check

    [ -n "$XMONAD" ] && xmonad_check
    [ -n "$I3" ] && i3_check

    # [ -n "$LXDE" ] && lxde_check
    # [ -n "$XFCE" ] && xfce_check

    # [ -n "$GNOME" ] && gnome_check
    # [ -n "$KDE" ] && kde_check
    # [ -n "$MATE" ] && mate_check
    # [ -n "$GIT" ] && git_install
}

main() {
    pre_cmd_check
    keep_sudo_running
    installer "$@"
    post_installer_check
}

main "$@"

}
