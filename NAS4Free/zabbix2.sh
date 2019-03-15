#!/bin/sh

# Valiable
ZBX_CONF=/usr/local/etc/zabbix2/zabbix_agentd.conf
ZBX_RC=/usr/local/etc/rc.d
ZABBIX_SERVER_IP=$(LANG=C /sbin/ifconfig | grep 'inet addr' | grep -v 127.0.0.1 | awk '{print $2;}' | cut -d: -f2)
SERVER_NAME=`hostname`

# add Zabbix-agent
/usr/sbin/pkg_add -r zabbix2-agent

# copy configure
/bin/cp ${ZBX_CONF}.sample ${ZBX_CONF}

# Value reWritable
sed -i '' -e 's/Server=127.0.0.1/Server='${ZABBIX_SERVER_IP}'/' ${ZBX_CONF}
sed -i '' -e 's/ServerActive=127.0.0.1/ServerActive='${ZABBIX_SERVER_IP}'/' ${ZBX_CONF}
sed -i '' -e 's/Hostname=Zabbix\ server/Hostname='${SERVER_NAME}'/' ${ZBX_CONF}
sed -i '' -e 's/\#\ EnableRemoteCommands=0/EnableRemoteCommands=1/' ${ZBX_CONF}

# auto start config
echo "zabbix_agentd_enable=\"YES\"" >> /etc/rc.conf

# Zabbix agent start
${ZBX_RC}/zabbix_agentd start
