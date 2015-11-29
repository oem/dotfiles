xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.5

xset r rate 200 25
xset +fp /usr/share/fonts/local
xsetroot -solid "#1c1c1c"
xbindkeys &
xmodmap ~/.xmodmap
exec dunst &
urxvtd -f
exec /home/oem/dotfiles/dwm-statusbar &
exec /home/oem/dotfiles/dwm-start

