#!/usr/bin/env bash
apt list --manual-installed | awk -F/ -v ORS=" " 'NR>1 {print $1}' > ubuntu_apt_packages.txt
