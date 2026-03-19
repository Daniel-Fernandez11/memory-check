#!/bin/bash

# memory-check

# Check dependencies

check_dependencies() {

    for cmd in free awk clear sleep; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "ERROR: required command '$cmd' not found"
            exit 1
        fi
    done

}

# Get memory info

get_memory_info() {

    free -m | awk 'NR==2 {
        total=$2
        used=$3
        free=$4
        available=$7

        printf "%s %s %s %s\n", total, used, free, available
    }'

}

# Get swap info

get_swap_info() {

    free -m | awk 'NR==3 {
        total=$2
        used=$3
        free=$4

        printf "%s %s %s\n", total, used, free
    }'

}

# Print memory summary

print_memory_summary() {

    read total used free available <<< $(get_memory_info)

    echo "MEMORY STATUS"
    echo "--------------------------------"

    printf "%-20s %s MB\n" "Total RAM:" "$total"
    printf "%-20s %s MB\n" "Used RAM:" "$used"
    printf "%-20s %s MB\n" "Free RAM:" "$free"
    printf "%-20s %s MB\n" "Available RAM:" "$available"

}

# Print swap summary

print_swap_summary() {

    read total used free <<< $(get_swap_info)

    echo ""
    echo "SWAP"
    echo "--------------------------------"

    printf "%-20s %s MB\n" "Total Swap:" "$total"
    printf "%-20s %s MB\n" "Used Swap:" "$used"
    printf "%-20s %s MB\n" "Free Swap:" "$free"

}

# Memory alert

check_memory_alert() {

    threshold=$1

    read total used free available <<< $(get_memory_info)

    if [ "$available" -lt "$threshold" ]; then
        echo ""
        echo "WARNING: Low memory available! (${available} MB)"
    fi

}

# Watch mode

watch_mode() {

    while true; do

        clear

        print_memory_summary
        print_swap_summary

        sleep 2

    done

}

# Main

main() {

    check_dependencies

    case "$1" in

        --watch)
            watch_mode
            ;;

        --alert)
            if [ -z "$2" ]; then
                echo "Usage: memory-check --alert <MB>"
                exit 1
            fi
            print_memory_summary
            print_swap_summary
            check_memory_alert "$2"
            ;;

        *)
            print_memory_summary
            print_swap_summary
            ;;

    esac

}

main "$@"
