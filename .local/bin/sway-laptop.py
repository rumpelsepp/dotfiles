#!/usr/bin/python3

import sway

name = sway.find_output_name('0x00000000')
if name:
    sway.set_output(name, '2560x1440', (1920, 0), scale=1.5)

