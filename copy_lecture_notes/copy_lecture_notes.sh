#!/usr/bin/env bash

source_directory="/home/oriyia/second_brain"
target_directory="/home/oriyia/sync/lecture_notes/"
search_template='.*abstract.pdf'

find "${source_directory}" -type f -regex "${search_template}" -exec cp {} "${target_directory}" \;
