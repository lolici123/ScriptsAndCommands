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
