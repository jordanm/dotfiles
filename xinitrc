#!/bin/sh
xset m 11/3 1
xset b off

if [[ -f $HOME/.Xdefaults ]]; then
    xrdb -merge $HOME/.Xdefaults
fi

/usr/bin/batti &
/usr/bin/wicd-gtk -a 2>&1 1>/dev/null &
/usr/bin/python2 /usr/bin/blueman-applet 2>&1 1>/dev/null &

fbsetbg ~/.fluxbox/background.jpg
ssh-agent fluxbox &

fbpid=$!
wait $fbpid
