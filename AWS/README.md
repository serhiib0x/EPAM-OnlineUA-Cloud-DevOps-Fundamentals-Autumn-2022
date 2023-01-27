# Homework Virtualization and Cloud Basic (AWS)

## Step 1. Read the terms of Using the AWS Free Tier and the ability to control their own costs.
## Step 2. Register with AWS (first priority) or alternatively, you can request access to courses in AWS Academy if you are currently a student of certain University.

## Step 3. Find the hands-on tutorials and AWS Well-Architected Labs for your AWS needs. Explore list of step-by-step tutorials for deferent category. Use, repeat as many as you can and have fun))

## Step 4. Register and pass courses on AWS Educate. Filter by checking Topic Cloud Computing and Foundational Level. Feel free to pass more.

## Step 5. Register and pass free courses on AWS Skillbuilder. AWS Cloud Practitioner Essentials: Core Services, AWS Cloud Practitioner Essentials: Cloud Concepts. Try AWS Cloud Quest: Cloud Practitioner.
 

This badge was issued to Sergiy Razlom on January 02, 2023
Verify my badge link - 

https://www.credly.com/badges/c65b3631-3eae-4bc1-9672-1352c05a3ba7

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image01.png)
## Step 6. Pass free courses on Amazon qwiklabs

## Step 7. Review Getting Started with Amazon EC2. Log Into Your AWS Account, Launch, Configure, Connect and Terminate Your Instance. Do not use Amazon Lightsail. It is recommended to use the t2 or t3.micro instance and the CentOS operating system.
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image02.png)
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image03.png)
 
## Step 8. Create a snapshot of your instance to keep as a backup.
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image04.png)
 
## Step 9. Create and attach a Disk_D (EBS) to your instance to add more storage space. Create and save some file on Disk_D.
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image05.png)
```
Last login: Thu Jan 26 09:58:32 2023 from 194.44.201.146
[centos@ip-172-31-0-38 ~]$ lsblk
NAME        MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
nvme1n1     259:0    0   1G  0 disk
nvme0n1     259:1    0   8G  0 disk
└─nvme0n1p1 259:2    0   8G  0 part /
[centos@ip-172-31-0-38 ~]$ sudo mount /dev/nvme1n1
mount: /dev/nvme1n1: can't find in /etc/fstab.
[centos@ip-172-31-0-38 ~]$ sudo fdisk /dev/nvme1n1

Welcome to fdisk (util-linux 2.32.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x52328c71.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1):
First sector (2048-2097151, default 2048):
Last sector, +sectors or +size{K,M,G,T,P} (2048-2097151, default 2097151):

Created a new partition 1 of type 'Linux' and of size 1023 MiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
[centos@ip-172-31-0-38 ~]$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
nvme1n1     259:0    0    1G  0 disk
└─nvme1n1p1 259:4    0 1023M  0 part
nvme0n1     259:1    0    8G  0 disk
└─nvme0n1p1 259:2    0    8G  0 part /
[centos@ip-172-31-0-38 ~]$ sudo cat /proc/partitions
major minor  #blocks  name

 259        0    1048576 nvme1n1
 259        4    1047552 nvme1n1p1
 259        1    8388608 nvme0n1
 259        2    8386560 nvme0n1p1
[centos@ip-172-31-0-38 ~]$ sudo partprobe /dev/nvme1n1
[centos@ip-172-31-0-38 ~]$ sudo mkfs.xfs -f /dev/nvme1n1
meta-data=/dev/nvme1n1           isize=512    agcount=8, agsize=32768 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0 inobtcount=0
data     =                       bsize=4096   blocks=262144, imaxpct=25
         =                       sunit=1      swidth=1 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[centos@ip-172-31-0-38 ~]$ sudo mkdir home/centos/homework
[centos@ip-172-31-0-38 ~]$ sudo blkid /dev/nvme1n1
/dev/nvme1n1: UUID="d8190e6f-89a3-45ec-89a6-5e2a9e23f85e" BLOCK_SIZE="512" TYPE="xfs"


[centos@ip-172-31-0-38 ~]$ lsblk
NAME        MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
nvme1n1     259:0    0   1G  0 disk /home/centos/homework
nvme0n1     259:1    0   8G  0 disk
└─nvme0n1p1 259:2    0   8G  0 part /


[centos@ip-172-31-0-38 ~]$ ls -al /home/centos/homework/
total 4
drwxr-xr-x. 2 root   root    29 Jan 26 11:13 .
drwx------. 7 centos centos 179 Jan 26 11:11 ..
-rw-rw-rw-. 1 root   root    26 Jan 26 11:29 second_file.txt
[centos@ip-172-31-0-38 ~]$ cat ~/homework/second_file.txt
Some data into secondfile
[centos@ip-172-31-0-38 ~]$
```

