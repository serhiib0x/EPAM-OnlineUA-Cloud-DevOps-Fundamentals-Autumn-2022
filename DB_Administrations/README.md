**TASK DB1**

**PART 1**

**Step 1. Download MySQL server for your OS** **on VM.**

For install the mysql on a Debian Linux distributives should use command:

```

sudo apt-get install mysql-server

```

**Step 2. Install MySQL server on VM.**

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/636d324036e03a5ed0148cad589e834d5cfb7f68/DB_Administrations/Images/image001.png)

After installation process useful information about mysql service –

```

update-alternatives: using /var/lib/mecab/dic/ipadic-utf8 to provide /var/lib/mecab/dic/debian (mecab-dictionary) in auto mode

Setting up mysql-server-8.0 (8.0.31-0ubuntu0.22.04.1) ...

update-alternatives: using /etc/mysql/mysql.cnf to provide /etc/mysql/my.cnf (my.cnf) in auto mode

Renaming removed key\_buffer and myisam-recover options (if present)

mysqld will log errors to /var/log/mysql/error.log

mysqld is running as pid 12809

Created symlink /etc/systemd/system/multi-user.target.wants/mysql.service → /lib/systemd/system/mysql.service.

```

**Step 3. Select a subject area and describe the database schema, (minimum 3 tables)**

Choose theme "CARS". Three tables of cars, citizen, location of registration.

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/636d324036e03a5ed0148cad589e834d5cfb7f68/DB_Administrations/Images/image002.png)

**Step 4. Create a database on the server through the console.**

```

CREATE TABLE citizen (

id INT NOT NULL PRIMARY KEY AUTO\_INCREMENT,

passport\_id CHAR(8) NOT NULL UNIQUE,

surname CHAR(100) NOT NULL,

name CHAR(100) NOT NULL

);

CREATE TABLE registration (

id INT NOT NULL PRIMARY KEY AUTO\_INCREMENT,

gov\_number CHAR(8) NOT NULL UNIQUE,

country CHAR(255) NOT NULL,

city CHAR(255) NOT NULL

);

CREATE TABLE cars\_table (

id INT NOT NULL PRIMARY KEY AUTO\_INCREMENT,

vin VARCHAR(25) NOT NULL UNIQUE,

vendor CHAR(50) NOT NULL,

model CHAR(50) NOT NULL,

passport\_id CHAR(8),

gov\_number CHAR(8) UNIQUE,

FOREIGN KEY (passport\_id) REFERENCES citizen(passport\_id),

FOREIGN KEY (gov\_number) REFERENCES registration(gov\_number)

);

mysql\> show tables;

+----------------+

| Tables\_in\_CARS |

+----------------+

| cars\_table |

| citizen |

| registration |

+----------------+

3 rows in set (0,00 sec)

```

**Step 5. Fill in tables.**

```

INSERT INTO citizen (passport\_id,name,surname)

VALUES

("MA111111","Ivan","Schvydkiy"),

("MB222222","Taras","Rozumny"),

("MC333333","Bogdan","Khmelnyk"),

("MD444444","Ivan","Franko");

INSERT INTO registration (gov\_number,country,city) VALUES("CH0001HC","Ukraine","Cherkasy");

INSERT INTO registration (gov\_number,country,city) VALUES("KA0001AK","Ukraine","Kyiv");

INSERT INTO registration (gov\_number,country,city) VALUES("LV0001VL","Ukraine","Lviv");

INSERT INTO registration (gov\_number,country,city) VALUES("AX0001XA","Ukraine","Kharkiv");

INSERT INTO registration (gov\_number,country,city) VALUES("AX0002XA","Ukraine","Kharkiv");

INSERT INTO cars\_table (vin,vendor,model,passport\_id,gov\_number)

VALUES

("vinnumber1","Nissan","Note","MA111111","CH0001HC"),

("vinnumber2","Nissan","Almera","MB222222","KA0001AK"),

("vinnumber3","Nissan","Patrol","MC333333","LV0001VL"),

("vinnumber4","VW","Golf","MD444444","AX0001XA"),

("vinnumber5","Toyota","Corolla","MD444444","AX0002XA"

);

```

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/636d324036e03a5ed0148cad589e834d5cfb7f68/DB_Administrations/Images/image003.png)

