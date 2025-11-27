#!/usr/bin/env bash

TAGS=(
    "Config"
    "Life"
    "Relax"
    "University"
    "Work"
    "Waste"
)

CONTINUE=0
STOP=0
INFO=0

function show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  -c, --continue    Continue the previous activity"
    echo "  -i, --info        Show this help message"
    echo "  -s, --stop        Stop the current timewarrior task"
    echo "  -h, --help        Show this help message"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) show_help; exit 0;;
        -c|--continue) CONTINUE=1; shift;;
        -i|--info) INFO=1; shift;;
        -s|--stop) STOP=1; shift;;
        *) echo "unknown option: $1"; show_help; exit 1;;
    esac
done

if [[ $CONTINUE -eq 1 ]]; then
    timew continue
elif [[ $STOP -eq 1 ]]; then
    timew stop
elif [[ $INFO -eq 1 ]]; then
    timew
    timew summary
else
    tag="$(printf "%s\n" "${TAGS[@]}" | fzf --preview "timew summary :week {}")"
    [ -n "$tag" ] && timew start "$tag"
fi
