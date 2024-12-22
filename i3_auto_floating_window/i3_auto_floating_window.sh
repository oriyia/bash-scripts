#!/bin/bash

WIN_ID=$(xdotool search --onlyvisible --name "Vivaldi" | tail -n 1)
APP_CLASS="vivaldi-stable"
MY_GLOBAL_VARS='/home/oriyia/.tmp/my_global_vars.sh'
# i3-msg "[id=$WIN_ID] resize set 1980 1200" && i3-msg resize set 1240 480 && i3-msg border pixel 3 && i3-msg move position center
i3-msg "[id=$WIN_ID] move position center border pixel 3"


echo "Скрипт запущен" >> /home/oriyia/.tmp/my_script.log
echo "WIN_ID=$WIN_ID" >> /home/oriyia/.tmp/my_script.log

if [[ -e "$MY_GLOBAL_VARS" ]]; then
    echo "Файл существует: $MY_GLOBAL_VARS" >> /home/oriyia/.tmp/my_script.log
    PARENT_ID=$(cat "$MY_GLOBAL_VARS")
    # При несовпадении id сохраняем более новый
    PARENT_WM_PID=$(xprop -id "$PARENT_ID" _NET_WM_PID | awk '{print $3}')
    WIN_WM_PID=$(xprop -id "$WIN_ID" _NET_WM_PID | awk '{print $3}')
    if [[ "$WIN_WM_PID" -ne "$PARENT_WM_PID" ]]; then
        echo "$WIN_ID" > "$MY_GLOBAL_VARS"
    fi
    # Найдите идентификатор и время активности родительского окна
    # PARENT_USER_TIME=$(xprop -id "${PARENT_ID}" _NET_WM_USER_TIME | awk '{print $3}')
    # WIN_USER_TIME=$(xprop -id "${WIN_ID}" _NET_WM_USER_TIME | awk '{print $3}')
    # # Проверяем, что время активности у нового окна больше, чем у родительского
    # if [ "$WIN_USER_TIME" -gt "$PARENT_USER_TIME" ]; then
    #     i3-msg "[id=$WIN_ID] border pixel 3" && i3-msg "move position center"
    # else
    #     i3-msg "[id=$PARENT_ID] border pixel 3" ; i3-msg "move position center"
    # fi
else
    echo "ID окна: $1" >> /home/oriyia/.tmp/my_script.log
    # Найдите идентификатор основного окна браузера и сохраните его переменную
    PARENT_ID=$(xdotool search --class "$APP_CLASS" | head -n 1)
    echo "$PARENT_ID" > "$MY_GLOBAL_VARS"
fi