**Step 6. Construct and execute SELECT operator with WHERE, GROUP BY and ORDER BY.**

```

mysql\> SELECT \* FROM cars\_table JOIN citizen ON cars\_table.passport\_id = citizen.passport\_id WHERE cars\_table.vendor = 'Nissan';

+----+------------+--------+--------+-------------+------------+----+-------------+-----------+--------+

| id | vin | vendor | model | passport\_id | gov\_number | id | passport\_id | surname | name |

+----+------------+--------+--------+-------------+------------+----+-------------+-----------+--------+

| 1 | vinnumber1 | Nissan | Note | MA111111 | CH0001HC | 1 | MA111111 | Schvydkiy | Ivan |

| 2 | vinnumber2 | Nissan | Almera | MB222222 | KA0001AK | 2 | MB222222 | Rozumny | Taras |

| 3 | vinnumber3 | Nissan | Patrol | MC333333 | LV0001VL | 3 | MC333333 | Khmelnyk | Bogdan |

+----+------------+--------+--------+-------------+------------+----+-------------+-----------+--------+

3 rows in set (0,01 sec)

mysql\> SELECT cars\_table.vin AS 'CAR VIN', cars\_table.gov\_number AS 'Car Plate Number', citizen.surname AS 'Owner Surname', citizen.name AS 'Owner Name', registration.city AS 'City\_registration' FROM cars\_table JOIN citizen ON cars\_table.passport\_id = citizen.passport\_id JOIN registration ON cars\_table.gov\_number=registration.gov\_number GROUP BY cars\_table.gov\_number ;

+------------+------------------+---------------+------------+-------------------+

| CAR VIN | Car Plate Number | Owner Surname | Owner Name | City\_registration |

+------------+------------------+---------------+------------+-------------------+

| vinnumber1 | CH0001HC | Schvydkiy | Ivan | Cherkasy |

| vinnumber2 | KA0001AK | Rozumny | Taras | Kyiv |

| vinnumber3 | LV0001VL | Khmelnyk | Bogdan | Lviv |

| vinnumber4 | AX0001XA | Franko | Ivan | Kharkiv |

| vinnumber5 | AX0002XA | Franko | Ivan | Kharkiv |

+------------+------------------+---------------+------------+-------------------+

5 rows in set (0,00 sec)

mysql\> SELECT cars\_table.vin AS 'CAR VIN', cars\_table.gov\_number AS 'Car Plate Number', citizen.surname AS 'Owner Surname', citizen.name AS 'Owner Name', registration.city AS 'City\_registration' FROM cars\_table JOIN citizen ON cars\_table.passport\_id = citizen.passport\_id JOIN registration ON cars\_table.gov\_number=registration.gov\_number ORDER BY registration.city ;

+------------+------------------+---------------+------------+-------------------+

| CAR VIN | Car Plate Number | Owner Surname | Owner Name | City\_registration |

+------------+------------------+---------------+------------+-------------------+

| vinnumber1 | CH0001HC | Schvydkiy | Ivan | Cherkasy |

| vinnumber4 | AX0001XA | Franko | Ivan | Kharkiv |

| vinnumber5 | AX0002XA | Franko | Ivan | Kharkiv |

| vinnumber2 | KA0001AK | Rozumny | Taras | Kyiv |

| vinnumber3 | LV0001VL | Khmelnyk | Bogdan | Lviv |

+------------+------------------+---------------+------------+-------------------+

5 rows in set (0,00 sec)

```

**Step 7. Execute other different SQL queries DDL, DML, DCL.**

**Following are the five DDL commands in SQL:**

