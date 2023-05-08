#!/usr/bin/env bash

# создать резервную копию важных конфигов

separator="-----------------------"
itog="${separator}$(date)${separator}"

declare -A list_directories=(
["alacritty"]="/home/oriyia/.config/alacritty/"
["zsh"]="/home/oriyia/.zshrc"
["i3"]="/home/oriyia/.config/i3/config"
["betterlockscreen"]="/home/oriyia/.config/betterlockscreenrc"
["nvim"]="/home/oriyia/.config/nvim/"
["bash_history"]="/home/oriyia/.bash_history"
["bashrc"]="/home/oriyia/.bashrc"
["bash_profile"]="/home/oriyia/.profile"
["python_history"]="/home/oriyia/.python_history"
["xinitrc"]="/home/oriyia/.xinitrc"
["xmodmap"]="/home/oriyia/.Xmodmap"
["xprofile"]="/home/oriyia/.xprofile"
["xresources"]="/home/oriyia/.Xresources"
["polybar"]="/home/oriyia/.config/polybar/"
["ranger"]="/home/oriyia/.config/ranger/"
["pygments"]="/usr/lib/python3/dist-packages/pygments/styles/my.py"
["zathura"]="/home/oriyia/.config/zathura/zathurarc"
["ppa"]="/etc/apt/sources.list"
["rofi"]="/home/oriyia/.config/rofi/config.rasi"
["rofi_theme"]="/home/oriyia/.local/share/rofi/themes/rofi_mytheme_onedark.rasi"
["zsh_history"]="/home/oriyia/.zsh_history"
["zshrc"]="/home/oriyia/.zshrc"
["starship"]="/home/oriyia/.config/starship.toml"
["lsd"]="/home/oriyia/.config/lsd/config.yaml"
["lsd_themes"]="/home/oriyia/.config/lsd/themes/lsd_theme.yaml"
["vivid"]="/home/oriyia/.config/vivid/vivid_mytheme_onedark.yml"
["glow"]="/home/oriyia/.config/glow/glow.yml"
["glamour"]="/home/oriyia/.config/glow/myconf.json"
["ipython_config"]="/home/oriyia/.ipython/profile_default/ipython_config.py")

mkdir "${PWD}/saved_configs/" &> /dev/null
target="${PWD}/saved_configs/"

copying_files()
{
    for key in "${!list_directories[@]}"
    do
        if [[ -d ${list_directories[$key]} ]]
        then
            if cp -aT "${list_directories[$key]}" "${target}${key}"
            then
                echo "+++++ ${key}" >> results.txt
            else
                echo "----- ${key}" >> results.txt
            fi
        else
            mkdir "${target}${key}/" &> /dev/null
            if cp -a "${list_directories[$key]}" "${target}${key}/"
            then
                echo "+++++++ ${key}" >> results.txt
            else
                echo "---------- ${key}" >> results.txt
            fi
        fi
    done
}

copying_files
echo -e "\n${itog}" >> results.txt
