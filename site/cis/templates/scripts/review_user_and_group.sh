#/bin/bash

# First we do some housekeeping 
find  /var/log/CIS/ -atime +30 -name '*.log' -delete

# CIS 9.2.2
two=$(/bin/grep '^+:' /etc/passwd | wc -l)

if [ $two -gt 0 ]; then 
   touch /var/log/CIS/cis-9.2.2.log
   echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.2.log
   echo "Found + in /etc/passwd" >> /var/log/CIS/cis-9.2.2.log
   /bin/grep '^+:' /etc/passwd >> /var/log/CIS/cis-9.2.2.log
fi

# CIS 9.2.3  
three=$(/bin/grep '^+:' /etc/shadow | wc -l)

if [ $three -gt 0 ]; then 
   touch /var/log/CIS/cis-9.2.3.log
   echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.3.log
   echo "Found + in /etc/shadow" >> /var/log/CIS/cis-9.2.3.log
   /bin/grep '^+:' /etc/shadow >> /var/log/CIS/cis-9.2.3.log
fi

# CIS 9.2.4  
four=$(/bin/grep '^+:' /etc/group | wc -l)

if [ $four -gt 0 ]; then 
   touch /var/log/CIS/cis-9.2.4.log
   echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.4.log
   echo "Found + in /etc/group" >> /var/log/CIS/cis-9.2.4.log
   /bin/grep '^+:' /etc/group >> /var/log/CIS/cis-9.2.4.log
fi

# CIS 9.2.5  
five=$(/bin/awk -F: '($3 == 0) { print $1 }' /etc/passwd | wc -l)

if [ $five -ne 1 ]; then 
   touch /var/log/CIS/cis-9.2.5.log
   echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.5.log
   echo "User other then root has UID 0" >> /var/log/CIS/cis-9.2.5.log
   /bin/awk -F: '($3 == 0) { print $1 }' /etc/passwd >> /var/log/CIS/cis-9.2.5.log
fi

# CIS 9.2.6
if [ "`echo $PATH | /bin/grep :: `" != "" ]; then
	touch /var/log/CIS/cis-9.2.6.log
        echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.6.log
        echo "Empty Directory in PATH (::)" >> /var/log/CIS/cis-9.2.6.log
fi

if [ "`echo $PATH | /bin/grep :$`" != "" ]; then
	touch /var/log/CIS/cis-9.2.6.log
        echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.6.log
        echo "Trailing : in PATH"  >> /var/log/CIS/cis-9.2.6.log
fi

p=`echo $PATH | /bin/sed -e 's/::/:/' -e 's/:$//' -e 's/:/ /g'`
set -- $p
while [ "$1" != "" ]; do
   if [ "$1" = "." ]; then
        echo "PATH contains ."
        shift
        continue
   fi
   if [ -d $1 ]; then
        dirperm=`/bin/ls -ldH $1 | /bin/cut -f1 -d" "`
        if [ `echo $dirperm | /bin/cut -c6 ` != "-" ]; then
	  touch /var/log/CIS/cis-9.2.6.log
          echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.6.log
          echo "Group Write permission set on directory $1" >> /var/log/CIS/cis-9.2.6.log
        fi
        if [ `echo $dirperm | /bin/cut -c9 ` != "-" ]; then
	  touch /var/log/CIS/cis-9.2.6.log
          echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.6.log
          echo "Other Write permission set on directory $1" >> /var/log/CIS/cis-9.2.6.log
        fi
          dirown=`ls -ldH $1 | awk '{print $3}'`
          if [ "$dirown" != "root" ] ; then
	     touch /var/log/CIS/cis-9.2.6.log
             echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.6.log
             echo $1 is not owned by root  >> /var/log/CIS/cis-9.2.6.log
          fi
        else
	touch /var/log/CIS/cis-9.2.6.log
        echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.6.log
        echo $1 is not a directory >> /var/log/CIS/cis-9.2.6.log
        fi
   shift
done