- **CREATE Command.**
- **DROP Command.**
- **ALTER Command.**
- **TRUNCATE Command.**
- **RENAME Command.**

```

mysql\> CREATE DATABASE BOOKS;

Query OK, 1 row affected (0,02 sec)

mysql\> show databases;

+--------------------+

| Database |

+--------------------+

| BOOKS |

| CARS |

| RESTAURANT |

| TOWNS |

| information\_schema |

| mysql |

| performance\_schema |

| sys |

+--------------------+

8 rows in set (0,00 sec)

mysql\> DROP DATABASE BOOKS;

Query OK, 0 rows affected (0,02 sec)

mysql\> ALTER TABLE cars\_table ADD COLUMN color VARCHAR (30) NULL AFTER model;

Query OK, 0 rows affected (0,13 sec)

Records: 0 Duplicates: 0 Warnings: 0

mysql\> select \* from cars\_table;

+----+------------+--------+---------+-------+-------------+------------+

| id | vin | vendor | model | color | passport\_id | gov\_number |

+----+------------+--------+---------+-------+-------------+------------+

| 1 | vinnumber1 | Nissan | Note | NULL | MA111111 | CH0001HC |

| 2 | vinnumber2 | Nissan | Almera | NULL | MB222222 | KA0001AK |

| 3 | vinnumber3 | Nissan | Patrol | NULL | MC333333 | LV0001VL |

| 4 | vinnumber4 | VW | Golf | NULL | MD444444 | AX0001XA |

| 5 | vinnumber5 | Toyota | Corolla | NULL | MD444444 | AX0002XA |

+----+------------+--------+---------+-------+-------------+------------+

5 rows in set (0,00 sec)

mysql\> ALTER TABLE cars\_table DEL COLUMN color;

Query OK, 0 rows affected (0,17 sec)

Records: 0 Duplicates: 0 Warnings: 0

mysql\> ALTER TABLE cars\_table RENAME COLUMN model TO marka;

Query OK, 0 rows affected (0,07 sec)

Records: 0 Duplicates: 0 Warnings: 0

mysql\> SELECT \* from cars\_table;

+----+------------+--------+---------+-------------+------------+

| id | vin | vendor | marka | passport\_id | gov\_number |

+----+------------+--------+---------+-------------+------------+

| 1 | vinnumber1 | Nissan | Note | MA111111 | CH0001HC |

| 2 | vinnumber2 | Nissan | Almera | MB222222 | KA0001AK |

| 3 | vinnumber3 | Nissan | Patrol | MC333333 | LV0001VL |

| 4 | vinnumber4 | VW | Golf | MD444444 | AX0001XA |

| 5 | vinnumber5 | Toyota | Corolla | MD444444 | AX0002XA |

+----+------------+--------+---------+-------------+------------+

5 rows in set (0,00 sec)

```

**Following are the four main DML commands in SQL:**

- **SELECT Command.**
- **INSERT Command.**
- **UPDATE Command.**
- **DELETE Command.**

```

mysql\> SELECT cars_table.vin, cars_table.vendor FROM cars_table WHERE cars_table.vendor = 'Nissan';

+------------+--------+

| vin | vendor |

+------------+--------+

| vinnumber1 | Nissan |

| vinnumber2 | Nissan |

| vinnumber3 | Nissan |

+------------+--------+

3 rows in set (0,01 sec)

mysql\> UPDATE cars_table SET vin = 'vinnumber01' WHERE cars_table.id = 1;

Query OK, 1 row affected (0,04 sec)

Rows matched: 1 Changed: 1 Warnings: 0

mysql\> SELECT cars_table.vin, cars_table.vendor FROM cars_table WHERE cars_table.vendor = 'Nissan';

+-------------+--------+

| vin | vendor |

+-------------+--------+

| vinnumber01 | Nissan |

| vinnumber2 | Nissan |

| vinnumber3 | Nissan |

+-------------+--------+

3 rows in set (0,00 sec)

mysql\> SELECT \* FROM citizen

-\> ;

+----+-------------+-----------+--------+

| id | passport_id | surname | name |

+----+-------------+-----------+--------+

| 1 | MA111111 | Schvydkiy | Ivan |

| 2 | MB222222 | Rozumny | Taras |

| 3 | MC333333 | Khmelnyk | Bogdan |

| 4 | MD444444 | Franko | Ivan |

| 5 | UN000000 | 0 | 0 |

+----+-------------+-----------+--------+

5 rows in set (0,00 sec)

mysql\> DELETE FROM citizen WHERE citizen.id='5';

Query OK, 1 row affected (0,02 sec)

```

