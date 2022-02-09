#!/bin/bash

qemu-system-x86_64 \
    -enable-kvm \
    -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
    -smp 2 \
    -m $((1024*16)) \
    -drive file="$HOME/qemu/win10-aisec.qcow2" \
    -k en \
    -nic user,smb="$HOME/Projects",hostfwd=tcp::5555-:3389 \
    -vga qxl \
    -audiodev spice,id=0 \
    -device virtio-serial-pci \
    -spice unix=on,addr="/run/$(id -u)/vmspice-aisec.socket",disable-ticketing=on \
    -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
    -chardev spicevmc,id=spicechannel0,name=vdagent \
    -device ich9-usb-ehci1,id=usb \
    -device ich9-usb-uhci1,masterbus=usb.0,firstport=0,multifunction=on \
    -device ich9-usb-uhci2,masterbus=usb.0,firstport=2 \
    -device ich9-usb-uhci3,masterbus=usb.0,firstport=4 \
    -chardev spicevmc,name=usbredir,id=usbredirchardev1 -device usb-redir,chardev=usbredirchardev1,id=usbredirdev1 \
    -chardev spicevmc,name=usbredir,id=usbredirchardev2 -device usb-redir,chardev=usbredirchardev2,id=usbredirdev2 \
    -chardev spicevmc,name=usbredir,id=usbredirchardev3 -device usb-redir,chardev=usbredirchardev3,id=usbredirdev3 \
    -display spice-app,gl=on
    -usb -device usb-tablet

	# -nographic
