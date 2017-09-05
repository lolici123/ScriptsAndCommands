# Scripts and Commands

## General Purpose Programs

### find
`find` is a recursive search for file names. Its general use is such: `find path -name 
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
`find` has many command line optiions to choose from and they can all be found in `man
find` but the most notible is the `-exec` option that allows you to run a command on each 
file that is returned.

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

### locate
Reads of list of files form a database and prints the paths of the files that match the
users querey.

First you need to update the database with the `updatedb` command. This must be done as
root. Next you can run `locate [OPTION]... PATTERN...` with `PATTERN` handling regular
expressions. 

### Which
`which` will find the path of a given program. for example:

```bash
UNIX:~$ which cat
/bin/cat
UNIX:~$
```

### passwd
`passwd` will allow you to change the password of the current user.

### netstat
`netstat`  - Print network connections, routing tables, interface statistics, masquer‐ade 
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

### service
`service` is a wrapper that runs an `/etc/init.d/SCRIPT` to start, stop, restart, etc. a
service. An example would be something like.

```bash
sudo service ssh start
```
***___NOTE___*** that this must be ran with Supper User privaliges.

There are also a couple of scripts in this reposatory that when ran will start or stop
both the Apache2 and the MySQL servercies.  Those scripts are
[serverStart.sh](serverStart.sh) and [serverStop.sh](serverStop.sh).

### update-rc.d
`update-rc.d` allows you to alter the boot precistance of services.  For example if you
wanted to have your SSH service enabled on boot you could use:

```bash
update-rc.d ssh enable
```
This program installs and removes System-V style init script links so it is possible to
change the percistance in a single state.  Valid states are [0|1|2|3|4|5|6]. Usage would
be:

```bash
update-rc.d apache2 enable 2
```

### wget
`wget` will download the target at the given url. For example:

```bash
phillip:scripts$ wget www.cisco.com
--2017-09-01 14:09:43--  http://www.cisco.com/
Resolving www.cisco.com (www.cisco.com)... 2600:1402:a:199::b33, 2600:1402:a:195::b33, 23.67.121.35
Connecting to www.cisco.com (www.cisco.com)|2600:1402:a:199::b33|:80... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: https://www.cisco.com/ [following]
--2017-09-01 14:09:43--  https://www.cisco.com/
Connecting to www.cisco.com (www.cisco.com)|2600:1402:a:199::b33|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/html]
Saving to: ‘index.html’

index.html                  [ <=>                          ]  60.44K  --.-KB/s    in 0.09s   

2017-09-01 14:09:44 (644 KB/s) - ‘index.html’ saved [61886]

