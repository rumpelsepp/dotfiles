#!/bin/bash

export GDK_BACKEND=x11
exec blueman-manager "$@"
