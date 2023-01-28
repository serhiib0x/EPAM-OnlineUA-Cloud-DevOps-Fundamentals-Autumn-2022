## Linux administration with bash. Home task.

### TASK A. Create a script that uses the following keys:

1. When starting without parameters, it will display a list of possible keys and their description.
2. The --all key displays the IP addresses and symbolic names of all hosts in the current subnet
3. The --target key displays a list of open system TCP ports.
   The code that performs the functionality of each of the subtasks must be placed in a separate function.

#### Script code:
```
#!/bin/bash
#----- Detect ip adress and subnet -----
ip_addr=`ip -o -f inet addr show | awk '/scope global/ {print $4}'`
ip_brd=`ip -o -f inet addr show | awk '/scope global/ {print $6}'`
ip_subnet=${ip_brd::-3}*

#----- Function Subnet Scanning -----
function netscan {
echo "You external IP adress:"$ip_addr
echo "Scanning subnet:"$ip_subnet
nmap -sn $ip_subnet
}

#----- Function Port Scanning -----
function portscan {
nmap ${ip_addr::-3}
}

#----- Main program -----
#echo "You external IP adress:"$ip_addr
if [[ $1 == "--all" ]]
then
netscan
elif [[ $1 == "--target" ]]
then
portscan
else
echo "You must specify the key:
key --all displays the IP addresses and symbolic names of all hosts in the current subnet
key --target displays a list of open system TCP ports
for Examples: ./script_taskA.sh --all OR ./scripth_taskA.sh --target"
fi
```

#### Result of execute:
```
serhii@Server1:~/homework$ ./script_taskA.sh --all
You external IP adress:192.168.12.224/24
Scanning subnet:192.168.12.*
Starting Nmap 7.93 ( https://nmap.org ) at 2023-01-29 00:23 EET
Nmap scan report for 192.168.12.121
Host is up (0.019s latency).
Nmap scan report for _gateway (192.168.12.191)
Host is up (0.0059s latency).
Nmap scan report for Server1 (192.168.12.224)
Host is up (0.0046s latency).
Nmap done: 256 IP addresses (3 hosts up) scanned in 46.38 seconds

serhii@Server1:~/homework$ ./script_taskA.sh --target
Starting Nmap 7.93 ( https://nmap.org ) at 2023-01-29 00:33 EET
Nmap scan report for Server1 (192.168.12.224)
Host is up (0.00019s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT   STATE SERVICE
22/tcp open  ssh

Nmap done: 1 IP address (1 host up) scanned in 0.45 seconds
```

### TASK B. Using Apache log example create a script to answer the following questions:

1. From which ip were the most requests?
2. What is the most requested page?
3. How many requests were there from each ip?
4. What non-existent pages were clients referred to?
5. What time did site get the most requests?
6. What search bots have accessed the site? (UA + IP).

#### Script code:

#### Result of execute with file apache_logs:

#### Result of execute with file example_log:

### TASK C. Create a data backup script that takes the following data as parameters:

1. Path to the syncing directory.
2. The path to the directory where the copies of the files will be stored.
   In case of adding new or deleting old files, the script must add a corresponding entry to the log file indicating the time, type of operation and file name. [The command to run the script must be added to crontab with a run frequency of one minute].

#### Script code:

#### Result of execute:
