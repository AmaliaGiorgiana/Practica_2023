#!/bin/bash

file_event()
{
	local eveniment="$1"
	local fisier="$2"
	local fisier_bun=$(echo "$fisier" | sed 's/\//_/g')
	local user="$3"
	local time="$4"
	local event_line="[$time] Utilizator: $user, Actiune: $eveniment, Fisier: $fisier_bun"

	local var=$(grep "^\[$time\] Utilizator: $user, Actiune: $eveniment, Fisier: $fisier_bun$" evenimente_fisiere.txt)

	if [[ -n "$var" ]]
	then
		return;
	fi
		echo "[$time] Utilizator: $user, Actiune: $eveniment, Fisier: $fisier_bun" >> "evenimente_fisiere.txt"
}

monitorizare_evenimente()
{
	who | cut -f1 -d' ' | while read -r user
	do
		inotifywait -m -r -e create,delete,modify --format "%e %w" /home | while read -r eveniment fisier
		do
			time=$(date +"%Y-%m-%d %H:%M:%S")

       			file_event "$eveniment" "$fisier" "$user" "$time"
		done
	done
			
}

monitorizare_evenimente



