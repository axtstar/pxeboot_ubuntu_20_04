#!/bin/sh
echo ${interface}
echo ${server_ip}

cat /etc/dnsmasq.d/pxe.conf.template | sed s/\$interface/${interface}/g | sed s/\$iprange_low/${iprange_low}/g | sed s/\$iprange_high/${iprange_high}/g > /etc/dnsmasq.d/pxe.conf
cat /srv/tftp/pxelinux.cfg/default.template | sed s/\$server_ip/${server_ip}/g > /srv/tftp/pxelinux.cfg/default

echo '## /etc/dnsmasq.d/pxe.conf ##'
cat /etc/dnsmasq.d/pxe.conf

echo '## /srv/tftp/pxelinux.cfg/default ##'
cat /srv/tftp/pxelinux.cfg/default
#start dnsmasq
dnsmasq -k
