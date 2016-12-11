xset r rate 200 60
xset +fp /usr/share/fonts/local
xsetroot -solid "#1c1c1c"
xbindkeys &
xmodmap ~/.xmodmap
exec dunst -config /home/oem/dotfiles/dunstrc &
urxvtd -f
xrandr --dip 267
exec /home/oem/dotfiles/batwarn &
exec /home/oem/dotfiles/dwm-statusbar &
exec /home/oem/dotfiles/dwm-start

