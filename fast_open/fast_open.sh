#!/usr/bin/env bash

# constants
lecture_notes=/home/oriyia/second_brain
pattern_search=abstracts
directory_books=/home/oriyia/yandex/books

function close_terminal {
    pid_terminal=$(awk '{print $4}' "/proc/$PPID/stat")
    kill -9 "$pid_terminal"
}

# поиск по СОДЕРЖИМОМУ среди всех файлов и открытие в nvim
if [[ ${1} = '-n' ]]
then
    rg --color=always --line-number --no-heading --smart-case "" |
      fzf --ansi \
          --color "hl:-1:underline,hl+:-1:underline:reverse" \
          --delimiter : \
          --preview 'batcat --color=always {1} --highlight-line {2}' \
          --preview-window 'up,border-bottom,+{2}+3/3,~3' \
          --bind 'enter:become(nvim {1} +{2})'
# поиск по содержимому в lecture_notes и открытие найденной строки файла pdf в zathura
elif [[ ${1} = '-z' ]]
then
    fd -e tex --search-path "${lecture_notes}" -X \
        rg --color=always --line-number --no-heading --smart-case '' |
          fzf --ansi \
              --color "hl:-1:underline,hl+:-1:underline:reverse" \
              --delimiter : \
              --preview 'batcat --color=always {1} --highlight-line {2}' \
              --preview-window 'up,border-bottom,+{2}+3/3,~3' \
              --bind 'enter:become(nohup zathura --synctex-forward {2}:1:{1} $(a=${1} ; echo ${a//.tex/.pdf}) &)'
    close_terminal
# выбор pdf книги в yandex и открытие в zathura
elif [[ ${1} = '-b' ]]
then
    declare -A books

    for book in $(find "${directory_books}" -name '*.pdf'); do
        books[${book##*"${directory_books}"}]=$book
    done

    keys_books=${!books[*]}
    selected_book=$(fzf <<< "${keys_books// /$'\n'}")

    zathura "${books[$selected_book]}" &
    disown %1
    close_terminal
# выбор pdf конспекта и открытие его в zathura
elif [[ ${1} = '-a' ]]
then
    declare -A books

    for book in $(find "${lecture_notes}" -type f -regex ".*/.*${pattern_search}?\.pdf"); do
        books[${book##*"${pattern_search}"}]=$book
    done

    keys_books=${!books[*]}
    selected_book=$(fzf <<< "${keys_books// /$'\n'}")

    zathura "${books[$selected_book]}" &
    disown %1
    close_terminal
# Поиск по имени файлов домашнего каталога и открытие в nvim
elif [[ ${1} = '-f' ]]
then
    find ~+ | fzf --bind 'enter:become(nvim {})'
else
    echo exit
fi

