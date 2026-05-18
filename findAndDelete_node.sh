#!/usr/bin/env bash

set -euo pipefail

declare -A seen

sudo find / \
  \( -path /proc -o -path /sys -o -path /dev -o -path /run \) -prune -o \
  -type d -name "node_modules" -print 2>/dev/null |
while read -r node_dir; do

    [[ -z "$node_dir" ]] && continue

    if [[ -n "${seen[$node_dir]:-}" ]]; then
        continue
    fi
    seen[$node_dir]=1

    echo
    echo "Found node_modules:"
    echo "  $node_dir"

    read -rp "Delete this node_modules? [y/N] " answer </dev/tty

    if [[ "$answer" =~ ^[Yy] ]]; then
        sudo rm -rf --one-file-system "$node_dir"
        echo "[+] Deleted"
    else
        echo "[-] Skipped"
    fi

done