**DCL**

**DCL is the abstract of Data Control Language. Data Control Language includes commands such as GRANT, and is concerned with rights, permissions, and other controls of the database system. DCL is used to grant/revoke permissions on databases and their contents. DCL is simple, but MySQL permissions are a bit complex. DCL is about security. DCL is used to control the database transaction. DCL statements allow you to control who has access to a specific object in your database.**

**1. GRANT**

**2. REVOKE**

```

mysql\> create user 'serhii'@'localhost';

Query OK, 0 rows affected (0,13 sec)

mysql\> grant ALL PRIVILEGES ON CARS.\* to 'serhii'@'localhost';

Query OK, 0 rows affected (0,02 sec)

mysql\> show grants for 'serhii'@'localhost';

+----------------------------------------------------------+

| Grants for serhii@localhost |

+----------------------------------------------------------+

| GRANT USAGE ON \*.\* TO `serhii`@`localhost` |

| GRANT ALL PRIVILEGES ON `CARS`.\* TO `serhii`@`localhost` |

+----------------------------------------------------------+

2 rows in set (0,00 sec)

mysql\> revoke ALL PRIVILEGES ON CARS.\* from 'serhii'@'localhost';

Query OK, 0 rows affected (0,02 sec)

mysql\> show grants for 'serhii'@'localhost';

+--------------------------------------------+

| Grants for serhii@localhost |

+--------------------------------------------+

| GRANT USAGE ON \*.\* TO `serhii`@`localhost` |

+--------------------------------------------+

1 row in set (0,00 sec)

mysql\> drop user 'serhii'@'localhost';

Query OK, 0 rows affected (0,02 sec)

mysql\> show grants for 'serhii'@'localhost';

ERROR 1141 (42000): There is no such grant defined for user 'serhii' on host 'localhost'

```

**Step 8. Create a database of new users with different privileges. Connect to the database as a new user and verify that the privileges allow or deny certain actions.**

```

mysql\> create user 'test'@'localhost';

Query OK, 0 rows affected (0,02 sec)

mysql\> select User from mysql.user;

+------------------+

| User |

+------------------+

| debian-sys-maint |

| mysql.infoschema |

| mysql.session |

| mysql.sys |

| root |

| test |

+------------------+

6 rows in set (0,01 sec)

mysql\> GRANT SELECT ON CARS.\* TO 'test'@'localhost';

Query OK, 0 rows affected (0,02 sec)

mysql\> SHOW GRANTS for 'test'@'localhost';

+------------------------------------------------+

| Grants for test@localhost |

+------------------------------------------------+

| GRANT USAGE ON \*.\* TO `test`@`localhost` |

| GRANT SELECT ON `CARS`.\* TO `test`@`localhost` |

+------------------------------------------------+

2 rows in set (0,00 sec)

serhii@Server1:~$ sudo mysql -u test

mysql\> use CARS

Database changed

mysql\> SELECT \* FROM CARS.cars_table

-\> ;

+----+-------------+--------+---------+-------------+------------+

| id | vin | vendor | marka | passport_id | gov_number |

+----+-------------+--------+---------+-------------+------------+

| 1 | vinnumber01 | Nissan | Note | MA111111 | CH0001HC |

| 2 | vinnumber2 | Nissan | Almera | MB222222 | KA0001AK |

| 3 | vinnumber3 | Nissan | Patrol | MC333333 | LV0001VL |

| 4 | vinnumber4 | VW | Golf | MD444444 | AX0001XA |

| 5 | vinnumber5 | Toyota | Corolla | MD444444 | AX0002XA |

+----+-------------+--------+---------+-------------+------------+

5 rows in set (0,00 sec)

mysql\> INSERT INTO cars_table (vin,vendor,marka) VALUES (vinnumber6,Opel,Cadet);

ERROR 1142 (42000): INSERT command denied to user 'test'@'localhost' for table 'cars_table'

```

