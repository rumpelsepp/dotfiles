#!/bin/bash

OPTIONS=(
    "-enable-kvm"
    "-cpu" "host"
    "-smp" "2"
    "-m" "$((1024*16))"
    "-drive" "file=$HOME/qemu/kali.qcow2,if=virtio"
    "-k" "en"
    "-nic" "user,model=virtio-net-pci"
    #"-device" "virtio-gpu-pci,virgl=on"
    "-device" "qxl-vga,id=video0,vram_size=256,vram64_size_mb=64,vgamem_mb=256"
    "-audiodev" "spice,id=0"
    "-device" "virtio-serial-pci"
    "-spice" "unix=on,addr=/run/$(id -u)/vmspice-kali.socket,disable-ticketing=on"
    "-device" "virtserialport,chardev=spicechannel0,name=com.redhat.spice.0"
    "-chardev" "spicevmc,id=spicechannel0,name=vdagent"
    "-device" "ich9-usb-ehci1,id=usb"
    "-device" "ich9-usb-uhci1,masterbus=usb.0,firstport=0,multifunction=on"
    "-device" "ich9-usb-uhci2,masterbus=usb.0,firstport=2"
    "-device" "ich9-usb-uhci3,masterbus=usb.0,firstport=4"
    "-chardev" "spicevmc,name=usbredir,id=usbredirchardev1"
    "-device" "usb-redir,chardev=usbredirchardev1,id=usbredirdev1"
    "-chardev" "spicevmc,name=usbredir,id=usbredirchardev2"
    "-device" "usb-redir,chardev=usbredirchardev2,id=usbredirdev2"
    "-chardev" "spicevmc,name=usbredir,id=usbredirchardev3"
    "-device" "usb-redir,chardev=usbredirchardev3,id=usbredirdev3"
    "-display" "spice-app,gl=on"
)

qemu-system-x86_64 "${OPTIONS[@]}"