## Step 10. Launch the second instance from backup.

Created image (AMI) from snapshot -
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image06.png)
 	Launched second instance from AMI –
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image07.png)
## Step 11. Detach Disk_D from the 1st instance and attach disk_D to the new instance.
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image08.png)
 
```
Authenticating with public key "Imported-Openssh-Key"
    ┌──────────────────────────────────────────────────────────────────────┐
    │                 • MobaXterm Personal Edition v22.1 •                 │
    │               (SSH client, X server and network tools)               │
    │                                                                      │
    │ ⮞ SSH session to centos@ec2-3-75-242-224.eu-central-1.compute.amazonaws.com          │
    │   • Direct SSH      :  ✓                                             │
    │   • SSH compression :  ✓                                             │
    │   • SSH-browser     :  ✓                                             │
    │   • X11-forwarding  :  ✗  (disabled or not supported by server)      │
    │                                                                      │
    │ ⮞ For more info, ctrl+click on help or visit our website.            │
    └──────────────────────────────────────────────────────────────────────┘

Last login: Thu Jan 26 15:09:21 2023 from 31.144.101.21
[centos@ip-172-31-14-221 ~]$
[centos@ip-172-31-14-221 ~]$ lsblk
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0   8G  0 disk
└─xvda1 202:1    0   8G  0 part /
xvdf    202:80   0   1G  0 disk
[centos@ip-172-31-14-221 ~]$
[centos@ip-172-31-14-221 ~]$ sudo mount /dev/xvdf /mnt
[centos@ip-172-31-14-221 ~]$ ls
my_first_file.txt
[centos@ip-172-31-14-221 ~]$ cat my_first_file.txt
This is my first file in AWS
[centos@ip-172-31-14-221 ~]$
```

## Step 12. Review the 10-minute example. Explore the possibilities of creating your own domain and domain name for your site. Note, that Route 53 not free service. Alternatively you can free register the domain name *.PP.UA and use it.

It was created domain -  razlom.pp.ua

## Step 13. Launch and configure a WordPress instance with Amazon Lightsail link

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image09.png)
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image10.png)
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image11.png)
## Step 14. Review the 10-minute Store and Retrieve a File. Repeat, creating your own repository.
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image12.png)
 
## Step 15. Review the 10-minute example Batch upload files to the cloud to Amazon S3 using the AWS CLI. Create a user AWS IAM, configure CLI AWS and upload any files to S3.
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image13.png)

## Step 16. Review the 10-minute example Deploy Docker Containers on Amazon Elastic Container Service (Amazon ECS). Repeat, create a cluster, and run the online demo application or better other application with custom settings.
#### Using the console Linux containers on AWS Fargate
#### Step 1. Create the cluster ECS.
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image14.png)
#### Step 2.Create new Task Definition, Create new revision with JSON.

```
{
    "family": "sample-fargate", 
    "networkMode": "awsvpc", 
    "containerDefinitions": [
        {
            "name": "fargate-app", 
            "image": "public.ecr.aws/docker/library/httpd:latest", 
            "portMappings": [
                {
                    "containerPort": 80, 
                    "hostPort": 80, 
                    "protocol": "tcp"
                }
            ], 
            "essential": true, 
            "entryPoint": [
                "sh",
		"-c"
            ], 
            "command": [
                "/bin/sh -c \"echo '<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>Congratulations!</h2> <p>Your application is now running on a container in Amazon ECS.</p> </div></body></html>' >  /usr/local/apache2/htdocs/index.html && httpd-foreground\""
            ]
        }
    ], 
    "requiresCompatibilities": [
        "FARGATE"
    ], 
    "cpu": "256", 
    "memory": "512"
}
```
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image15.png)
 
#### Step 3: Create the service
Configure SecurityGroup with access to TCP/port80.

#### Step 4: View your service result through public address IP. 
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image16.png)
#### Step5: You must first to stop running service before you can delete the cluster ECS. 

## Step:17. Run a Serverless "Hello, World!" with AWS Lambda.

I setup a my lambda function according tutorial -
https://aws.amazon.com/ru/getting-started/hands-on/run-serverless-code/
![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/5821e7ca4c00cd62a26b7c9349cb0a0e66604110/AWS/Images/image17.png)

## Step:18. Create a static website on Amazon S3, publicly available (link1 or link2 - using a custom domain registered with Route 53). Post on the page your own photo, the name of the educational program (EPAM Cloud&DevOps Fundamentals Autumn 2022), the list of AWS services with which the student worked within the educational program or earlier and the full list with links of completed labs (based on tutorials or qwiklabs). Provide the link to the website in your report and СV.
 
http://razlom.pp.ua