**Step 9. Make a selection from the main table DB MySQL**.

```

se`rhii@Server1:~$ sudo mysql -u root

Welcome to the MySQL monitor. Commands end with ; or \g.

Your MySQL connection id is 12

Server version: 8.0.31-0ubuntu0.22.04.1 (Ubuntu)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its

affiliates. Other names may be trademarks of their respective

owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql\> show databases;

+--------------------+

| Database |

+--------------------+

| CARS |

| RESTAURANT |

| TOWNS |

| information\_schema |

| mysql |

| performance\_schema |

| sys |

+--------------------+

7 rows in set (0,00 sec)

mysql\> use mysql

Reading table information for completion of table and column names

You can turn off this feature to get a quicker startup with -A

Database changed

mysql\> select Host, Db, User, Select\_priv, Show\_view\_priv from db;

+-----------+--------------------+---------------+-------------+----------------+

| Host | Db | User | Select\_priv | Show\_view\_priv |

+-----------+--------------------+---------------+-------------+----------------+

| localhost | performance\_schema | mysql.session | Y | N |

| localhost | sys | mysql.sys | N | N |

+-----------+--------------------+---------------+-------------+----------------+

2 rows in set (0,00 sec)

```

**PART 2**

**Step 10.Make backup of your database.**

```

serhii@Server1:~$ sudo mysqldump CARS \> DB\_CARS\_dump.mysql

serhii@Server1:~$ ls -al DB\_CARS\_dump.mysql

-rw-rw-r-- 1 serhii serhii 4539 січ 21 21:18 DB\_CARS\_dump.mysql

```

**Step 11.Delete the table and/or part of the data in the table.**

```

mysql\> DROP database CARS;

Query OK, 3 rows affected (0,29 sec)

mysql\> show databases;

+--------------------+

| Database |

+--------------------+

| RESTAURANT |

| TOWNS |

| information\_schema |

| mysql |

| performance\_schema |

| sys |

+--------------------+

6 rows in set (0,00 sec)

```

**Step 12.Restore your database.**

```

mysql\> show databases;

+--------------------+

| Database |

+--------------------+

| RESTAURANT |

| TOWNS |

| information\_schema |

| mysql |

| performance\_schema |

| sys |

+--------------------+

6 rows in set (0,00 sec)

mysql\> create CARS;

mysql\> CREATE DATABASE CARS;

Query OK, 1 row affected (0,03 sec)

mysql\> exit

Bye

serhii@Server1:~$ sudo mysql -u root -p CARS \< DB\_CARS\_dump.mysql

Enter password:

serhii@Server1:~$ sudo mysql

mysql\> show databases;

+--------------------+

| Database |

+--------------------+

| CARS |

| RESTAURANT |

| TOWNS |

| information\_schema |

| mysql |

| performance\_schema |

| sys |

+--------------------+

7 rows in set (0,00 sec)

mysql\> show databases;

+--------------------+

| Database |

+--------------------+

| CARS |

| RESTAURANT |

| TOWNS |

| information\_schema |

| mysql |

| performance\_schema |

| sys |

+--------------------+

7 rows in set (0,00 sec)

mysql\> use CARS

Reading table information for completion of table and column names

You can turn off this feature to get a quicker startup with -A

Database changed

mysql\> show tables;

+----------------+

| Tables\_in\_CARS |

