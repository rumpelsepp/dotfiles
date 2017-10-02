#!/bin/sh

if [ "$1" = "up" ]; then
    nmcli --ask connection up 0152b01b-c859-48b9-a0f8-4b9a20793f05
elif [ "$1" = "down" ]; then
    nmcli connection down 0152b01b-c859-48b9-a0f8-4b9a20793f05
else
    echo "usage: $(basename $0) up | down"
    echo ""
    echo "Connects/Disconnects AISEC VPN using NetworkManager"
fi
