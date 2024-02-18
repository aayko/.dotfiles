#!/bin/bash

fade=150000

case $1 in
up)
    pkexec brillo -u $fade -q -A 10
	;;
down)
    pkexec brillo -u $fade -q -U 10
	;;
esac
