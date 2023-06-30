#!/bin/bash


log_event() 
{
	local log_file="$1"
	local log_line="$2"
	local last_line="$(tail -n 1 "$log_file" 2>/dev/null)"
	if [[ "$log_line" != "$last_line" ]]
	then
        	echo "$(date +"%Y-%m-%d %H:%M:%S"): $log_line" >> "$log_file"
    	fi
}

log_file="activitate_retea.txt"

logged_in_users=$(who | cut -f1 -d" ")
while true
do
	
	for user in $logged_in_users 
	do

    	#interogările DNS, portul 53 pentru serviciul DNS
    	dns_queries=$(tcpdump -l -n -c 10 udp port 53 2>/dev/null | cut -f3 -d" " | grep -v "0.0.0.0") 
        if [[ -n $dns_queries ]]
        then
            log_event "$log_file" "Interogări DNS efectuate de $user:"
            for query in $dns_queries
            do
                log_event "$log_file" "  - $query"
            done
        fi

    	#adresele IP
    	ip_addresses=$(tcpdump -l -n -c 10 | cut -f3 -d" " | grep -v "0.0.0.0")
        if [[ -n $ip_addresses ]]
        then
            log_event "$log_file" "Adrese IP accesate de $user:"
            for ip in $ip_addresses
            do
                log_event "$log_file" "  - $ip"
            done
        fi

    	#traficul
    	traffic=$(tcpdump -l -n -c 10 2>/dev/null)
        if [[ -n $traffic ]]
        then
            log_event "$log_file" "Trafic observat pentru $user:"
            log_event "$log_file" "$traffic"
        fi
    done
    sleep 3
 
done

