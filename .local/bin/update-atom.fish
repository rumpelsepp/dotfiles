#!/usr/bin/env fish

set tmpdir (mktemp -d)
cd $tmpdir

#curl -L "https://atom.io/download/deb" > atom.deb
#sudo apt install ./atom.deb

curl -L "https://atom.io/download/deb?channel=beta" > atom.deb
sudo apt install ./atom.deb

cd /

rm -rf $tmpdir
