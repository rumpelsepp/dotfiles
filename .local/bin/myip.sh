#!/bin/bash

set -eu

curl -Ls "$@" https://rumpelsepp.org/myip | jq '.'
