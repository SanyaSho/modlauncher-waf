#!/bin/sh

if [ -z $1 ];then echo usage: $0 "<in>";exit;fi

mkdir -p res/drawable res/drawable-hdpi res/drawable-xhdpi res/drawable-xxhdpi res/drawable-xxxhdpi

rsvg-convert $1 -w 48 -h 48 > res/drawable/launcher_update.png
rsvg-convert $1 -w 72 -h 72 > res/drawable-hdpi/launcher_update.png
rsvg-convert $1 -w 96 -h 96 > res/drawable-xhdpi/launcher_update.png
rsvg-convert $1 -w 144 -h 144 > res/drawable-xxhdpi/launcher_update.png
rsvg-convert $1 -w 192 -h 192 > res/drawable-xxxhdpi/launcher_update.png

