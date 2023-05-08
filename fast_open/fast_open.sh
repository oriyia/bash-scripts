#!/usr/bin/env bash

# 1. Search for text in files using Ripgrep
# 2. Interactively restart Ripgrep with reload action
# 3. Open the file in Vim
# RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
# INITIAL_QUERY="${*:-}"
# FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
# fzf --ansi \
#     --disabled --query "$INITIAL_QUERY" \
#     --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
#     --delimiter : \
#     --preview 'batcat --color=always {1} --highlight-line {2}' \
#     --preview-window 'up,border-bottom,+{2}+3/3,~3' \
#     --bind 'enter:become(nvim {1} +{2})'
abstracts=/home/oriyia/abstracts/

# просто поиск по содержимому
if [[ ${1} = '-n' ]]
then
    rg --color=always --line-number --no-heading --smart-case "" |
      fzf --ansi \
          --color "hl:-1:underline,hl+:-1:underline:reverse" \
          --delimiter : \
          --preview 'batcat --color=always {1} --highlight-line {2}' \
          --preview-window 'up,border-bottom,+{2}+3/3,~3' \
          --bind 'enter:become(nvim {1} +{2})'
# открытие найденной строки в zathura
elif [[ ${1} = '-z' ]]
then
    fd -e tex --search-path ${abstracts} -X \
        rg --color=always --line-number --no-heading --smart-case '' |
          fzf --ansi \
              --color "hl:-1:underline,hl+:-1:underline:reverse" \
              --delimiter : \
              --preview 'batcat --color=always {1} --highlight-line {2}' \
              --preview-window 'up,border-bottom,+{2}+3/3,~3' \
              --bind 'enter:become(nohup zathura --synctex-forward {2}:1:{1} $(a=${1} ; echo ${a//.tex/.pdf}) &)'
else
    echo exit
fi

kill -KILL $PPID
