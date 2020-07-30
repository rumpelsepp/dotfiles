#!/bin/bash

while true; do
    mbsync private
    mbsync -c ~/.mbsyncrc-aisec work
    sleep 5m
done

