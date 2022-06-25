#! /usr/bin/env bash

source "$HOME.seartipy/scripts/utils.sh"

seartipy_create_emacs_desktops() {
    smd ~/.local/share/applications

    srm ~/.local/share/applications/emacsclient.emacs25-term.desktop
    slog "Creating emacsclient terminal .desktop"
    cat <<EOF > ~/.local/share/applications/emacsclient.emacs25-term.desktop
[Desktop Entry]
Version=1.0
Name=Emacs Client 25 (Terminal)
GenericName=Text Editor
Comment=GNU Emacs is an extensible, customizable text editor - and more
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
TryExec=/usr/bin/emacs25
Exec=/usr/bin/emacs25 -t %F
Icon=emacs25
Type=Application
Terminal=true
Categories=Utility;Development;TextEditor;
Keywords=Text;Editor;
EOF

    srm ~/.local/share/applications/emacsclient.emacs25.desktop
    slog "Creating emacsclient terminal .desktop"
    cat <<EOF > ~/.local/share/applications/emacsclient.emacs25.desktop
[Desktop Entry]
Version=1.0
Name=EmacsClient 25 (GUI)
GenericName=Text Editor
Comment=GNU Emacs is an extensible, customizable text editor - and more
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
TryExec=/usr/bin/emacs25
Exec=/usr/bin/emacs25 -c -n %F
Icon=emacs25
Type=Application
Terminal=false
Categories=Utility;Development;TextEditor;
StartupWMClass=Emacs
Keywords=Text;Editor;
EOF

}

seartipy_create_emacs_desktops
