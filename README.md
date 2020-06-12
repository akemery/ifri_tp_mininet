### Description
Uses tcpkill to end tcp session between two hosts

### prerequistes
#### Install tcpkill

$ sudo apt install dsniff

#### Install ipmininet or mininet

Follow the following guide to install IPmininet https://ipmininet.readthedocs.io/en/latest/install.html#manual-installation

or you can follow the following guide to install mininet http://mininet.org/download/

### topo.py 
This file contains the description of a mininet network.
c ----- r1 ----- s
#### start mininet network

$ sudo python3 topo.py

### kill_tcp_session.sh 
Can be executed either on host (c), host (s), or host (r1). You have to provide the IP address of one endpoint of  the TCP session, 
then the duration while tcpkill will run, and finally how many time you want tcpkill to be excecuted.

$ bash kill_tcp_session.sh  -a <ip_address> -d <duration in s> -n <#times>
