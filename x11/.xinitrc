xinput --set-prop 12 'libinput Accel Speed' 1

xset -b # deactivate pc speaker
xset r rate 200 50
xset +fp /usr/share/fonts/local

xsetroot -solid "#1c1c1c"

setxkbmap us mac

xbindkeys &
xmodmap ~/.xmodmap

urxvtd -f

mpv ~/sync/art/wallpapers/animated/retro-car-vaporwave-moewalls-com.mp4 --wid=0 --loop &

unclutter &

exec /home/oem/.dotfiles/dwm-statusbar &
exec /home/oem/.dotfiles/dwm-start

