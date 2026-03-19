# Memory Checky

A Linux CLI tool to monitor system memory usage (RAM and Swap).

This tool helps quickly identify memory availability, usage, and potential low-memory situations from the terminal.


## Features

- Show total, used, free, and available RAM
- Show swap usage
- Alert when available memory is low
- Watch mode
- Clean formatted output

## Requirements

Linux system with:

free
awk
clear
sleep

## Usage

### Show memory summary

./memory-check.sh

### Alert on low memory

./memory-check.sh --alert 500

Shows warning if available RAM is below 500 MB

### Watch mode (live monitoring)

./memory-check.sh --watch

Refreshes every 2 seconds

Stop with: CTRL + C

## Example Output

MEMORY STATUS
--------------------------------
Total RAM:           32000 MB
Used RAM:            18450 MB
Free RAM:            2100 MB
Available RAM:       11800 MB

SWAP
--------------------------------
Total Swap:          4096 MB
Used Swap:           512 MB
Free Swap:           3584 MB

## Author

Jose Daniel Fernández - GitHub: https://github.com/Daniel-Fernandez11
