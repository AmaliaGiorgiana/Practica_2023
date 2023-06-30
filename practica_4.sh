#!/bin/bash

start_time=$(date "+%Y-%m-%d %H:%M:%S")


while true; do
    
    journalctl -t systemd -S "$start_time" | grep -E "Starting|Stopping" | while read line; do
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
        echo "[${timestamp}] Utilizator: $(whoami) - ${line}" >> "evenimente_procese.txt"
    done

    sleep 2
done 
