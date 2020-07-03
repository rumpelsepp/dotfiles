#!/usr/bin/python3

import sway

name = sway.find_output_name('4RFMK58E0TYS')
if name:
    sway.set_output(name, '1920x1200', (0, 0))

name = sway.find_output_name('0x00000000')
if name:
    sway.set_output(name, '2560x1440', (1920, 0), scale=1.3)

