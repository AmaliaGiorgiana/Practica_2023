##!/bin/bash


file_event()
{
	local time="$1"
	local user="$2"
	local comanda="$3"

	local var=$(grep "^\[$time\] Utilizator: $user, Comanda executată: $comanda" evenimente_comenzi.txt)

	if [[ -n "$var" ]]
	then
		return;
	fi
		echo "[${time}] Utilizator: $user, Comandă executată: $comanda" >> "evenimente_comenzi.txt"
}

auditctl -D
auditctl -a exit,always -F arch=b64 -S execve 

while true
do
        ausearch -i -sc execve -ts now | grep -E 'type=EXECVE.*a[01]=' | grep -vE 'a[01]=root|a[01]=audit'  | grep -o -E 'a0=[^ ]+' | grep -o -E '[^=]+$'|while read line; do
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
        file_event "$timestamp" "$(whoami)" "$line"

    done
done
