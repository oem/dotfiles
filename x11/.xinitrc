xinput --set-prop 12 'libinput Accel Speed' 0

xset -b # deactivate pc speaker
xset r rate 200 50
xset +fp /usr/share/fonts/local

xsetroot -solid "#1c1c1c"

setxkbmap us mac
setxkbmap -option "ctrl:nocaps"

xbindkeys &

~/.fehbg &

unclutter &

exec /home/oem/.dotfiles/dwm-statusbar &
exec /home/oem/.dotfiles/dwm-start

