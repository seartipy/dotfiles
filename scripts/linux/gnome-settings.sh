gsettings set org.gnome.desktop.interface text-scaling-factor .9
gsettings set org.gnome.desktop.interface scaling-factor 2
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gdk/WindowScalingFactor': <2>}"

gsettings set  org.gnome.desktop.screensaver lock-enabled false
gsettings set  org.gnome.desktop.screensaver ubuntu-lock-on-suspend false
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

gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true

gsettings set org.gnome.system.locale region 'en_US.UTF-8'

# gnome extensions

gsettings set org.gnome.shell enabled-extensions "['windowsNavigator@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com']"

wget -O ~/bin/shell-extension-install https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnome-extension/shell-extension-install
chmod +x ~/bin/shell-extension-install

shell-extension-install 3.14 294 # shellshape
shell-extension-install 3.14 97  # coverflow alt-tab
shell-extension-install 3.14 442 # drop down terminal
shell-extension-install 3.14 413 # app keys
shell-extension-install 3.14 361 # emacs manager

gsettings --schemadir ~/.local/share/gnome-shell/extensions/drop-down-terminal@gs-extensions.zzrough.org/ set org.zzrough.gs-extensions.drop-down-terminal real-shortcut "['F11']"
