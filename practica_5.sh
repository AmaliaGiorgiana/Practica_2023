#!/bin/bash

# Verificăm dacă scriptul este rulat cu privilegii de root
if [[ $EUID -ne 0 ]]; then
   echo "Acest script trebuie rulat cu privilegii de root." 
   exit 1
fi

# Funcție pentru a înregistra evenimentul cu marca temporală
log_event() {
    echo "$(date +"%Y-%m-%d %H:%M:%S"): $1"
}

# Urmărim acțiunile utilizatorilor logați
logged_in_users=$(who | awk '{print $1}')

for user in $logged_in_users; do
    log_event "Utilizator logat: $user"

    # Urmărim interogările DNS
    dns_queries=$(tcpdump -l -n -c 10 udp port 53 2>/dev/null | awk '{print $3}' | grep -v "0.0.0.0")
    if [[ -n $dns_queries ]]; then
        log_event "Interogări DNS efectuate de $user:"
        for query in $dns_queries; do
            log_event "  - $query"
        done
    fi

    # Urmărim adresele IP
    ip_addresses=$(tcpdump -l -n -c 10 | awk '{print $3}' | grep -v "0.0.0.0")
    if [[ -n $ip_addresses ]]; then
        log_event "Adrese IP accesate de $user:"
        for ip in $ip_addresses; do
            log_event "  - $ip"
        done
    fi

    # Urmărim traficul
    traffic=$(tcpdump -l -n -c 10 2>/dev/null)
    if [[ -n $traffic ]]; then
        log_event "Trafic observat pentru $user:"
        log_event "$traffic"
    fi
done

# Exemplu de utilizare pentru a urmări activitatea utilizatorilor logați
#./script.sh >> activitate_retea.log

