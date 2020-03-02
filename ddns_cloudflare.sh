#!/bin/bash

current_ip=$(curl ip.sb)
echo "current ip: $current_ip"

previous_ip=$(ping imjcker.com -c 2 | sed -e '2,$d' -e 's/^.*imjcker.com (//g' | sed 's/):.*$//g')
echo "previous ip: $previous_ip"

if [[ $current_ip == "$previous_ip" ]]; then
    echo 'server ip is not changed, do nothing.'
    exit 0
fi

# get dns id
getIdResult=$(curl -X GET "https://api.cloudflare.com/client/v4/zones/06440b42f2b66f608c6bb00444e080a4/dns_records?type=A&name=imjcker.com" \
     -H "X-Auth-Email: helloalanturing@icloud.com" \
     -H "X-Auth-Key: 640264cf0ab0e8662ad48ce00c062e888cfa8" \
     -H "Content-Type: application/json")
id=$(echo "$getIdResult" | sed 's/^.*"id":"//g' | sed 's/",".*$//g')
echo "dns id is: $id"

# update dns
log=$(curl -X PUT "https://api.cloudflare.com/client/v4/zones/06440b42f2b66f608c6bb00444e080a4/dns_records/$id" \
     -H "X-Auth-Email: helloalanturing@icloud.com" \
     -H "X-Auth-Key: 640264cf0ab0e8662ad48ce00c062e888cfa8" \
     -H "Content-Type: application/json" \
     -d "{\"type\":\"A\",\"name\":\"imjcker.com\",\"content\":\"$current_ip\",\"ttl\":2,\"proxied\":false}")

# write log
echo "$log" >> ~/ddns.log