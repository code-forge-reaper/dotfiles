#!/usr/bin/env bash

#tint2 &
#xfce4-panel &
qs -d

# bluetooth dock applet
blueman-applet &
# wifi dock applet
nm-applet &

# background image
#nitrogen --restore &

# transparency
#picom &
feh --bg-fill ~/Downloads/44755.jpg &
# notifications
#dunst &

# music player daemon
mpd &

# the terminal
#xfce4-terminal &
cbatticon &
volumeicon &

xfce4-power-manager &

# emacs in background server mode
/usr/bin/emacs --daemon &
#pnmixer &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
