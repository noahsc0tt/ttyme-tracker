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
INFO=0
TODAY=0
WEEK=0
MONTH=0
YEAR=0
STOP=0
DELETE=0

function show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "If no options are provided, you will be prompted to choose a tag to start a new session with."
    echo
    echo "Options:"
    echo "  -c, --continue    Continue the previous session"
    echo "  -i, --info        Show current timewarrior status"
    echo "  -t, --today       Show today's summary"
    echo "  -w, --week        Show this week's summary"
    echo "  -m, --month       Show this month's summary"
    echo "  -y, --year        Show this year's summary"
    echo "  -s, --stop        Stop the current timewarrior task"
    echo "  -d, --delete      Delete a timewarrior entry"
    echo "  -h, --help        Show this help message"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c|--continue) CONTINUE=1; shift;;
        -i|--info) INFO=1; shift;;
        -t|--today) TODAY=1; shift;;
        -w|--week) WEEK=1; shift;;
        -m|--month) MONTH=1; shift;;
        -y|--year) YEAR=1; shift;;
        -s|--stop) STOP=1; shift;;
        -d|--delete) DELETE=1; shift;;
        -h|--help) show_help; exit 0;;
        *) echo "unknown option: $1"; show_help; exit 1;;
    esac
done

if [[ $CONTINUE -eq 1 ]]; then
    timew continue
elif [[ $STOP -eq 1 ]]; then
    timew stop
elif [[ $DELETE -eq 1 ]]; then
    session=$(timew summary :year \
        | tail -n +4 | head -n -3 \
        | tac \
        | sed 's/^[^@]*//; s/ .*$//' \
        | fzf --preview 'timew summary {}')
    [[ -n $session ]] && timew delete "$session"
elif [[ $INFO -eq 1 ]]; then
    timew
elif [[ $TODAY -eq 1 ]]; then
    timew summary :day
elif [[ $WEEK -eq 1 ]]; then
    timew summary :week
elif [[ $MONTH -eq 1 ]]; then
    timew summary :month
elif [[ $YEAR -eq 1 ]]; then
    timew summary :year
else
    tag="$(printf "%s\n" "${TAGS[@]}" | fzf --preview "timew summary :week {}")"
    [ -n "$tag" ] && timew start "$tag"
fi
