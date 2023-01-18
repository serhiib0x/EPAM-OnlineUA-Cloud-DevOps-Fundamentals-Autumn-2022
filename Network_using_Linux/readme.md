# TASK 3. Networks using Linux**

In this task, the network plan depicted in the figure was implemented:

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/66a8acadb732fd93398e4dc31c721ddca5781c6b/Network_using_Linux/Screenshots/001_Networking_plan.jpg)

**Step 1. Network Settings on Server1.**

-
##### - Server1's network was configured via the netplan /etc/netplan/\*.yaml file:
```
1. \# Let NetworkManager manage all devices on this system  - Server1. Task Network using Linux.
2. network:
3.   version: 2
4.   renderer: NetworkManagerd
5.   ethernets:
6.     enp0s3:
7.       dhcp4: false
8.       dhcp6: false
9.       addresses: [192.168.1.200/24]
10.       nameservers:
11.        addresses: [8.8.8.8, 8.8.4.4]
12.       routes:
13.        - to: 0.0.0.0/0
14.          via: 192.168.1.1
15.     enp0s8:
16.       dhcp4: false
17.       dhcp6: false
18.       addresses: [10.75.7.1/24]
19.       nameservers:
20.        addresses: [8.8.8.8, 8.8.4.4]
21.     enp0s9:
22.       dhcp4: false
23.       dhcp6: false
24.       addresses: [10.10.75.1/24]
25.       nameservers:
26.        addresses: [8.8.8.8, 8.8.4.4]
```
To apply settings from config file used commands:
```
$ sudo netplan generate
$ sudo netplan try
$ sudo netplan apply
```
**Step 2. Configure DHCP service on Server\_1 to configure Int1 addresses Client\_1 and Client\_2.**

To configure the DHCP service, two range subnets for Net2, Net3 have been added to the /etc/dhcp/dhcpd.conf file as shown in the figure − 
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image002.png)

Also edited the file /etc/default/isc-dhcp-server which defines interfaces Int2 / Int3 "enp0s8 enp0s9" to listen on DHCP clients from Net2/Net3.

The DHCP service was restarted by the command to apply the settings –
```
$ sudo systemctl restart isc-dhcp-server.service
```
After that, the network interfaces were set to dhcp mode - both on client 1 and client 2.The result of the settings is shown in the picture - clients received IP addresses. ![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image003.png)

At the end of this stage, Net4 was configured between clients 1 and 2. A static address was added to Client\_1 via netplanfile –

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image004.png)

And because Client\_2 works under CentOS, a static address was written to the Int2 file – _**/etc/sysconfig/network-scripts/ifcfg-enp0s8**_.

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image005.png)

**Step**  **3.**  **Check network connections between VMs through ping and traceroute commands.**

To enable routing between interfaces on the Server\_1, edited  **_/etc/sysctl.conf_**  file, command used to check –
```
serhii@Server1:~$ sysctl net.ipv4.conf.all.forwarding
net.ipv4.conf.all.forwarding = 1
```
For Internet access of Client\_1 / Client\_2, static routes on the home router to Server\_1 have been added - 
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image006.png)

After all the settings, the check is done.

Client1 ping check was performed –

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image007.png)

Client1 traceroute check was performed –

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image008.png)

Client2 ping check was performed –

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image009.png)

Client2 traceroute check was performed –

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image010.png)

**Description of results**

1. There were two routes between Client1 and Client2 with different delay and number of hops. The first route that went through Net2\Server1\Net3 has two hops, so the parameter is reduced to TTL=63. Also, Server1, as shown, added additional delay to ping this route.

2. The second route through Net4 has lower latency because the Ethernet adapters connect directly to each other.

**Step 4.1 On the virtual interface lo Client\_1, assign two IP addresses as follows by rule: 172.17.17.1/24 and 172.17.27.1/24.**

Assigned two permanent IP addresses (172.17.17.1 / 172.17.27.1) on the loopback interface for Client\_1 by adding lines to the YAML configuration file:
```
lo:
addresses: [172.17.17.1/32, 172.17.27.1/32]
```
**Step 4.2 Configure routing so that traffic from Client\_2 to 172.17.17.1 passes through Server\_1, and to 172.17.27.1 via Net4.**

To configure according to the task on Client\_2, added the first route via Net2 to Server\_1 and the second route via Net4 to Client\_1 –
```
sudo ip route add 172.17.17.0/24 via 10.10.75.11
sudo ip route add 172.17.27.0/24 via 172.16.7.2
```
To adjust according to the task on Server\_1, the extension of the route to Client\_1 is added -
```
sudo ip route add 172.17.17.0/24 via 10.75.7.1
```
Used to check traceroute -

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image011.png)

**Step 5. Calculate the common address and mask (summarizing) addresses 172.17.17.1 and 172.17.27.1, and the prefix should be as large as possible. Remove routes set in the previous step and replace them with the merged one route that should pass through Server\_1.**

Online ip calculator used to calculate the mask for summarizing network.

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image012.png)

To configure it was added the route on Client\_2 to Server\_1-
```
sudo ip route add 172.17.0.0/19 via 10.10.75.11
```
And also it was added on Server\_1 route to Client\_1–
```
sudo ip route add 172.17.0.0/19 via 10.75.7.1
```
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image013.png)

Used to check traceroute -

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image014.png)

**Step 6. Configure the SSH service so that Client\_1 and Client\_2 can connect to Server\_1 and each other.**

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image015.png)

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image016.png)

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image017.png)

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image018.png)

**Step 7. Configure the firewall on Server\_1 as follows:**

**Step 7.1 Allowed to connect via SSH from Client\_1 and forbidden from Client\_2**

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image019.png)

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image020.png)

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image021.png)

**Step 7.2 From Client\_2 to 172.17.17.1 the ping was successful, but to 172.17.27.1 it was not successful****.**

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image022.png)

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image023.png)

**Step 8. If in step 3 routing was configured for Client\_1 and Client\_2 to access**

**Internet networks – delete relevant records. Configure NAT on Server\_1**

**service in such a way that Client\_1 and Client\_2 ping the Internet.**

sudo iptables -t nat -A POSTROUTING -j MASQUERADE

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image024.png)

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/main/Network_using_Linux/Screenshots/image025.png)

![](RackMultipart20230117-1-q0u80v_html_651e47c3dfe2476c.png)