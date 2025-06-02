#!/usr/bin/env bash

VERSION=15
BREW_PREFIX=$(brew --prefix)
LINK_LIST=("gcc" "g++" "c++" "cpp")

if [[ $1 == link ]]; then
	if [ ! -f "$BREW_PREFIX"/bin/gcc-$VERSION ]; then
		echo "gcc-$VERSION not found"
		exit 1
	fi

	for i in "${LINK_LIST[@]}"; do
		ln -s "$BREW_PREFIX"/bin/"$i"-$VERSION "$BREW_PREFIX"/bin/"$i"
	done
elif [[ $1 == unlink ]]; then
	for i in "${LINK_LIST[@]}"; do
		rm -f "$BREW_PREFIX"/bin/"$i"
	done
else 
  echo "Usage: $0 {link|unlink}"
  exit 1
fi
