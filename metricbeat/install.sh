#!/bin/bash
ip_addr="$1"
index="$2"
port="$3"
echo "creating metricbeat directory"
mkdir /DATA/metricbeat
mkdir /DATA/metricbeat/share
mkdir /DATA/metricbeat/data
echo "linking directories"
ln -s /DATA/metricbeat/share/ /usr/share/metricbeat
ln -s /DATA/metricbeat/data/ /var/lib/metricbeat
echo "installing metricbeat"
rpm -i metricbeat-7.11.2-x86_64.rpm
echo "metricbeat installed"

echo "updating config"

cp metricbeat.template metricbeat.template.real
sed -i "s/_IP_/$ip_addr/g" metricbeat.template.real
sed -i "s/_INDEX_/$index/g" metricbeat.template.real
sed -i "s/_PORT_METRIC/$port/g" metricbeat.template.real
mv -f metricbeat.template.real /etc/metricbeat/metricbeat.yml
echo "config updated"
echo "Starting service"
service metricbeat start