+----------------+

| cars\_table |

| citizen |

| registration |

+----------------+

3 rows in set (0,00 sec)

mysql\> SELECT \* FROM cars\_table;

+----+-------------+--------+---------+-------------+------------+

| id | vin | vendor | marka | passport\_id | gov\_number |

+----+-------------+--------+---------+-------------+------------+

| 1 | vinnumber01 | Nissan | Note | MA111111 | CH0001HC |

| 2 | vinnumber2 | Nissan | Almera | MB222222 | KA0001AK |

| 3 | vinnumber3 | Nissan | Patrol | MC333333 | LV0001VL |

| 4 | vinnumber4 | VW | Golf | MD444444 | AX0001XA |

| 5 | vinnumber5 | Toyota | Corolla | MD444444 | AX0002XA |

+----+-------------+--------+---------+-------------+------------+

5 rows in set (0,00 sec)

```

**Step 13.Transfer your local database to RDS AWS.**

For a transfer DB to AWS S3 buckets may use cli command from localhost -

```

serhii@Server1:~$ aws s3 cp /home/serhii/DB\_CARS\_dump.mysql s3://homework-devops-course

upload: ./DB\_CARS\_dump.mysql to s3://homework-devops-course/DB\_CARS\_dump.mysql

```

**Step 14.Connect to your database.**

- Create RDS DB instance through console and create security_group rule for allow access. For checking access use command –

```

serhii@Server1:~$ nc -zv database-1.ctoflpl0hdg6.eu-central-1.rds.amazonaws.com 3306

Connection to database-1.ctoflpl0hdg6.eu-central-1.rds.amazonaws.com (3.76.178.144) 3306 port [tcp/mysql] succeeded!

```

For a direct deploy to the cloud you may use follow commands -

```

serhii@Server1:~$ sudo mysql -u admin -p -h database-1.ctoflpl0hdg6.eu-central-1.rds.amazonaws.com

[sudo] password for serhii:

Enter password:

Welcome to the MySQL monitor. Commands end with ; or \g.

Your MySQL connection id is 25

Server version: 8.0.28 Source distribution

mysql\> show databases;

+--------------------+

| Database |

+--------------------+

| information\_schema |

| mysql |

| performance\_schema |

| sys |

+--------------------+

4 rows in set (0,08 sec)

mysql\>

mysql\> create database CARS;

Query OK, 1 row affected (0,06 sec)

mysql\> exit

Bye

serhii@Server1:~$ sudo mysqldump -u admin -p -h database-1.ctoflpl0hdg6.eu-central-1.rds.amazonaws.com -P 3306 CARS \< DB\_CARS\_dump.mysql

```

**For securing usage AWS RDS DB in production AWS recommend providing that scenario --**

![](https://github.com/serhiib0x/EPAM-OnlineUA-Cloud-DevOps-Fundamentals-Autumn-2022/blob/636d324036e03a5ed0148cad589e834d5cfb7f68/DB_Administrations/Images/image004.png)

**Step 15. Execute SELECT operator similar step 6.**

```

serhii@Server1:~$ sudo mysql -u admin -p -h database-1.ctoflpl0hdg6.eu-central-1.rds.amazonaws.com

Enter password:

Welcome to the MySQL monitor. Commands end with ; or \g.

Your MySQL connection id is 67

Server version: 8.0.31 Source distribution

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its

affiliates. Other names may be trademarks of their respective

owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql\> use CARS

Reading table information for completion of table and column names

You can turn off this feature to get a quicker startup with -A

Database changed

mysql\> SELECT cars\_table.vin AS 'CAR VIN', cars\_table.gov\_number AS 'Car Plate Number', citizen.surname AS 'Owner Surname', citizen.name AS 'Owner Name', registration.city AS 'City registration' FROM cars\_table JOIN citizen ON cars\_table.passport\_id = citizen.passport\_id JOIN registration ON cars\_table.gov\_number=registration.gov\_number;

