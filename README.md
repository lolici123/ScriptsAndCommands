# Scripts and Commands

## General Purpose Programs

### Find
Find is a recursive search for file names. Its general use is such: `find path -name 
PATTERN`.  An example would be something like this.

```bash
phillip:ScriptsAndCommands$ find ~/scripts -name "*.sh"
/home/phillip/scripts/serverStart.sh
/home/phillip/scripts/dns-enum.sh
/home/phillip/scripts/ScriptsAndCommands/dns-enum.sh
/home/phillip/scripts/ScriptsAndCommands/server-os-disc.sh
/home/phillip/scripts/ScriptsAndCommands/smb-check.sh
/home/phillip/scripts/ScriptsAndCommands/loop-ping.sh
/home/phillip/scripts/serverStop.sh
/home/phillip/scripts/trafficStop.sh
/home/phillip/scripts/trafficStart.sh
phillip:ScriptsAndCommands$ 
```
Find has many command line optiions to choose from and they can all be found in `man find`
but the most notible is the `-exec` option that allows you to run a command on each file
that is returned.

```bash
phillip:ScriptsAndCommands$ find ~/scripts -name "*Stop.sh" -exec cat {} \;
#!/bin/bash

sudo service apache2 stop;
sudo service mysql stop;
#!/bin/bash

sudo iptables -A INPUT ! -i lo -p tcp --destination-port 80 -j DROP
phillip:ScriptsAndCommands$ 
```
Notice that the `;` needed to be excaped - `\;`.

### Locate
Reads of list of files form a database and prints the paths of the files that match the
users querey.

Firt you need to update the database with the `updatedb` command. This must be done as
root. Next you can run `locate [OPTION]... PATTERN...` with `PATTERN` handling regular
expressions. 

### Which
Which will find the path of a given program. for example:

```bash
UNIX:~$ which cat
/bin/cat
UNIX:~$
```

### Passwd
`passwd` will allow you to change the password of the current user.

### Netstat
netstat  - Print network connections, routing tables, interface statistics, masquer‐ade 
connections, and multicast memberships.  A usefull example of how to use `netstat would be

```bash
netstat -antp | grep sshd
```
What is returned will tell you whether or not the ssh service is running. Netstat has
several options.  The ones used in the example above are for

* -a, --all
    * Show  both  listening and non-listening sockets.  With the --interfaces option, show
interfaces that are not up
* -n, --numeric
    * Show numerical addresses instead of trying to determine symbolic host, port or  user
names.
* -p, --program
    * Show the PID and name of the program to which each socket belongs.
* -t, --tcp
    * tells netstat to only pay attention to TCP type connections

an example witout the grep will look like this.

```bash
phillip:ScriptsAndCommands$ sudo netstat -antp
[sudo] password for phillip: 
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:902             0.0.0.0:*               LISTEN      1115/vmware-authdla
tcp        0      0 0.0.0.0:3689            0.0.0.0:*               LISTEN      2484/rhythmbox  
tcp        0      0 127.0.1.1:53            0.0.0.0:*               LISTEN      1386/dnsmasq    
tcp6       0      0 :::902                  :::*                    LISTEN      1115/vmware-authdla
tcp6       0      0 :::3689                 :::*                    LISTEN      2484/rhythmbox  
phillip:ScriptsAndCommands$ 
```

This can be ran without Supper User privilages but you won't get as much usful
information.

### Service
Service is a wrapper that runs an `/etc/init.d/SCRIPT` to start, stop, restart, etc. a
service. An example would be something like.

```bash
sudo service ssh start
``
***___NOTE___*** that this must be ran with Supper User privaliges.

There are also a couple of scripts in this reposatory that when ran will start or stop
both the Apache2 and the MySQL servercies.  Those scripts are
[serverStart.sh](serverStart.sh) and [serverStop.sh](serverStop.sh).

