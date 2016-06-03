alias srm=rm -f

create_emacs_desktops() {

    srm ~/.local/share/applications/emacsclient.emacs24-term.desktop

    cat <<EOF > ~/.local/share/applications/emacsclient.emacs24-term.desktop
[Desktop Entry]
Version=1.0
Name=GNU Emacs Client 24 (Terminal)
GenericName=Text Editor
Comment=GNU Emacs is an extensible, customizable text editor - and more
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
TryExec=/usr/bin/emacs24
Exec=/usr/bin/emacsclient.emacs24 -t %F
Icon=emacs24
Type=Application
Terminal=true
Categories=Utility;Development;TextEditor;
Keywords=Text;Editor;

EOF

    srm ~/.local/share/applications/emacsclient.emacs24.desktop
    cat <<EOF > ~/.local/share/applications/emacsclient.emacs24.desktop
[Desktop Entry]
Version=1.0
Name=GNU Emacs Client 24 (GUI)
GenericName=Text Editor
Comment=GNU Emacs is an extensible, customizable text editor - and more
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
TryExec=/usr/bin/emacs24
Exec=/usr/bin/emacsclient.emacs24 -c -n %F
Icon=emacs24
Type=Application
Terminal=false
Categories=Utility;Development;TextEditor;
StartupWMClass=Emacs24
Keywords=Text;Editor;

EOF

}
