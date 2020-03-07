#!/bin/bash

target=$HOME/Convert-To-PDF
servname=convert-to-pdf

sudo systemctl disable --now $servname.path
sudo rm /etc/systemd/system/$servname.*
sudo systemctl daemon-reload


read -r -p "Remove $target? [y/n] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
	echo "Removing $target"
        rm -rf $target
        ;;
    *)
esac
