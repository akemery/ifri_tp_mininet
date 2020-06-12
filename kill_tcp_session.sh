#!/bin/bash

invalid_ip() {
	local IFS=.; local -a a=($1)
	[[ $1 =~ ^[0-9]+(\.[0-9]+){3}$ ]] || return 0
	local quad
	for quad in {0..3}; do
		[[ "${a[$quad]}" -gt 255 ]] && return 0
	done
	return 1
}

kill_tcp_session(){
	tcpkill -9 host $1 2>/dev/null &
	sleep $2
	for child in $(jobs -p); do
    		kill "$child"
	done
	wait $(jobs -p)
}

usage(){
	echo $1 "-a address -d duration -n #times"
}

while getopts ":a:d:n:" opt; do
  	case ${opt} in
		a )
			ip=$OPTARG
      			;;
    		d )
      			duration=$OPTARG
      			;;
    		n )
      			n=$OPTARG
      			;;
    		\? )
      			usage $0
			exit 1 
      			;;
    		: )
      			usage $0
			exit 1
      			;;
 		 esac
	done
shift $((OPTIND -1))


if invalid_ip $ip ; then
	echo "invalid ($ip)"
	exit 1
fi
for ((i=1;i<$n;i++))
do
	kill_tcp_session $ip $duration
done
