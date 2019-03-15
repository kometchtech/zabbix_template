#!/usr/bin/python
# coding: utf-8

import time
import subprocess
import socket
import os
import shlex
import tempfile

if __name__ == "__main__":

	unixtime = time.time()
	prog_stat = "/usr/local/sbin/unbound-control stats"
	sender = "/usr/local/bin/zabbix_sender"
	server = "10.0.0.1"
	hostname = socket.getfqdn()


	ofile = tempfile.mkstemp()
	result = subprocess.check_output(shlex.split(prog_stat)).split('\n')
	with open(ofile, 'w') as fobj:
	    for i in range(0, len(result)-1):
		    stats_name, stats_value = result[i].split("=")
		    args = '{0} {1} {2} {3}\n'.format(hostname,
		                                      stats_name,
		                                      str(unixtime),
		                                      stats_value)
		    fobj.write(args)

	cmd = '{0} -z {1} -T -i {2}'.format(sender, server, ofile)
	subprocess.call(shlex.split(cmd))
	os.remove(ofile)