+-------------+------------------+---------------+------------+-------------------+

| CAR VIN | Car Plate Number | Owner Surname | Owner Name | City registration |

+-------------+------------------+---------------+------------+-------------------+

| vinnumber01 | CH0001HC | Schvydkiy | Ivan | Cherkasy |

| vinnumber2 | KA0001AK | Rozumny | Taras | Kyiv |

| vinnumber3 | LV0001VL | Khmelnyk | Bogdan | Lviv |

| vinnumber4 | AX0001XA | Franko | Ivan | Kharkiv |

| vinnumber5 | AX0002XA | Franko | Ivan | Kharkiv |

+-------------+------------------+---------------+------------+-------------------+

5 rows in set (0,08 sec)

```

**Step 16.Create the dump of your database.**

```

serhii@Server1:~$ sudo mysqldump -u admin -p -h database-1.ctoflpl0hdg6.eu-central-1.rds.amazonaws.com -P 3306 CARS \> cars1db.sql Enter password:

Warning: A partial dump from a server that has GTIDs will by default include the GTIDs of all transactions, even those that changed suppressed parts of the database. If you don't want to restore GTIDs, pass --set-gtid-purged=OFF. To make a complete dump, pass --all-databases --triggers --routines --events.

```

**PART 3 – MongoDB**

[https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/)

I had errors running MongoDB and I fixed them with Hyper-V disabled

https://stackoverflow.com/questions/52440629/cant-run-mongodb-because-core-dump-problem

**Step 17. Create a database. Use the use command to connect to a new database (If it doesn't exist, Mongo will create it when you write to it).**

```

test\> show databases;

admin 40.00 KiB

config 12.00 KiB

local 40.00 KiB

test\> use cars

switched to db cars

cars\>

```

**Step 18. Create a collection. Use db.createCollection to create a collection. I'll leave the subject up to you. Run show dbs and show collections to view your database and collections.**

```

cars\> db.createCollection("citizen");

{ ok: 1 }

cars\> show collections;

citizen

```

**Step 19. Create some documents. Insert a couple of documents into your collection. I'll leave the subject matter up to you, perhaps cars or hats.**

```

cars\> db.citizen.insertOne({surname: "Schvydkiy", name: "Ivan", passport: "MA111111"});

{

acknowledged: true,

insertedId: ObjectId("63cef0554ca0ff0cfd2530f4")

}

cars\> db.citizen.insertOne({surname: "Rozumny", name: "Taras", passport: "MB222222"});

{

acknowledged: true,

insertedId: ObjectId("63cef0554ca0ff0cfd2530f5")

}

cars\> db.citizen.insertOne({surname: "Khmelnyk", name: "Bogdan", passport: "MC333333"});

{

acknowledged: true,

insertedId: ObjectId("63cef0564ca0ff0cfd2530f6")

}

cars\> db.citizen.insertOne({surname: "Franko", name: "Ivan", passport: "MD444444"});

{

acknowledged: true,

insertedId: ObjectId("63cef0594ca0ff0cfd2530f7")

}

cars\>

```

**Step 20. Use find() to list documents out.**

**To search for text in database objects, you must first create an index query on the collection, and then you can use find command.**

```

cars\> db.citizen.createIndex( { "$\*\*": "text" } );

cars\> db.citizen.find( { $text: { $search: "Franko" } } )

[

{

\_id: ObjectId("63cef0594ca0ff0cfd2530f7"),

surname: 'Franko',

name: 'Ivan',

passport: 'MD444444'

}

]

cars\> db.citizen.find( { $text: { $search: "Ivan" } } )

[

{

\_id: ObjectId("63cef0594ca0ff0cfd2530f7"),

surname: 'Franko',

name: 'Ivan',

passport: 'MD444444'

},

{

\_id: ObjectId("63cef0554ca0ff0cfd2530f4"),

surname: 'Schvydkiy',

name: 'Ivan',

passport: 'MA111111'

}

]

```

