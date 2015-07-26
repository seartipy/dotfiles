gsettings set org.gnome.desktop.interface text-scaling-factor .9
gsettings set org.gnome.desktop.interface scaling-factor 2
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gdk/WindowScalingFactor': <2>}"

gsettings set  org.gnome.desktop.screensaver lock-enabled false
gsettings get  org.gnome.desktop.screensaver ubuntu-lock-on-suspend false
[ -e ~/.config/gtk-3.0/settings.ini ] || printf "[Settings]\ngtk-application-prefer-dark-theme=1\n" > ~/.config/gtk-3.0/settings.ini
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
gsettings set org.gnome.Terminal.Legacy.Settings dark-theme true
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'ctrl:lctrl_meta']"
gsettings set org.gnome.desktop.interface gtk-key-theme Emacs
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 1800
gsettings set org.gnome.desktop.session idle-delay 180

gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab']"
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver ''

gsettings get org.gnome.desktop.privacy remove-old-temp-files true
gsettings get org.gnome.desktop.privacy remove-old-trash-files true
