#!/bin/bash

set -e

WG_SERVER="$(resolvectl query --legend=no -t A selonia.sevenbyte.org | awk '{print $4}')"
GATEWAY="$(ip route show default | awk '{print $3}')"

# sudo ip route add 0.0.0.0/1 dev wg0 || true
sudo ip route add "$WG_SERVER" via "$GATEWAY" || true
