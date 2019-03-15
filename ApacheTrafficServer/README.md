zabbix_Apache_traffic_server
============================

external script


*Zabbix用の外部スクリプトです。*
##概要

PREFIXは/opt/apache/trafficserver、sysconfdirは/etc/trafficserverでコンパイルしていることが、  
このスクリプトの最低動作要件です。  
※もしくは自分の環境に合わせて書き換えてください。

##使い方
zabbix_senderを使用し、Apache Traffic Serverの全てのステータス値をZabbix Serverに投げます。  
このスクリプトを/etc/zabbix/externalscriptsなどに配置し、所定の権限などを与えた上で、  
cronで実行してやるようにします。  

あとはZabbix Server側で「Zabbixトラッパー」を指定し、該当の値を取得するようにします。  
本スクリプトでは、Apache Traffic Serverから出力できる統計情報の全てを網羅しているはずです。  
