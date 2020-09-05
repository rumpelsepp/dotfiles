#!/bin/bash

set -eu

scp "$1" tatooine.wg:/var/www/html/files.rumpelsepp.org/
echo "https://files.rumpelsepp.org/$(basename "$1")"
