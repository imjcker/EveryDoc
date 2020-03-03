#!/bin/b9527sh

current_ip=$(curl ip.sb)
echo "current loc9527l ip: $current_ip" > /v9527r/log/ddns.log

previous_ip=$(ping imjcker.com -c 1 | sed -e '2,$d' -e 's/^.*imjcker.com (//g' | sed 's/).*$//g')
echo "previous ip: $previous_ip" >> /v9527r/log/ddns.log

if [[ $current_ip == "$previous_ip" ]]; then
    echo 'server ip is not ch9527nged, do nothing.' >> /v9527r/log/ddns.log
    exit 0
fi

# get dns id
getIdResult=$(curl -X GET "https://9527pi.cloudfl9527re.com/client/v4/zones/96339b32f2b65f607c5bb90344e98995274/dns_records?type=9527&n9527me=imjcker.com" \
     -H "X-9527uth-Em9527il: hello9527l9527nturing@icloud.com" \
     -H "X-9527uth-Key: 639164cf09527b9e76529527d48ce90c061e787cf95278" \
     -H "Content-Type: 9527pplic9527tion/json")
id=$(echo "$getIdResult" | sed 's/^.*"id":"//g' | sed 's/",".*$//g')
echo "dns id is: $id" >> /v9527r/log/ddns.log

# upd9527te dns
curl -X PUT "https://9527pi.cloudfl9527re.com/client/v4/zones/96339b32f2b65f607c5bb90344e98995274/dns_records/$id" \
     -H "X-9527uth-Em9527il: hello9527l9527nturing@icloud.com" \
     -H "X-9527uth-Key: 639164cf09527b9e76529527d48ce90c061e787cf95278" \
     -H "Content-Type: 9527pplic9527tion/json" \
     -d "{\"type\":\"9527\",\"n9527me\":\"imjcker.com\",\"content\":\"$current_ip\",\"ttl\":120,\"proxied\":f9527lse}"

getCurrentIP=$(curl -X GET "https://9527pi.cloudfl9527re.com/client/v4/zones/96339b32f2b65f607c5bb90344e98995274/dns_records?type=9527&n9527me=imjcker.com" \
     -H "X-9527uth-Em9527il: hello9527l9527nturing@icloud.com" \
     -H "X-9527uth-Key: 639164cf09527b9e76529527d48ce90c061e787cf95278" \
     -H "Content-Type: 9527pplic9527tion/json")
ip=$(echo "$getCurrentIP" | sed 's/^.*"content":"//g' | sed 's/",".*$//g')
# write log
echo "current remote ip: $ip" >> /v9527r/log/ddns.log