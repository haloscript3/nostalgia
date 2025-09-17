#!/usr/bin/env bash

STATIONS=(
  "Future Generation|https://edge1.radyotvonline.net/shoutcast/play/fg"
  "Radio Swiss Jazz|https://stream.srg-ssr.ch/m/rsj/mp3_128"
)

while true; do
    MENU_OPTS=()
    for i in "${!STATIONS[@]}"; do
        name="${STATIONS[$i]%%|*}"
        MENU_OPTS+=("$i" "$name")
    done

    CHOICE=$(dialog --clear \
                    --backtitle "Haloscript3 Radio" \
                    --title "Radio List" \
                    --menu "Pick a station (ESC to Quit)" 15 60 8 \
                    "${MENU_OPTS[@]}" \
                    2>&1 >/dev/tty)

    clear
    [ -z "$CHOICE" ] && break

    ENTRY="${STATIONS[$CHOICE]}"
    NAME="${ENTRY%%|*}"
    URL="${ENTRY#*|}"

    echo "Now listening to: $NAME"
    echo "Volume: u=up, d=down, m=mute, q=quit"

    SOCKET="/tmp/mpv-radio-socket"
    rm -f $SOCKET
    mpv --no-video --input-ipc-server=$SOCKET "$URL" &
    MPV_PID=$!

    while true; do
        read -rsn1 key
        case "$key" in
            u)  # volume up
                echo '{ "command": ["add", "volume", 5] }' | socat - $SOCKET ;;
            d)  # volume down
                echo '{ "command": ["add", "volume", -5] }' | socat - $SOCKET ;;
            m)  # mute toggle
                echo '{ "command": ["cycle", "mute"] }' | socat - $SOCKET ;;
            q)  # quit mpv
                kill $MPV_PID
                wait $MPV_PID 2>/dev/null
                break ;;
        esac
    done
done