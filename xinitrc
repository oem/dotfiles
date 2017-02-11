export SXHKD_SHELL='/usr/bin/sh'

xinput --set-prop 12 'libinput Accel Speed' 1

xset -b # deactivate pc speaker
xset r rate 200 25
xset +fp /usr/share/fonts/local

xsetroot -solid "#1c1c1c"

xbindkeys &
xmodmap ~/.xmodmap

urxvtd -f

exec bspwm

