#!/bin/bash
PS3="Alege o optiune din meniu" 
monitorizare_pid=()
select ITEM in "Monitorizare" "Centralizare" "Exit" 
do 
    case $REPLY in 
        1)echo "Monitorizare Activata"
          ./practica_1.sh &
          ./practica_2.sh &
          ./practica_3.sh &
          ./practica_4.sh &
          ./practica_5.sh & 
          monitorizare_pid+=($!)
          monitorizare_pid+=($!)
          monitorizare_pid+=($!)
          monitorizare_pid+=($!)
          monitorizare_pid+=($!)
          ;; 
        2) echo "Monitorizare Dezactivata--Centralizare Activata"
            
           for pid in "${monitorizare_pid[@]}"
            do
                kill "$pid"
            done

            cp -f /home/amalia/evenimente_fisiere.txt centralizare_fisiere/
            cp -f /home/amalia/evenimente_tastatura.txt centralizare_fisiere/
            cp -f /home/amalia/evenimente_comenzi.txt centralizare_fisiere/
            cp -f /home/amalia/evenimente_procese.txt centralizare_fisiere/
            cp -f /home/amalia/activitate_retea.txt centralizare_fisiere/ ;; 
        3) exit 0 ;;   
        *) echo "Optiune incorecta" 
    esac
done 
