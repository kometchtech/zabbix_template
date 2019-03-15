#!/bin/sh

# Variable
UNIXTIME=" "`date '+%s'`" "
ZBX_SENDER="/usr/bin/zabbix_sender"
ZBX_SERVER=""
ZBX_SERVER_PORT="10051"
HOSTNAME=`hostname`" "
ATSPATH=/opt/apache/trafficserver/bin
TMP_FILE1=/tmp/ats_stats_tmp

# Apache Traffic Server stats
echo "hostname" ${UNIXTIME} ${ATSPATH}/traffic_line -r proxy.node.hostname >> ${TMP_FILE1}
echo "Objects_served"  ${UNIXTIME}  `${ATSPATH}/traffic_line -r proxy.node.user_agents_total_documents_served` >> ${TMP_FILE1}
echo "Transactions_per_second" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.user_agent_xacts_per_second` >> ${TMP_FILE1}
echo "Document_hit_rate"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.cache_hit_ratio_avg_10s` >> ${TMP_FILE1}
echo "Bandwidth_savings" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.bandwidth_hit_ratio_avg_10s` >> ${TMP_FILE1}
echo "Cache_percent_free" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.cache.percent_free` >> ${TMP_FILE1}
echo "Open_origin_server_connections" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.current_server_connections` >> ${TMP_FILE1}
echo "Open_client_connections" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.current_client_connections` >> ${TMP_FILE1}
echo "Cache_transfers_in_progress" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.current_cache_connections` >> ${TMP_FILE1}
echo "Client_throughput_Mbits/sec" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.client_throughput_out` >> ${TMP_FILE1}
echo "Transactions_per_second" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.user_agent_xacts_per_second` >> ${TMP_FILE1}
echo "DNS_lookups_per_second" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.dns.lookups_per_second` >> ${TMP_FILE1}
echo "Host_database_hit_rate" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.node.hostdb.hit_ratio_avg_10s` >> ${TMP_FILE1}
echo "Total_document_bytes_from_client" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.http.user_agent_response_document_total_size` >> ${TMP_FILE1}
echo "Total_header_bytes_from_client" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.http.user_agent_response_header_total_size` >> ${TMP_FILE1}
echo "Total_connections_to_client" ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.http.total_client_connections` >> ${TMP_FILE1}
echo "Client_transactions_in_progress"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.http.current_client_transactions` >> ${TMP_FILE1}
echo "Total_document_bytes_from_origin_server"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.http.origin_server_response_document_total_size` >> ${TMP_FILE1}
echo "Total_header_bytes_from_origin_server"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.http.origin_server_response_header_total_size` >> ${TMP_FILE1}
echo "Total_connections_to_origin_server"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.http.total_server_connections` >> ${TMP_FILE1}
echo "Origin_server_transactions_in_progress"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.http.current_server_transactions` >> ${TMP_FILE1}
echo "Bytes_used"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.bytes_used` >> ${TMP_FILE1}
echo "Cache_size"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.bytes_total` >> ${TMP_FILE1}
echo "Lookups_in_progress"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.lookup.active` >> ${TMP_FILE1}
echo "Lookups_completed"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.lookup.success` >> ${TMP_FILE1}
echo "Lookup_misses"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.lookup.failure` >> ${TMP_FILE1}
echo "Reads_in_progress"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.read.active` >> ${TMP_FILE1}
echo "Reads_completed"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.read.success` >> ${TMP_FILE1}
echo "Read_misses"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.read.failure` >> ${TMP_FILE1}
echo "Writes_in_progress"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.write.active` >> ${TMP_FILE1}
echo "Writes_completed"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.write.success` >> ${TMP_FILE1}
echo "Write_failures"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.write.failure` >> ${TMP_FILE1}
echo "Updates_in_progress"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.update.active` >> ${TMP_FILE1}
echo "Updates_completed"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.update.success` >> ${TMP_FILE1}
echo "Update_failures"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.update.failure` >> ${TMP_FILE1}
echo "Removes_in_progress"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.remove.active` >> ${TMP_FILE1}
echo "Remove_successes"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.remove.success` >> ${TMP_FILE1}
echo "Remove_failures"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.cache.remove.failure` >> ${TMP_FILE1}
echo "Total_lookups"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.hostdb.total_lookups` >> ${TMP_FILE1}
echo "Total_hits"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.hostdb.total_hits` >> ${TMP_FILE1}
echo "Time_TTL_min"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.hostdb.ttl` >> ${TMP_FILE1}
echo "DNS_total_lookups"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.dns.total_dns_lookups` >> ${TMP_FILE1}
echo "Average_lookup_time_msec"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.dns.lookup_avg_time` >> ${TMP_FILE1}
echo "DNS_successes"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.dns.lookup_successes` >> ${TMP_FILE1}
echo "Log_files_currently_open"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.log.log_files_open` >> ${TMP_FILE1}
echo "Space_used_for_log_files"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.log.log_files_space_used` >> ${TMP_FILE1}
echo "Number_of_access_events_logged"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.log.event_log_access` >> ${TMP_FILE1}
echo "Number_of_access_events_skipped"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.log.event_log_access_skip` >> ${TMP_FILE1}
echo "Number_of_error_events_logged"  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.log.event_log_error` >> ${TMP_FILE1}
echo "Number_of_congestions_Traffic_Server_has_observed_because_the_maximum_number_of_connections_was_exceeded."  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.congestion.congested_on_max_connection` >> ${TMP_FILE1}
echo "Number_of_congestions_Traffic_Server_has_observed_because_of_an_OS_response_or_timeout_failure."  ${UNIXTIME} `${ATSPATH}/traffic_line -r proxy.process.congestion.congested_on_conn_failures` >> ${TMP_FILE1}

# The hostname given to the top
sed -i -e "s/^/${HOSTNAME}/" ${TMP_FILE1}

# Zabbix_sender
${ZBX_SENDER} -z ${ZBX_SERVER} -p ${ZBX_SERVER_PORT} -T -i ${TMP_FILE1}

# The deleted if file exists.
if [ -e ${TMP_FILE1} ]; then
        /bin/rm ${TMP_FILE1}
fi
