#!/bin/bash
ip_addr="$1"
index="$2"
port="$3"
echo "creating filebeat directory"
mkdir /DATA/filebeat
mkdir /DATA/filebeat/share
mkdir /DATA/filebeat/data
echo "linking directories"
ln -s /DATA/filebeat/share/ /usr/share/filebeat
ln -s /DATA/filebeat/data/ /var/lib/filebeat
echo "installing filebeat"
rpm -i filebeat-7.11.2-x86_64.rpm
echo "filebeat installed"
cp filebeat.template filebeat.template.real
sed -i "s/_IP_/$ip_addr/g" filebeat.template.real
sed -i "s/_INDEX_/$index/g" filebeat.template.real
sed -i "s/_PORT_/$port/g" filebeat.template.real
mv -f filebeat.template.real /etc/filebeat/filebeat.yml
