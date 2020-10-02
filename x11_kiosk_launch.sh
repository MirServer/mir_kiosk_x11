#!/bin/sh

bindir=$(dirname "$0")

if [ "${bindir}" != "" ]; then bindir="${bindir}/"; fi

unset WAYLAND_DISPLAY

# ${x11_display_file} will contain the X11 display
x11_display_file=$(mktemp)

MIR_SERVER_ENABLE_X11=1 "${bindir}"mir_kiosk_x11 --x11-displayfd 5 5>"${x11_display_file}"&

inotifywait --event close_write "${x11_display_file}"
export DISPLAY
DISPLAY=:$(cat "${x11_display_file}")
rm "${x11_display_file}"
XDG_SESSION_TYPE=mir GDK_BACKEND=x11 QT_QPA_PLATFORM=xcb SDL_VIDEODRIVER=x11 NO_AT_BRIDGE=1 exec "$@"
