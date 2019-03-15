#!/bin/bash
ROUTER_IP=$1
CORE=$2
OID=".1.3.6.1.2.1.25.3.3.1.2"
snmpwalk -v2c -c public -On $ROUTER_IP $OID | awk '{ print($4) }' | awk 'BEGIN{sum=0}{sum+=$1}END{print int(sum/$CORE)}'
