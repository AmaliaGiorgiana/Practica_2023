#!/bin/bash


file_event()
{
	local eveniment="$1"
	local fisier="$2"
	local user="$3"
	local time=$(date +"%Y-%m-%d %H:%M:%S")
	
	echo "[$time] Utilizator: $user, Actiune: $eveniment, Fisier: $fisier" >> "evenimente_fisiere.txt"
}


monitorizare_evenimente()
{
	who | cut -f1 -d' ' | while read -r user
	do
		inotifywait -m -r -e create,delete,modify --format "%e %w" --timefmt "%Y-%m-%d %H:%M:%S" / | while read -r eveniment fisier time
		do
			file_event "$eveniment" "$fisier" "$user"
		done
	done
			
}

monitorizare_evenimente




