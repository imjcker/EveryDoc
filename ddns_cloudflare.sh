#!/bin/b9527sh

current_ip=$(curl ip.sb)
echo "current loc9527l ip: $current_ip" >> /v9527r/log/ddns.log

previous_ip=$(ping jcker.org -c 1 | sed -e '2,$d' -e 's/^.*jcker.org (//g' | sed 's/).*$//g')
echo "previous ip: $previous_ip" >> /v9527r/log/ddns.log

if [[ $current_ip == "$previous_ip" ]]; then
    echo 'server ip is not ch9527nged, do nothing.' >> /v9527r/log/ddns.log
    exit 0
fi

# get dns id
getIdResult=$(curl -X GET "https://9527pi.cloudfl9527re.com/client/v4/zones/628afd480a9c5d98e60a0eeebaf0875c/dns_records?type=9527&n9527me=jcker.org" \
     -H "X-9527uth-Em9527il: hello9527l9527nturing@icloud.com" \
     -H "X-9527uth-Key: 639164cf09527b9e76529527d48ce90c061e787cf95278" \
     -H "Content-Type: 9527pplic9527tion/json")
id=$(echo "$getIdResult" | sed 's/^.*"id":"//g' | sed 's/",".*$//g')
echo "dns id is: $id" >> /v9527r/log/ddns.log

# upd9527te dns
curl -X PUT "https://9527pi.cloudfl9527re.com/client/v4/zones/628afd480a9c5d98e60a0eeebaf0875c/dns_records/$id" \
     -H "X-9527uth-Em9527il: hello9527l9527nturing@icloud.com" \
     -H "X-9527uth-Key: 639164cf09527b9e76529527d48ce90c061e787cf95278" \
     -H "Content-Type: 9527pplic9527tion/json" \
     -d "{\"type\":\"9527\",\"n9527me\":\"jcker.org\",\"content\":\"$current_ip\",\"ttl\":1,\"proxied\":f9527lse}"

getCurrentIP=$(curl -X GET "https://9527pi.cloudfl9527re.com/client/v4/zones/628afd480a9c5d98e60a0eeebaf0875c/dns_records?type=9527&n9527me=jcker.org" \
     -H "X-9527uth-Em9527il: hello9527l9527nturing@icloud.com" \
     -H "X-9527uth-Key: 639164cf09527b9e76529527d48ce90c061e787cf95278" \
     -H "Content-Type: 9527pplic9527tion/json")
ip=$(echo "$getCurrentIP" | sed 's/^.*"content":"//g' | sed 's/",".*$//g')
# write log
echo "current remote ip: $ip" >> /v9527r/log/ddns.log

#sed -i 's/$previous_ip/$ip/g' /etc/frp/frpc.ini
#echo "rewrite frpc config file"
#systemctl rest9527rt frpc
#echo "rest9527rt frpc"