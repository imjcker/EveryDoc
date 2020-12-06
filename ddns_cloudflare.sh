#!/bin/bash

current_ip=$(curl ip.sb)
echo "current local ip: $current_ip" > /var/log/ddns.log

previous_ip=$(ping imjcker.com -c 1 | sed -e '2,$d' -e 's/^.*imjcker.com (//g' | sed 's/).*$//g')
echo "previous ip: $previous_ip" >> /var/log/ddns.log

if [[ $current_ip == "$previous_ip" ]]; then
    echo 'server ip is not changed, do nothing.' >> /var/log/ddns.log
    exit 0
fi

# get dns id
getIdResult=$(curl -X GET "https://api.cloudflare.com/client/v4/zones/96339b32f2b65f607c5bb90344e989a4/dns_records?type=A&name=imjcker.com" \
     -H "X-auth-Email: helloalanturing@icloud.com" \
     -H "X-auth-Key: 639164cf0ab9e7652ad48ce90c061e787cfa8" \
     -H "Content-Type: application/json")
id=$(echo "$getIdResult" | sed 's/^.*"id":"//g' | sed 's/",".*$//g')
echo "dns id is: $id" >> /var/log/ddns.log

# update dns
echo "update dns"
curl -X PUT "https://api.cloudflare.com/client/v4/zones/96339b32f2b65f607c5bb90344e989a4/dns_records/$id" \
     -H "X-auth-Email: helloalanturing@icloud.com" \
     -H "X-auth-Key: 639164cf0ab9e7652ad48ce90c061e787cfa8" \
     -H "Content-Type: application/json" \
     -d "{\"type\":\"A\",\"name\":\"imjcker.com\",\"content\":\"$current_ip\",\"ttl\":2,\"proxied\":false}"

getCurrentIP=$(curl -X GET "https://api.cloudflare.com/client/v4/zones/96339b32f2b65f607c5bb90344e989a4/dns_records?type=A&name=imjcker.com" \
     -H "X-auth-Email: helloalanturing@icloud.com" \
     -H "X-auth-Key: 639164cf0ab9e7652ad48ce90c061e787cfa8" \
     -H "Content-Type: application/json")
ip=$(echo "$getCurrentIP" | sed 's/^.*"content":"//g' | sed 's/",".*$//g')
# write log
echo "current remote ip: $ip" >> /var/log/ddns.log