phillip:scripts$ ls
index.html  ScriptsAndCommands
phillip:scripts$ vim
```
If the target url is a website then the downloded file will be the index.html like shown
above.  It can also be used to download .pdfs, .jpegs, etc.

### host
`host` is a DNS lookup utility. `host` is a simple utility for performing DNS lookups. It
is normally used to convert names to IP addresses and vice versa. When no arguments or
options are given, host prints a short summary of its command line arguments and options.
A quick example woudl be:

```bash
phillip:scripts$ host www.cisco.com
www.cisco.com is an alias for www.cisco.com.akadns.net.
www.cisco.com.akadns.net is an alias for wwwds.cisco.com.edgekey.net.
wwwds.cisco.com.edgekey.net is an alias for wwwds.cisco.com.edgekey.net.globalredir.akadns.net.
wwwds.cisco.com.edgekey.net.globalredir.akadns.net is an alias for e2867.dsca.akamaiedge.net.
e2867.dsca.akamaiedge.net has address 23.67.121.35
e2867.dsca.akamaiedge.net has IPv6 address 2600:1402:a:199::b33
e2867.dsca.akamaiedge.net has IPv6 address 2600:1402:a:195::b33
phillip:scripts$
```

### ping
`ping` sends ICMP ECHO_REQUESTs to the specified IP address.  Ping will then tell you if
you receive a responce, how long it took, and the Time To Live (TTL). A quick example
would be:

```bash
phillip:scripts$ ping 23.67.121.35
PING 23.67.121.35 (23.67.121.35) 56(84) bytes of data.
64 bytes from 23.67.121.35: icmp_seq=1 ttl=52 time=450 ms
64 bytes from 23.67.121.35: icmp_seq=2 ttl=52 time=167 ms
64 bytes from 23.67.121.35: icmp_seq=3 ttl=52 time=292 ms
64 bytes from 23.67.121.35: icmp_seq=4 ttl=52 time=70.0 ms
^C
--- 23.67.121.35 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3001ms
rtt min/avg/max/mdev = 70.056/245.238/450.883/142.461 ms
```

Using the `-c NUMBER` option will ping to stop after ___***NUMBER***___ 
packets sent.

### A Couple of Ping Scripts
There are two ping scripts in this reposatory and both do the same thing.  Bot are ment
to loop through a series of IP addresses and print the ones that respond to ICMP requests.
The first one [loop-ping.sh](loop-ping.sh) is a bash script that has the IP range hard
coded into it.  In the future it will take the IP range as a command line argument.

The second one [loop-ping.py](loop-ping.py) does the same as the last but is written in
python.  It also has the IP range hard codded into it and will hopefully be fixed in the
future.







## Active Info Gathering





### SMB Enumeration

The SMB netbios service lives on ports `139` and `445`.  You can scan servers looking for
netbios services with nmap with something similar to this.

```bash
nmap -v -p 139,445 -oG smb.txt 10.11.1.1-254 --open
```
* `-v` tells nmap to be verbose
* `-p` tells nmap to only check ports 139 and 445
* `-oG` tells nmap to output the data in grepable format to file `smb.txt`
* `10.111.1.1-254` is the IP range that will be scaned.
* `--open` tells nmap to only report on IPs that it found with open netbios ports.

A more specialized tool for scanning for netbios would be to use someting like `nbtscan`.

```bash
nbtscan -r 10.11.1.0/24
```
```bahs
nbtscan 10.11.1.1-254
```
* `-r` tels nbtscan to use local port 137 for scans. Win95 boxes respond to this only.

The ouput of this command might look something like this.
```
Doing NBT name scan for addresses from 10.11.1.1-254

IP address       NetBIOS Name     Server    User             MAC address      
------------------------------------------------------------------------------
10.11.1.5        ALICE            <server>  ALICE            00:50:56:89:25:59
10.11.1.24       PAYDAY           <server>  PAYDAY           00:00:00:00:00:00
10.11.1.31       RALPH            <server>  USER67           00:50:56:89:17:75
10.11.1.22       BARRY            <server>  BARRY            00:00:00:00:00:00
10.11.1.115      TOPHAT           <server>  TOPHAT           00:00:00:00:00:00
10.11.1.128      DJ               <server>  DJ               00:50:56:89:45:48
10.11.1.73       GAMMA            <server>  <unknown>        00:50:56:89:21:c2
10.11.1.136      SUFFERANCE       <server>  SUFFERANCE       00:00:00:00:00:00
10.11.1.202      ORACLE           <server>  ORACLE           00:50:56:89:69:ce
10.11.1.229      MAIL             <server>  MAIL             00:50:56:89:5d:07
10.11.1.227      JD               <server>  JD               00:50:56:89:1b:3b
10.11.1.145      HELPDESK         <server>  <unknown>        00:50:56:89:7e:40
10.11.1.220      MASTER           <server>  <unknown>        00:50:56:89:31:e1
10.11.1.221      SLAVE            <server>  <unknown>        00:50:56:89:34:54
10.11.1.230      KEVIN            <server>  <unknown>        00:50:56:89:32:45
10.11.1.218      OBSERVER         <server>  <unknown>        00:50:56:89:4b:13
10.11.1.223      JEFF             <server>  <unknown>        00:50:56:89:03:d2
```
