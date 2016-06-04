#!/bin/sh

cd `git rev-parse --show-toplevel`

wget -P "test/faceup" https://raw.githubusercontent.com/Lindydancer/faceup/master/faceup.el
