#!/bin/bash

export PYTHONUNBUFFERED=y

logfile="$1-$(date +%F_%T).log"

$@ |& tee "$logfile"
