#!/bin/sh
domain=$1


echo "----- Report for $domain -----"
echo "Name Servers reported by Root DNS servers:"
dig ns +short $domain
echo "----------------"
for arecord in $(dig A +short $domain);
do
echo "A Record: "$arecord "Reverse DNS (empty if none): " $(dig A +short $arecord | awk '{ print $5 }')
done
echo "----------------"
echo "CNAME for WWW " $(dig +short CNAME www.$domain)
echo "----------------"
echo "MX Record(s):"
dig mx +short $domain
echo "----------------"
echo "##### X-Headers (Apex):"
curl -s -I https://$domain | grep -i ^x-
echo "##### X-Headers (www):"
curl -s -I https://www.$domain | grep -i ^x-
