#!/bin/bash

# Obține numele utilizatorului curent
username=$(whoami)

# Rulează scriptul în mod continuu
while true; do
    # Afiseaza evenimentele de pornire si oprire pentru utilizatorul curent
    journalctl -t systemd | grep -E "Starting|Stopping" | while read line; do
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
        echo "[${timestamp}] Utilizator: ${username} - ${line}"
    done

    # Pauză de 5 secunde între fiecare iterație
    sleep 5
done >> "evenimente_procese.txt"