# CIS 9.2.7
for dir in `/bin/egrep -v '(root|halt|sync|shutdown)' /etc/passwd | /bin/awk -F: '($8 == "PS" && $7 != "/sbin/nologin") { print $6 }'`; do dirperm=`/bin/ls -ld $dir | /bin/cut -f1 -d" "`
  if [ `echo $dirperm | /bin/cut -c6 ` != "-" ]; then
    touch /var/log/CIS/cis-9.2.7.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.7.log
    echo "Group Write permission set on directory $dir" >> /var/log/CIS/cis-9.2.7.log
  fi

  if [ `echo $dirperm | /bin/cut -c8 ` != "-" ]; then
    touch /var/log/CIS/cis-9.2.7.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.7.log
    echo "Other Read permission set on directory $dir" >> /var/log/CIS/cis-9.2.7.log
  fi

  if [ `echo $dirperm | /bin/cut -c9 ` != "-" ]; then
    touch /var/log/CIS/cis-9.2.7.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.7.log
    echo "Other Write permission set on directory $dir" >> /var/log/CIS/cis-9.2.7.log
  fi

  if [ `echo $dirperm | /bin/cut -c10 ` != "-" ]; then
    touch /var/log/CIS/cis-9.2.7.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.7.log
    echo "Other Execute permission set on directory $dir" >> /var/log/CIS/cis-9.2.7.log
  fi
done

# CIS 9.2.8
for dir in `/bin/egrep -v '(root|sync|halt|shutdown)' /etc/passwd | /bin/awk -F: '($7 != "/sbin/nologin") { print $6 }'`; do
for file in $dir/.[A-Za-z0-9]*; do
  if [ ! -h "$file" -a -f "$file" ]; then
        fileperm=`/bin/ls -ld $file | /bin/cut -f1 -d" "`
        if [ `echo $fileperm | /bin/cut -c6 ` != "-" ]; then
	  touch /var/log/CIS/cis-9.2.8.log
          echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.8.log
          echo "Group Write permission set on file $file" >> /var/log/CIS/cis-9.2.8.log
        fi
        if [ `echo $fileperm | /bin/cut -c9 ` != "-" ]; then
	  touch /var/log/CIS/cis-9.2.8.log
          echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.8.log
          echo "Other Write permission set on file $file" >> /var/log/CIS/cis-9.2.8.log
        fi
  fi
 done
done

# CIS 9.2.9 
for dir in `/bin/egrep -v '(root|sync|halt|shutdown)' /etc/passwd | /bin/awk -F: '($7 != "/sbin/nologin") { print $6 }'`; do
  for file in $dir/.netrc; do
    if [ ! -h "$file" -a -f "$file" ]; then
	fileperm=`/bin/ls -ld $file | /bin/cut -f1 -d" "`
	if [ `echo $fileperm | /bin/cut -c5 ` != "-" ]
	then
	touch /var/log/CIS/cis-9.2.9.log
	echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.9.log
	echo "Group Read set on $file" >> /var/log/CIS/cis-9.2.9.log
	fi
	if [ `echo $fileperm | /bin/cut -c6 ` != "-" ]
	then
	touch /var/log/CIS/cis-9.2.9.log
	echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.9.log
	echo "Group Write set on $file" >> /var/log/CIS/cis-9.2.9.log
	fi
	if [ `echo $fileperm | /bin/cut -c7 ` != "-" ]
	then
	touch /var/log/CIS/cis-9.2.9.log
	echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.9.log
	echo "Group Execute set on $file" >> /var/log/CIS/cis-9.2.9.log
	fi
	if [ `echo $fileperm | /bin/cut -c8 ` != "-" ]
	then
	touch /var/log/CIS/cis-9.2.9.log
	echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.9.log
	echo "Other Read set on $file" >> /var/log/CIS/cis-9.2.9.log
	fi
	if [ `echo $fileperm | /bin/cut -c9 ` != "-" ]
	then
	touch /var/log/CIS/cis-9.2.9.log
	echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.9.log
	echo "Other Write set on $file" >> /var/log/CIS/cis-9.2.9.log
	fi
	if [ `echo $fileperm | /bin/cut -c10 ` != "-" ]
	then
	echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.9.log
	echo "Other Execute set on $file" >> /var/log/CIS/cis-9.2.9.log
	fi
    fi
  done
done

# CIS 9.2.10
#!/bin/bash
for dir in `/bin/egrep -v '(root|halt|sync|shutdown)' /etc/passwd| /bin/awk -F: '($7 != "/sbin/nologin") { print $6 }'`; do
  for file in $dir/.rhosts; do
    if [ ! -h "$file" -a -f "$file" ]; then
	touch /var/log/CIS/cis-9.2.10.log
	echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.10.log
	echo ".rhosts file in $dir" >> /var/log/CIS/cis-9.2.10.log
    fi done
done


# CIS 9.2.11
for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
  grep -q -P "^.*?:x:$i:" /etc/group
  if [ $? -ne 0 ]; then
    touch /var/log/CIS/cis-9.2.11.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.11.log
    echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group" >> /var/log/CIS/cis-9.2.11.log
  fi
done

