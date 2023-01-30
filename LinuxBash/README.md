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
for Examples: ./script_taskA.sh --all OR ./script_taskA.sh --target"
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
```
#!/bin/bash

logfile=$1;

echo "------ Analys of $logfile was created `date` ------"
echo 1\) Most requests from IP adress:
awk '{print $1}' $logfile | sort | uniq -c | sort -n | tail -n1
echo
echo 2\) Most requested page:
awk '{print $7}' $logfile | sort | uniq -c | sort -n | grep html | tail -n1
echo
echo 3\) Number of requests from each IP adress:
awk '{print $1}' $logfile | sort | uniq -c | sort -nr
echo
echo 4\) Clients referred to non-existent pages:
grep -E 'HTTP/1.[01]" 404' $logfile | awk '{print $7}' | sort | uniq -c | sort -n |grep html
echo
echo 5\) Site get more requests at hour of time:
echo Requests - Hour
awk -F : '{print $2}' $logfile | sed 's/ /:/' | sort | uniq -c | sort -nr | head -5
echo
echo 6\) Search bots have accessed the site:
awk '$7 ~ /robot/' $logfile | cut -d ' ' -f1,12-
```
#### Result of execute with file example_log:
```
------ Analys of example_log.log was created понеділок, 27 січня 2023 01:48:48 +0200 ------
1) Most requests from IP adress:
     29 94.78.95.154

2) Most requested page:
     33 /ukhod-za-soboj/pokhudenie/furosemid-dlya-pokhudeniya.html

3) Number of requests from each IP adress:
     29 94.78.95.154
     21 95.31.14.165
     19 176.108.5.105
     16 31.7.230.210
     14 144.76.76.115
     12 217.69.133.239
     11 66.102.9.35
     11 5.255.251.28
     11 217.69.133.234
     11 188.123.232.29
     10 91.121.209.185
     10 46.158.68.55
      9 93.170.253.156
      9 5.135.154.105
      9 217.69.133.236
      8 91.206.110.87
      8 82.193.140.164
      8 66.102.9.32
      8 217.69.133.235
      8 213.80.162.114
      8 195.24.255.94
      7 66.102.9.38
      7 31.173.84.130
      6 95.65.45.111
      6 66.249.66.204
      6 46.188.127.46
      6 217.69.134.12
      6 217.69.133.70
      6 217.69.133.240
      6 197.231.221.211
      6 195.211.65.102
      6 193.169.81.189
      5 85.26.183.33
      5 82.145.222.114
      5 80.93.117.22
      5 66.249.66.199
      5 46.161.15.91
      5 217.69.134.29
      5 217.69.133.238
      5 194.190.172.103
      5 178.216.120.195
      5 176.59.52.28
      4 85.140.79.235
      4 85.140.3.12
      4 46.211.97.106
      4 46.173.188.61
      4 217.116.232.205
      4 213.87.147.151
      4 212.112.119.234
      4 207.46.13.3
      4 193.201.224.8
      4 193.109.165.82
      3 95.59.16.51
      3 93.90.82.222
      3 92.42.128.111
      3 92.115.237.194
      3 85.26.253.211
      3 85.175.246.117
      3 82.207.56.26
      3 82.113.123.4
      3 81.5.66.178
      3 80.255.89.222
      3 80.234.24.195
      3 66.249.92.197
      3 62.192.231.56
      3 5.197.108.102
      3 5.196.1.129
      3 46.211.64.4
      3 46.211.154.121
      3 46.162.1.107
      3 46.119.8.161
      3 40.77.167.19
      3 37.76.144.10
      3 37.114.132.13
      3 31.52.247.81
      3 31.41.10.55
      3 31.193.90.131
      3 31.130.249.87
      3 2.61.172.119
      3 217.69.133.237
      3 217.66.152.15
      3 213.221.43.38
      3 213.186.8.43
      3 213.134.214.170
      3 212.74.202.86
      3 212.115.253.100
      3 194.50.9.105
      3 193.200.32.117
      3 193.124.179.142
      3 188.18.226.179
      3 185.168.187.11
      3 178.90.59.26
      3 178.34.55.47
      3 178.214.194.138
      3 176.97.103.24
      3 150.129.64.157
      3 146.185.223.129
      3 136.243.95.186
      3 136.243.95.154
      3 117.213.10.129
      3 112.209.25.228
      3 110.36.209.82
      2 95.91.244.229
      2 95.47.14.206
      2 95.215.48.58
      2 95.213.218.57
      2 95.134.32.242
      2 95.108.141.46
      2 95.105.67.60
      2 94.43.218.97
      2 94.253.16.43
      2 94.23.230.134
      2 94.19.255.114
      2 93.81.227.242
      2 93.185.218.39
      2 93.177.36.83
      2 93.171.225.250
      2 92.47.195.10
      2 91.55.0.215
      2 91.234.219.102
      2 91.233.111.96
      2 91.228.153.197
      2 91.223.199.71
      2 91.214.128.157
      2 91.211.205.193
      2 91.208.145.250
      2 91.207.88.218
      2 91.201.180.67
      2 91.200.12.91
      2 91.193.253.201
      2 91.185.224.252
      2 91.129.79.99
      2 89.22.207.152
      2 89.151.191.81
      2 89.145.95.80
      2 89.145.95.69
      2 89.110.58.38
      2 88.81.226.126
      2 88.200.136.82
      2 87.255.2.250
      2 87.236.81.34
      2 87.229.197.62
      2 85.30.209.153
      2 85.26.232.7
      2 85.25.201.182
      2 85.234.190.240
      2 85.140.2.134
      2 85.12.216.247
      2 85.115.248.100
      2 83.220.239.112
      2 83.149.45.161
      2 83.146.115.247
      2 82.145.221.193
      2 82.145.220.53
      2 81.20.197.5
      2 81.177.240.229
      2 80.95.45.192
      2 80.250.69.80
      2 77.51.156.83
      2 77.233.170.66
      2 77.123.47.10
      2 66.249.92.199
      2 62.192.249.56
      2 62.182.200.117
      2 5.196.44.136
      2 5.164.154.6
      2 51.15.40.233
      2 46.56.112.1
      2 46.39.46.14
      2 46.29.15.246
      2 46.251.76.51
      2 46.227.27.101
      2 46.211.145.69
      2 46.211.121.254
      2 46.200.133.201
      2 46.188.120.36
      2 46.146.221.213
      2 37.73.242.48
      2 37.73.200.187
      2 37.55.55.102
      2 37.26.149.157
      2 37.146.123.54
      2 37.112.103.36
      2 31.8.40.150
      2 31.18.250.214
      2 31.173.240.117
      2 31.173.100.229
      2 31.148.24.74
      2 31.132.223.210
      2 2.73.240.41
      2 217.69.134.14
      2 217.69.134.13
      2 217.197.112.84
      2 213.87.248.135
      2 213.87.138.56
      2 213.87.123.2
      2 213.87.121.216
      2 213.24.132.205
      2 213.186.1.210
      2 212.96.66.73
      2 212.30.132.83
      2 212.232.8.174
      2 207.46.13.109
      2 199.16.157.182
      2 195.13.210.83
      2 193.219.127.227
      2 193.106.236.194
      2 188.243.83.21
      2 188.191.23.209
      2 188.186.68.52
      2 188.168.241.47
      2 188.163.77.28
      2 188.162.228.22
      2 188.162.15.132
      2 188.120.50.214
      2 185.86.5.199
      2 185.85.238.244
      2 185.48.113.106
      2 185.26.180.161
      2 185.16.31.70
      2 185.162.9.122
      2 185.154.15.167
      2 185.145.254.110
      2 185.129.62.63
      2 178.92.222.7
      2 178.74.128.205
      2 178.72.161.162
      2 178.215.173.12
      2 178.16.155.158
      2 178.125.102.5
      2 178.123.215.207
      2 178.121.14.104
      2 178.120.82.80
      2 176.8.72.215
      2 176.60.176.90
      2 176.59.68.174
      2 176.59.42.84
      2 176.59.142.226
      2 176.38.93.47
      2 176.241.158.147
      2 176.101.120.30
      2 172.56.42.228
      2 168.235.194.146
      2 148.251.44.219
      2 147.30.136.250
      2 141.101.200.205
      2 134.249.188.31
      2 130.204.56.190
      2 109.87.125.209
      2 109.86.228.248
      2 109.252.15.161
      2 109.206.177.104
      1 95.26.114.109
      1 95.213.218.56
      1 95.154.137.193
      1 94.50.193.4
      1 94.25.180.147
      1 94.23.11.5
      1 94.158.122.120
      1 93.185.192.82
      1 93.171.159.253
      1 92.49.157.244
      1 92.101.227.241
      1 91.215.153.218
      1 91.124.169.37
      1 91.109.19.24
      1 89.35.254.123
      1 89.252.250.10
      1 85.25.246.236
      1 85.140.0.112
      1 84.54.114.235
      1 82.145.222.136
      1 82.145.222.13
      1 82.145.221.243
      1 82.145.210.242
      1 81.200.244.154
      1 80.86.82.84
      1 80.83.224.37
      1 80.64.94.123
      1 79.142.89.90
      1 78.46.24.99
      1 78.37.237.58
      1 77.93.63.171
      1 77.121.203.30
      1 74.125.76.32
      1 66.249.66.194
      1 62.182.200.107
      1 62.102.148.67
      1 5.8.10.202
      1 5.53.113.196
      1 54.153.27.9
      1 52.71.155.178
      1 52.169.188.185
      1 52.169.188.105
      1 5.189.132.99
      1 5.165.7.51
      1 5.141.91.217
      1 46.48.210.106
      1 46.39.53.115
      1 46.37.129.20
      1 46.219.214.201
      1 46.211.127.17
      1 46.211.1.218
      1 46.200.113.37
      1 46.19.85.12
      1 46.161.9.30
      1 46.133.75.81
      1 46.133.135.21
      1 46.118.225.127
      1 46.109.8.44
      1 37.215.139.210
      1 37.214.242.128
      1 37.151.52.46
      1 37.143.110.92
      1 37.110.210.13
      1 31.173.80.101
      1 31.173.120.157
      1 31.173.100.163
      1 2.94.157.199
      1 217.69.134.39
      1 217.69.134.30
      1 217.69.134.15
      1 217.66.152.29
      1 217.182.132.183
      1 217.118.83.192
      1 217.118.79.33
      1 217.116.232.204
      1 213.87.160.85
      1 213.87.147.182
      1 213.87.146.205
      1 213.87.128.54
      1 213.160.137.50
      1 213.160.134.42
      1 213.111.182.222
      1 209.126.120.97
      1 209.126.120.83
      1 207.46.13.128
      1 207.244.96.167
      1 206.16.134.30
      1 206.16.134.21
      1 206.16.134.19
      1 198.148.27.21
      1 198.148.27.20
      1 198.148.27.10
      1 195.64.208.164
      1 195.170.39.107
      1 195.154.151.91
      1 194.186.174.171
      1 193.124.187.198
      1 193.108.39.102
      1 188.170.200.96
      1 188.170.198.147
      1 188.170.196.36
      1 188.168.46.98
      1 188.168.4.2
      1 188.162.195.78
      1 188.130.232.124
      1 185.50.25.13
      1 185.26.183.63
      1 185.162.11.19
      1 178.93.148.21
      1 178.32.224.19
      1 178.212.111.21
      1 178.150.235.54
      1 178.120.147.202
      1 176.8.255.80
      1 176.60.45.34
      1 176.59.48.210
      1 176.59.47.153
      1 176.59.192.252
      1 174.129.126.65
      1 167.114.89.195
      1 164.132.161.85
      1 164.132.161.63
      1 164.132.161.40
      1 162.158.65.58
      1 162.158.65.40
      1 159.224.199.40
      1 149.27.150.151
      1 141.0.15.195
      1 141.0.14.45
      1 141.0.14.22
      1 141.0.12.30
      1 141.0.12.11
      1 139.59.170.166
      1 13.79.162.52
      1 136.243.34.71
      1 117.1.25.120
      1 109.254.49.140
      1 109.252.84.126
      1 109.252.2.191
      1 109.187.141.199
      1 109.126.143.53
      1 107.23.224.100

4) Clients referred to non-existent pages:
      1 /ehsteticheskaya-medicina/injekcii/biorevitalizaciya/preparaty-dlya-biorevitalizacii.html/register.aspx
      1 /google89150ef520da50eb.html
      1 /otzivi-obzori/yuviderm-otzivi-obzori/yuviderm-ne-ochen-dovolna-22-goda.html
      1 /ukhod-za-soboj/pokhudenie/dieti/dieta-grechnevaya-s-kefirom.html%D1%87%D0%B8%D1%82%D0%B0%D0%B9

5) Site get more requests at hour of time:
Requests - Hour
    253 11
    249 12
    210 09
    192 10
     60 13

6) Search bots have accessed the site:
5.255.251.28 "Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)"
89.145.95.69 "Mozilla/5.0 (compatible; GrapeshotCrawler/2.0; +http://www.grapeshot.co.uk/crawler.php)"
217.69.133.70 "Mozilla/5.0 (compatible; Linux x86_64; Mail.RU_Bot/2.0; +http://go.mail.ru/help/robots)"
199.16.157.182 "Twitterbot/1.0"
217.69.133.234 "Mozilla/5.0 (compatible; Linux x86_64; Mail.RU_Bot/2.0; +http://go.mail.ru/help/robots)"
144.76.76.115 "Mozilla/5.0 (compatible; MJ12bot/v1.4.7; http://mj12bot.com/)"
144.76.76.115 "Mozilla/5.0 (compatible; MJ12bot/v1.4.7; http://mj12bot.com/)"
217.69.133.234 "Mozilla/5.0 (compatible; Linux x86_64; Mail.RU_Bot/2.0; +http://go.mail.ru/help/robots)"
```
### TASK C. Create a data backup script that takes the following data as parameters:

1. Path to the syncing directory.
2. The path to the directory where the copies of the files will be stored.
   In case of adding new or deleting old files, the script must add a corresponding entry to the log file indicating the time, type of operation and file name. [The command to run the script must be added to crontab with a run frequency of one minute].

#### Script code:
```
GNU nano 6.2                                               ./script_taskC.sh
#!/bin/bash
logfile='/home/serhii/rsync.log'

# Checking source and target paths as arguments for ./scripth_taskC.sh

if [[ -d $1 ]]; then
    :
    else
        printf "Source directory not set. Please specify directory\n"
        exit 2
fi
if [[ -d $2 ]]; then
    :
    else
        printf "Target directory not set. Please specify target directory\n"
        exit 2
fi

# Executing directory sync and specifying log file including entries indicating the time, type of operation and file name

rsync -avtuh --out-format='%t %o %n' --delete $1 $2  >> $logfile


```

#### Crontab config:
```
  GNU nano 6.2                                          /tmp/crontab.1glPEj/crontab
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command

* * * * * /home/serhii/homework/./script_taskC.sh /home/serhii/homework /home/serhii/Desktop/homework_target
```

#### Result of execute:
```
serhii@Server1:~$ cat /home/serhii/rsync.log
sending incremental file list
2023/01/30 23:11:01 send homework/
2023/01/30 23:11:01 send homework/.script_taskC.sh.swp
2023/01/30 23:11:01 send homework/apache_logs.txt
2023/01/30 23:11:01 send homework/example_log.log
2023/01/30 23:11:01 send homework/example_log.log_output
2023/01/30 23:11:01 send homework/output
2023/01/30 23:11:01 send homework/script_taskA.sh
2023/01/30 23:11:01 send homework/script_taskA.sh.save
2023/01/30 23:11:01 send homework/script_taskB.sh
2023/01/30 23:11:01 send homework/script_taskC.sh
2023/01/30 23:11:01 send homework/task2.sh
2023/01/30 23:11:01 send homework/v2_script_taskB.sh
2023/01/30 23:11:01 send homework/v3_script_taskB.sh
2023/01/30 23:11:01 send homework/v4_script_taskB.sh
2023/01/30 23:11:01 send homework/v5_script_taskB.sh

sent 432.63K bytes  received 286 bytes  865.84K bytes/sec
total size is 431.40K  speedup is 1.00
sending incremental file list

sent 537 bytes  received 17 bytes  1.11K bytes/sec
total size is 431.40K  speedup is 778.71
sending incremental file list
2023/01/30 23:13:01 del. homework/script_taskA.sh.save
2023/01/30 23:13:01 del. homework/.script_taskC.sh.swp
2023/01/30 23:13:01 send homework/

sent 470 bytes  received 86 bytes  1.11K bytes/sec
total size is 429.83K  speedup is 773.08
sending incremental file list

sent 467 bytes  received 17 bytes  968.00 bytes/sec
total size is 429.83K  speedup is 888.09
serhii@Server1:~$
```