#!/bin/bash

set -e

IFACE="enp0s31f6"
GATEWAY="10.85.42.21"
DNS="10.80.100.1"
SUBNETS=('10.144.0.0/16'
         '172.16.0.0/12'
         '192.88.97.0/24'
         '192.44.0.0/16'
         '10.37.0.0/16'
         '10.244.0.0/16'
         '153.96.66.0/24'
         '153.97.180.0/24'
         '153.97.176.0/24')
OPERATION="a"

addroutes() {
    for subnet in "${SUBNETS[@]}"; do
        sudo ip route add "$subnet" via "$GATEWAY" dev "$IFACE"
    done
}

delroutes() {
    for subnet in "${SUBNETS[@]}"; do
        sudo ip route del "$subnet" via "$GATEWAY" dev "$IFACE"
    done
}

addnta() {
    resolvectl nta "$IFACE" "aisec.fraunhofer.de" "fraunhofer.de"
}

delnta() {
    resolvectl nta "$IFACE" ""
}

setdns() {
    resolvectl dns "$IFACE" "$DNS"
}

usage() {
    echo "usage: $(basename "$0") -a|-d|-h"
}

while getopts "adi:g:n:h" arg; do
    case "$arg" in
        a)  OPERATION="a";;
        d)  OPERATION="d";;
        i)  IFACE="$OPTARG";;
        g)  GATEWAY="$OPTARG";;
        n)  DNS="$OPTARG";;
        h)  usage && exit 0;;
        *)  usage && exit 1;;
    esac
done

case "$OPERATION" in
    a) addroutes && addnta;;
    d) delroutes && delnta;;
    *) exit 1;;
esac
