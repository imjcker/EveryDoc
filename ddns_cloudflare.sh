#!/bin/bash

current_ip=$(curl ip.sb)
echo "current ip: $current_ip"

previous_ip=$(ping imjcker.com -c 1 | sed -e '2,$d' -e 's/^.*imjcker.com (//g' | sed 's/):.*$//g')
echo "previous ip: $previous_ip"

if [[ $current_ip == "$previous_ip" ]]; then
    echo 'server ip is not changed, do nothing.'
    exit 0
fi

# get dns id
getIdResult=$(curl -X GET "https://api.cloudflare.com/client/v4/zones/96339b32f2b65f607c5bb90344e989a4/dns_records?type=A&name=imjcker.com" \
     -H "X-Auth-Email: helloalanturing@icloud.com" \
     -H "X-Auth-Key: 639164cf0ab9e7652ad48ce90c061e787cfa8" \
     -H "Content-Type: application/json")
id=$(echo "$getIdResult" | sed 's/^.*"id":"//g' | sed 's/",".*$//g')
echo "dns id is: $id"

# update dns
log=$(curl -X PUT "https://api.cloudflare.com/client/v4/zones/96339b32f2b65f607c5bb90344e989a4/dns_records/$id" \
     -H "X-Auth-Email: helloalanturing@icloud.com" \
     -H "X-Auth-Key: 639164cf0ab9e7652ad48ce90c061e787cfa8" \
     -H "Content-Type: application/json" \
     -d "{\"type\":\"A\",\"name\":\"imjcker.com\",\"content\":\"$current_ip\",\"ttl\":1,\"proxied\":false}")

# write log
echo "$log" >> ~/ddns.log