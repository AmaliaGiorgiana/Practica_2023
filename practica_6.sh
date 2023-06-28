#!/bin/bash
PS3="Alege o optiune din meniu" 
monitorizare_pid=()
select ITEM in "Monitorizare /etc" "Centralizare" "Exit" 
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
           if [ -d "centralizare" ]; then
           	rm -rf centralizare
       	   fi
            mkdir centralizare
            cp -f /home/amalia/evenimente_fisiere.txt centralizare/
            cp -f /home/amalia/evenimente_tastatura.txt centralizare/
            cp -f /home/amalia/evenimente_comenzi.txt centralizare/
            cp -f /home/amalia/evenimente_procese.txt centralizare/
            cp -f /home/amalia/activitate_retea.log centralizare/ ;; 
        3) exit 0 ;;   
        *) echo "Optiune incorecta" 
    esac
done 

