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
change this line - make sure its not commented (remove the # from the head of the line).
Make sure this number is unique to this server


```bash
server-id = 1
```


Change log_bin value to point to the log file, where all changes are kept, so replication can take place:


```bash
log_bin = /var/log/mysql/mysql-bin.log
```
Now we need to tell the server what DB we want replicated.
This line can be repeated for use of more than one DB:

```bash
binlog_do_db = DBtoReplicate
```

Save and exit the configuration file.

Restart MySQL:

```bash
sudo service mysql restart
```