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

