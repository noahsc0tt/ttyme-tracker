#!/usr/bin/env bash

CONTINUE=0
STOP=0

while [[ $# -gt 0 ]]; do
    case "$1" in
      -c|--continue) CONTINUE=1; shift;;
      -s|--stop) STOP=1; shift;;
      *) echo "unknown option: $1"; exit 1;;
    esac
done

if [[ $CONTINUE -eq 1 ]]; then
    timew continue
elif [[ $STOP -eq 1 ]]; then
    timew stop
else
    TAGS=(
        "Config"
        "Life"
        "Relax"
        "University"
        "Work"
        "Waste"
    )
    timew start "$(printf "%s\n" "${TAGS[@]}" | fzf --preview-window hidden)"
fi
