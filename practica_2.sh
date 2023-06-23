#!/bin/bash

counter=0
counter1=0
while true;
 do
    who | while read utilizator terminal data ora; 
    do
        xinput test-xi2 --root 11 --event-types 2 -l -no-repeats | while read eveniment; 
        do
        counter1=$(($counter1+1))
        if [[ $counter1 -gt 4 ]]
        then
        echo "$eveniment">> test.txt
          if [[ counter -eq 9 ]] 
          then
          counter=0
          echo "$timp - $utilizator -$cod_tasta" >>    evenimente_tastatura.txt
          else 
          counter=$(($counter+1))
          fi
        timp=$(date +"%Y-%m-%d %H:%M:%S")
        cod_tasta=$(echo "$eveniment" | sed -n 's/.*detail: \([0-9]\+\).*/\1/p' | head -n 1)
        fi
        done
    done
done
