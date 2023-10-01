#!/usr/bin/env bash

find "${SECOND_BRAIN}" -type f -regex '.*abstract.pdf' -exec cp {} "${LECTURE_NOTES}" \;
