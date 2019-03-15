zabbix_squid3
============================

squid3から直接SNMPで値を取得するためのZabbixテンプレートです。

squid.confを編集し、snmp対応を実施する。

以下のようにsquidにてSNMPの設定を追加しておくこと

# vi /etc/squid/squid.conf
### snmp setting
acl snmppublic snmp_community public  
snmp_port 3401  
snmp_access allow snmppublic localnet  
snmp_access deny all  
snmp_incoming_address 0.0.0.0  
snmp_outgoing_address 0.0.0.0  
