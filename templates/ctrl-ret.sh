#! /bin/bash

# http://emacsredux.com/blog/2016/01/30/remap-return-to-control-in-gnu-slash-linux/
xmodmap -e "remove Control = Control_R"
xmodmap -e "keycode 0x69 = Return"
xmodmap -e "keycode 0x24 = Control_R"
xmodmap -e "add Control = Control_R"

xcape -t 10000 -e "Control_R=Retur"n