# CIS 9.2.12
 awk -F: '{ print $1 " " $3 " " $6 }' /etc/passwd  | while read user uid dir; do
  if [ $uid -ge 1000 -a ! -d "$dir" -a $user != "nfsnobody" ]; then
    touch /var/log/CIS/cis-9.2.12.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.12.log
    echo "The home directory ($dir) of user $user does not exist." >> /var/log/CIS/cis-9.2.12.log
  fi
done

# CIS 9.2.13
awk -F: '{ print $1 " " $3 " " $6 }' /etc/passwd | while read user uid dir; do
  if [ $uid -ge 1000 -a -d "$dir" -a $user != "nfsnobody" ]; then
    owner=$(stat -L -c "%U" "$dir")
  if [ "$owner" != "$user" ]; then
    touch /var/log/CIS/cis-9.2.13.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.13.log
    echo "The home directory ($dir) of user $user is owned by $owner." >>  /var/log/CIS/cis-9.2.13.log
  fi
 fi
done


# CIS 9.2.14
 /bin/cut -f3 -d":" /etc/passwd | /bin/sort -n | /usr/bin/uniq -c | while read x ; do
  [ -z "${x}" ] && break
  set - $x
  if [ $1 -gt 1 ]; then
    touch /var/log/CIS/cis-9.2.14.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.14.log
    users=`/bin/gawk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | /usr/bin/xargs`
    echo "Duplicate UID ($2): ${users}" >> /var/log/CIS/cis-9.2.14.log
  fi
done

# CIS 9.2.15
/bin/cut -f3 -d":" /etc/group | /bin/sort -n | /usr/bin/uniq -c | while read x ; do
  [ -z "${x}" ] && break
  set - $x
    if [ $1 -gt 1 ]; then
    touch /var/log/CIS/cis-9.2.15.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.15.log
    grps=`/bin/gawk -F: '($3 == n) { print $1 }' n=$2  /etc/group | xargs`
    echo "Duplicate GID ($2): ${grps}" >> /var/log/CIS/cis-9.2.15.log
  fi
done

# CIS 9.2.16 
defUsers="root bin daemon adm lp sync shutdown halt mail news uucp operator games
gopher ftp nobody nscd vcsa rpc mailnull smmsp pcap ntp dbus avahi sshd rpcuser
nfsnobody haldaemon avahi-autoipd distcache apache oprofile webalizer dovecot squid
named xfs gdm sabayon usbmuxd rtkit abrt saslauth pulse postfix tcpdump"

/bin/awk -F: '($3 < 1000) { print $1" "$3 }' /etc/passwd | while read user uid; do
  found=0
  for tUser in ${defUsers}
  do
    if [ ${user} = ${tUser} ]; then
      found=1
    fi
  done
  if [ $found -eq 0 ]; then
    touch /var/log/CIS/cis-9.2.16.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.16.log
    echo "User $user has a reserved UID ($uid)." >> /var/log/CIS/cis-9.2.16.log
  fi
done

# CIS 9.2.17 
cut -f1 -d":" /etc/passwd| /bin/sort -n | /usr/bin/uniq -c | while read x ; do 
  [ -z "${x}" ] && break
  set - $x
  if [ $1 -gt 1 ]; then
    touch /var/log/CIS/cis-9.2.17.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.17.log
    uids=`/bin/gawk -F: '($1 == n) { print $3 }' n=$2 /etc/passwd | xargs`
    echo "Duplicate User Name ($2): ${uids}" >> /var/log/CIS/cis-9.2.17.log
  fi
done


# CIS 9.2.18
cut -f1 -d":" /etc/group | /bin/sort -n | /usr/bin/uniq -c | while read x ; do 
  [ -z "${x}" ] && break
  set - $x
  if [ $1 -gt 1 ]; then
    touch /var/log/CIS/cis-9.2.18.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.18.log
    gids=`/bin/gawk -F: '($1 == n) { print $3 }' n=$2 /etc/group | xargs`
    echo "Duplicate Group Name ($2): ${gids}" >> /var/log/CIS/cis-9.2.18.log
 fi
done

# CIS 9.2.19
for dir in `/bin/awk -F: '{ print $6 }' /etc/passwd`; do
  if [ ! -h "$dir/.netrc" -a -f "$dir/.netrc" ]; then
    touch /var/log/CIS/cis-9.2.19.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.19.log
    echo ".netrc file $dir/.netrc exists" >> /var/log/CIS/cis-9.2.19.log
  fi
done

# CIS 9.2.20
for dir in `/bin/awk -F: '{ print $6 }' /etc/passwd `; do
  if [ ! -h "$dir/.forward" -a -f "$dir/.forward" ]; then
    touch /var/log/CIS/cis-9.2.20.log
    echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.20.log
    echo ".forward file $dir/.forward exists"
  fi
done
