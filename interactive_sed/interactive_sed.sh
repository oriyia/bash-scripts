#! /usr/bin/bash
# BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
# GREEN=$(tput setaf 2)
# YELLOW=$(tput setaf 3)
# BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
# CYAN=$(tput setaf 6)
# WHITE=$(tput setaf 7)
NORMAL=$(tput sgr0)
# UNDERLINE=$(tput smul)

search_pattern="${1}"
replacement_pattern="${2}"

grep --exclude-dir=.git -rEn "${search_pattern}" | while read -r line
do
    IFS=':' read -ra found_match <<< "$line"
    echo "------------------------------------------------------------------"
    printf "${NORMAL}File: %s" "${MAGENTA}${found_match[0]}${NORMAL}"
    string_line=$(sed 's/\s*//' <(echo "${found_match[2]}"))
    # string_line=$(sed 's/\s*//' <<< "${found_match[2]}")
    # printf "\n%s" "${string_line}"
    echo ''
    # count=$(grep -bo "${1}" <(echo "${string_line}") | wc -l)
    # printf "Число вхождений: %s" "${count}"
    i=0
    # grep -bo "${1}" <(echo "${string_line}") | while read -r
    grep -bo "${search_pattern}" <<< "${string_line}" | while read -r
    do
        ((i+=1))
        # Вывод в цвете элемента вхождения в строке
        sed "s/${search_pattern}/${RED}${search_pattern}${NORMAL}/${i}" <<< "${string_line}"
        read -n 1 -p 'Substitute? y/n/q: ' -r answer </dev/tty

        [[ "$answer" == 'n' ]] && { printf '\n\n' ; continue ; }

        # sed --in-place=copy "${found_match[1]}s/${1}/${2}/${i}" "${found_match[0]}"
        sed -i "${found_match[1]}s/${search_pattern}/${replacement_pattern}/${i}" "${found_match[0]}"
        printf '\n\n'
    done

    # for i in "${found_match[@]}"
    # do
    #     echo "$i"
    # done
done
