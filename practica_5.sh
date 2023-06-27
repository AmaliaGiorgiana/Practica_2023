#!/bin/bash

# Verificăm dacă scriptul este rulat cu privilegii de root
if [[ $EUID -ne 0 ]]; then
   echo "Acest script trebuie rulat cu privilegii de root." 
   exit 1
fi

# Funcție pentru a înregistra evenimentul cu marca temporală
log_event() 
{
	local log_file="$1"
	local log_line="$2"
	local last_line="$(tail -n 1 "$log_file" 2>/dev/null)"
	if [[ "$log_line" != "$last_line" ]]; then
        	echo "$(date +"%Y-%m-%d %H:%M:%S"): $log_line" >> "$log_file"
    	fi
}

log_file="activitate_retea.log"

# Urmărim acțiunile utilizatorilor logați
	logged_in_users=$(who | awk '{print $1}')
while true; do
	
	for user in $logged_in_users; do
    		log_event "$log_file" "Utilizator logat: $user"

    	# Urmărim interogările DNS
    	dns_queries=$(tcpdump -l -n -c 10 udp port 53 2>/dev/null | awk '{print $3}' | grep -v "0.0.0.0")
        if [[ -n $dns_queries ]]; then
            log_event "$log_file" "Interogări DNS efectuate de $user:"
            for query in $dns_queries; do
                log_event "$log_file" "  - $query"
            done
        fi

    	# Urmărim adresele IP
    	ip_addresses=$(tcpdump -l -n -c 10 | awk '{print $3}' | grep -v "0.0.0.0")
        if [[ -n $ip_addresses ]]; then
            log_event "$log_file" "Adrese IP accesate de $user:"
            for ip in $ip_addresses; do
                log_event "$log_file" "  - $ip"
            done
        fi

    	# Urmărim traficul
    	traffic=$(tcpdump -l -n -c 10 2>/dev/null)
        if [[ -n $traffic ]]; then
            log_event "$log_file" "Trafic observat pentru $user:"
            log_event "$log_file" "$traffic"
        fi
    done
 
done

