##!/bin/bash

# Configurăm auditd pentru a urmări comenzile executate
auditctl -D 
echo "Pas1"
auditctl -a exit,always -F arch=b64 -S execve -F exe=/usr/bin/*
echo "Pas2"
# Citim jurnalul de audit și afișăm informațiile relevante
while true; do
	echo "Pas3"
    ausearch -i -sc execve -ts now | grep -E 'type=EXECVE.*a[01]=' | grep -vE 'a[01]=root|a[01]=audit'| grep -v 'msg=audit' | while read line; do
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
        echo "[${timestamp}] Utilizator: $USER - Comandă executată: $line"
        echo "Pas4"
    done
done
