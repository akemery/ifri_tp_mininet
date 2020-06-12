from ipmininet.iptopo import IPTopo
from ipmininet.ipnet import IPNet
from ipmininet.cli import IPCLI
from ipmininet.router.config import SSHd

class MyTopology(IPTopo):
	def build(self, *args, **kwargs):
		r1 = self.addRouter("r1")
		s1 = self.addSwitch("s1")
		s2 = self.addSwitch("s2")
		c = self.addHost("c")
		s = self.addHost("s")
		self.addLink(s1, r1, delay='20ms')
		self.addLink(s2, r1, delay='20ms')
		self.addLink(c, s1, delay='20ms')
		self.addLink(s, s2, delay='20ms')
		self.addLink(s, s2, delay='20ms')
		s.addDaemon(SSHd)
		c.addDaemon(SSHd)
		super().build(*args, **kwargs)
net = IPNet(topo=MyTopology())
try:
    	net.start()
    	IPCLI(net)
finally:
    	net.stop()
