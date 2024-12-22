#! /bin/bash

xkbcomp "${HOME}"/.config/xkb/my_keyboard "${DISPLAY}" &>> "${HOME}"/.xkbcomp.log
