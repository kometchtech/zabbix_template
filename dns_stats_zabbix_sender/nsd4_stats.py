#!/usr/bin/python
# coding: utf-8

import time
import subprocess
import socket
import os
import shlex
import tempfile
import sys

if __name__ == "__main__":

	unixtime = time.time()
	prog_stat = "/usr/local/sbin/nsd-control stats"
	sender = "/usr/local/bin/zabbix_sender"
	argvs = sys.argv
	if ( len(argvs) !=2 ):
		print "Usage: %s [Zabbix server IP]" % argvs[0]
		quit()


	hostname = socket.getfqdn()
	ofile = tempfile.mkstemp()
	result = subprocess.check_output(shlex.split(prog_stat)).split('\n')
	with open(ofile[1], 'w') as fobj:
	    for i in range(0, len(result)-1):
		    stats_name, stats_value = result[i].split("=")
		    args = '{0} {1} {2} {3}\n'.format(hostname,
		                                      stats_name,
		                                      str(unixtime),
		                                      stats_value)
		    fobj.write(args)

	cmd = '{0} -z {1} -T -i {2}'.format(sender, argvs[1], ofile[1])
	subprocess.call(shlex.split(cmd))
	os.remove(ofile[1])
