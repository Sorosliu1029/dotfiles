#!/usr/bin/env bash

VERSION=14
BREW_PREFIX=$(brew --prefix)

for i in gcc g++ c++ cpp
  do
      ln -s "$BREW_PREFIX"/bin/$i-$VERSION "$BREW_PREFIX"/bin/$i
  done
