---
layout: post
title: MySQL Replication (Master->Slave)
---

>Replication enables data from one MySQL database server (the master) to be replicated to one or more MySQL database servers (the slaves)

# Step 1 - Configure Master

Open the mysql configuration file on the Master:

```bash
sudo nano /etc/mysql/my.cnf
```



The first step is to change the bind-address of the server to the actual WAN/LAN address.
Change the line that looks like this:

```bash
bind-address = 127.0.0.1
```
To use the right IP (replace x.x.x.x with the real number)

```bash
bind-address = x.x.x.x
```
Next we need to set server-id, and give our server a unique number.
change this line - make sure its not commented (remove the # preceding it).
Make sure this number is unique to this server


```bash
server-id = 1
```


Change log_bin value to point to the log file, where all changes are kept, so replication can take place:


```bash
log_bin = /var/log/mysql/mysql-bin.log
```
Now we need to tell the server what DB we want replicated.
This line can be repeated for use of more than one DB.  
(**Leaving this line commented will result in replication of the all databases without any additional editing of the configuration file.**)

```bash
binlog_do_db = newdatabase
```

Save and exit the configuration file.

Restart MySQL:

```bash
sudo service mysql restart
```

The next steps will take place in the MySQL shell.
We need to grant privileges to the slave:

```mysql
GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' 
IDENTIFIED BY 'password';   

FLUSH PRIVILEGES;  

USE newdatabase;
```

Lock the database to prevent any new changes:

```mysql
FLUSH TABLES WITH READ LOCK;
```

Now we need to get the filename and location from where the slave will start replicating,
enter next command, and copy the result:

```mysql
SHOW MASTER STATUS;
```

Result will look like this:

```
mysql> show master status;
+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000018 |   133772 |              |                  |
+------------------+----------+--------------+------------------+
1 row in set (0.00 sec)

```

Now open up a new terminal tab/window to the master's MySQL.
Reason is, we've just locked the databases for future changes so we can replicate it,
If we make any changes in the current window, the DB will be auto-unlocked.

Export the DB using `mysqldump`.
In shell, type:

```bash
mysqldump -u root -p --opt newdatabase > newdatabase.sql
```

Now return to the original terminal window, unlock the DB and exit.  
In mysql, type:

```mysql
UNLOCK TABLES;

\q;
```
---
# Step 2 - Configure Slave

Log into slave server's *MySQL*, create a new DB:

```mysql
CREATE DATABASE newdatabase;

\q;
```

Import the database created in previous step from Master DB:

```bash
mysql -u root -p newdatabase < /path/to/newdatabase.sql
```

Now configure slave just like we configured Master, with a few changes:

```bash
sudo nano /etc/mysql/my.cnf
```

Give a unique id (Master's Id was 1, slave should be different):

```bash
server-id= 2
relay-log= /var/log/mysql/mysql-relay-bin.log
log_bin= /var/log/mysql/mysql-bin.log
binlog_do_db = newdatabase
```

Restart MySQL:

```bash
service mysql restart
```

Enable replication (remember to put the right details from previous steps):

```bash
mysql -u root -p
```

```mysql
CHANGE MASTER TO 
MASTER_HOST='12.34.56.789',
MASTER_USER='slave_user',
MASTER_PASSWORD='password',
MASTER_LOG_FILE='mysql-bin.000001',
MASTER_LOG_POS=  107;
```

Check the status of the slave:

```mysql
START SLAVE;

SHOW SLAVE STATUS\G;
```

If there is an error in connecting to master, you might need to start slave with the following command:

```mysql
SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1; 
SLAVE START; 
```

**In-depth details of the replication process can be found in the [Official Documentation](http://dev.mysql.com/doc/refman/5.0/en/replication-howto.html)**.

---

_Found an error?  
Got a suggestion?  
Leave a comment below._

