#!/bin/bash
CREATE_FILE="[]_[]_[]".txt
echo > $CREATE_FILE 2>&1
echo "=============01.Default ID ===========" >> $CREATE_FILE 2>&1
if [ `cat/etc/passwd | egrep "lP:|uucp:|nuucp:" | grep -v "lpd" | wc -l` -eq 0 ]
	then
		echo "lP, uucp, nuucp ID  not found" >> $CREATE_FILE 2>&1
	else
		cat/etc/passwd | egrep "lP: | uucp: | nuucp:" >> $CREATE_FILE 2>&1
fi
cat ./$CREATE_FILE


#!/bin/bash
CREATE_FILE="[]_[]_[]".txt
echo > $CREATE_FILE 2>&1
echo "==========02.root_mgm start===========" >> $CREATE_FILE 2>&1
if [ `awk -F: '$3==0' /etc/paswd | wc -l` -eq 1 ]
    then
		echo "======== GOOD ========" >> $CREATE_FILE 2>&1
		awk -F: '$3==0 { print $1 " -> UID="$3 }' /etc/passwd >> $CREATE_FILE 2>&1
    else
		echo "======== BAD ========" >> $CREATE_FILE 2>&1
fi
cat ./$CREATE_FILE



#!/bin/bash
CREATE_FILE="[]_[]_[]".txt
echo > $CREATE_FILE 2>&1
echo "====03.Passwd File Permission Check start====" >> $CREATE_FILE 2>&1
if [ -f /etc/passwd ]
	then
	    ls -alL /etc/passwd >> $CREATE_FILE 2>&1
	else
	    echo "/etc/passwd file not found" >> $CREATE_FILE 2>&1
fi
cat ./$CREATE_FILE

if [ `ls -alL /etc/passwd | awk '{print $1}'| grep ".rw-r--r--" | wc -l` -eq 1 ]
then
	echo "Passwd file permission check Result : GOOD" >> $CREATE_FILE 2>&1
else
	echo "Passwd file permission check Result : BAD" >> $CREATE_FILE 2>&1
fi
echo "------------[END]------------" >> $CREATE_FILE 2>&1
cat ./$CREATE_FILE




#!/bin/bash
CREATE_FILE="[학번]_[test]_[반]".txt
echo > $CREATE_FILE 2>&1
echo "=== 04.GROUP file Permission check START ===" >>  $CREATE_FILE 2>&1
ls -alL /etc/group >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "---------------[Result]---------------" >> $CREATE_FILE 2>&1
if [ `ls -alL /etc/group | awk '{print $1}' | grep ".rw-r--r--" | wc -l` -eq 1 ]
then
	echo "group check Result : Good" >> $CREATE_FILE 2>&1
else
	echo "group check Result : BAD" >> $CREATE_FILE 2>&1
fi
echo "---------------[END]---------------" >> $CREATE_FILE 2>&1
cat ./$CREATE_FILE



#!/bin/bash
CREATE_FILE="[학번]_[test]_[반]".txt
echo > $CREATE_FILE 2>&1
echo "=======05.Passwd rule check START =======" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1


if [ -f /etc/login.defs ]
	then
		grep -v '#' /etc/login.defs | grep -i "PASS_MIN_LEN" >> $CREATE_FILE 2>&1
	else
		echo "/etc/login.defs file not founds" >> $CREATE_FILE 2>&1
fi


if [ -f /etc/login.defs ]
	then
		grep -v '#' /etc/login.defs | grep -i "PASS_MAX_DAYS" >> $CREATE_FILE 2>&1
	else
		echo "/etc/login.defs file not founds" >> $CREAT_FILE 2>&1
fi


if [ -f /etc/login.defs ]
	then
		grep -v '#' /etc/login.defs | grep -i "PASS_MIN_DAYS" >> $CREATE_FILE 2>&1
	else
		echo "/etc/login.defs file not founds" >> $CREATE_FILE 2>&1
fi

if [ `cat /etc/login.defs | grep -i "PASS_MIN_LEN" | grep -v "#" | awk '{print $2}'` -gt 7 ]

then
echo "passwd rule check result : GOOD" >> password.txt
else
echo "passwd rule check result : BAD" >> password.txt
fi

if [ `cat /etc/login.defs | grep -i "PASS_MAX_DAYS" | grep -v "#" | awk '{print $2}'` -gt 70]
then
echo "passwd rule check result : BAD " >> password.txt
else
echo "passwd rule check result : GOOD" >> password.txt
fi

if [ `cat /etc/login.defs | grep -i "PASS_MIN_DAYS" | grep -v "#" | awk '{print $2}'` -gt 0]
then
echo "passwd rule check result : GOOD" >> password.txt
else
echo "passwd rule check result : BAD" >> password.txt
fi

echo "---------------[Result]---------------" >> $CREATE_FILE 2>&1
if [ `cat password.txt | grep -i "BAD" | wc -l` -eq 0]
then
echo "passwd rule check result : GOOD" >> $CREATE_FILE 2>&1
else
echo "passwd rule check result : BAD" >> $CREATE_FILE 2>&1
fi

rm -rf password.txt
echo "---------------[END]---------------" >> $CREATE_FILE 2>&1
cat ./$CREATE_FILE



#!/bin/bash
CREATE_FILE=`hostname`"test".txt
echo > $CREATE_FILE 2>&1
echo "====== 06.Shell check START ======" >> $CREATE_FILE 2>&1
if [ -f /etc/passwd ]
then
	cat /etc/passwd | egrep "^daemon|^bin|^sys|^adm|^listen|^nobody|^nobody4|^noaccess|^diag|^operator|^games|^gopher"|grep -v "admin" >> $CREATE_FILE 2>&1

else
	echo "/etc/passwd File not found" >> $CREATE_FILE 2>&1
fi

echo "------------[Result]------------" >> $CREATE_FILE 2>&1
if [ `cat /etc/passwd | egrep "^daemon|^bin|^sys|^adm|^listen|^nobody|^nobody4|^noaccess|^diag|^operator|^games|^gopher"| grep -v "admin" | egrep -v "false|nologin" | wc -l` -eq 0 ]

then
	echo "shell check Result : Good" >> $CREATE_FILE 2>&1
else
	echo "shell check Result : BAD" >> $CREATE_FILE 2>&1
fi
echo "------------[END]------------" >> $CREATE_FILE 2>&1
cat ./$CREATE_FILE




#!/bin/bash
CREATE_FILE="[학번]_[이름]_[반]".txt
echo > $CREATE_FILE 2>&1
echo "===== 07.SU check START =====" >> $CREATE_FILE 2>&1
if [ -f /etc/pam.d/su ]
then
    echo "(1) /etc/pam.d/su File" >> $CREATE_FILE 2>&1
    cat /etc/pam.d/su >> $CREATE_FILE 2>&1
else
    echo "/etc/pam.d/su File not found" >> $CREATE_FILE 2>&1
fi

if [ -f /etc/group ]
then
    echo "(2) /etc/group File" >> $CREATE_FILE 2>&1
    cat /etc/group >> $CREATE_FILE 2>&1
else
    echo "/etc/group File not found" >> $CREATE_FILE 2>&1
fi

echo "----- [Result] -----" >> $CREATE_FILE 2>&1
if [ ` cat /etc/pam.d/su | grep -v 'trust' | grep 'pam_wheel.so' | grep 'use_uid' | grep -v '^#' | wc -l` -eq 0 ]
    then
        echo "SU Check Result : BAD" >> $CREATE_FILE 2>&1
    else
        echo "SU Check Result : GOOD" >> $CREATE_FILE 2>&1
fi

echo "-----[END]-----" >> $CREATE_FILE 2>&1
cat ./$CREATE_FILE





#!/bin/bash
CREATE_FILE="[]_[]_[]".txt
echo > $CREATE_FILE 2>&1
echo "======== 08.Shadow check START ========" >> $CREATE_FILE 2>&1
if [ -f /etc/shadow ]
	then
		ls -alL /etc/shadow >> $CREATE_FILE 2>&1
	else
		echo "/etc/shadow File not found" >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1

echo "-----------[Result]----------" >> $CREATE_FILE 2>&1
if [ `ls -alL /etc/shadow | awk '{print $1}' | grep "..--------" | wc -l` -eq 1 ]
then
	echo "Shadow Check Result : GOOD" >> $CREATE_FILE 2>&1
else
	echo "Shadow Check Result : BAD" >> $CREATE_FILE 2>&1
fi
echo "-----------[END]-----------" >> $CREATE_FILE 2>&1

cat ./$CREATE_FILE


: <<'END'
#!/bin/bash
CREATE_FILE="[]_[]_[]".txt
echo > $CREATE_FILE 2>&1
echo "=====09. UMASK Check Start=====" >> $CREATE_FILE 2>&1
echo >> $CREATE_FILE 2>&1
echo "/etc/profile File Check " >> $CREATE_FILE 2>&1
if [ -f /etc/profile ]
	then
		cat /etc/profile | grep -i umask >> $CREATE_FILE 2>&1
	else
		echo "/etc/profile File not found" >> $CREATE_FILE 2>&1
fi

echo "-----[Result]-----" >> $CREATE_FILE 2>&1
if [ `cat /etc/profile | grep -i "umask" | grep -v "#" | awk -F"0" '$2 >= "22"' | wc -l` -gt 0 ]

then
		echo "UMASK Check Result : GOOD" >> $CREATE_FILE
	else
		echo "UMASK Chekc Result : BAD" >> $CREATE_FILE
fi

echo "-----[END]-----" >> $CREATE_FILE 2>&1
cat ./$CREATE_FILE
END



#!/bin/bash
CREATE_FILE="[]_[]_][]".txt
echo > $CREATE_FILE 2>&1
echo "===10.SetUID, SetGID Check Start===" >> $CREATE_FILE 2>&1
echo >> $CREATE_FILE 2>&1
FILES="/sbin/dump /usr/bin/lpd /usr/bin/newgrp /sbin/restore /usr/bin/lpr /usr/sbin/lpc /sbin/unix_chkpwd /usr/sbin /lpc-lpd /usr/bin/at /usr/bin/lprm /usr/sbin/traceroute /usr/bin/lpq /usr/bin/lprm-lpd"

for check_file in $FILES
do
if [ -f $check_file ]
	then
		if [ `ls -alL $check_file | awk '{print $1}' | grep -i 's' | wc -l` -gt 0 ]
	then
		ls -alL $check_file | awk '{print $1}' | grep -i 's' >> set.txt
		ls -alL $check_file >> $CREATE_FILE
	else
		echo " " >> set.txt
		fi
fi
done

echo "--------[Result]--------" >> $CREATE_FILE 2>&1
if [ `cat set.txt | awk '{print $1}' |grep -i 's' | wc -l` -gt 0 ]
then
	echo "SetUID Check Result : BAD" >> $CREATE_FILE 2>&1
else
	echo "SetUID Check Result : GOOD" >> $CREATE_FILE 2>&1
fi
echo "--------[END]--------" >> $CREATE_FILE 2>&1
rm -rf ./set.txt
cat ./$CREATE_FILE



#!/bin/bash
CREATE_FILE="[]_[]_[]".txt
echo > $CREATE_FILE 2>&1
echo "======11.Xinetd.conf Check Start=====" >> $CREATE_FILE 2>&1

if [ -f /etc/xinetd.conf ]
    then
        ls -alL /etc/xinetd.conf >> $CREATE_FILE 2>&1
    else
        echo "Xinetd.conf File not found" >> $CREATE_FILE 2>&1
fi

echo "-------[Result]-------" >> $CREATE_FILE 2>&1
if [ `ls -alL /etc/xinetd.conf | awk '{print $1}' | grep '........-.' | wc -l` -eq 1 ]
then
    echo "Xinetd.conf Chekc Result : GOOD" >> $CREATE_FILE 2>&1
else
    echo "Xinetd.conf Chekc Result : BAD" >> $CREATE_FILE 2>&1
fi

echo "-------[END]-------" >> $CREATE_FILE 2>&1
cat ./$CREATE_FILE



#!/bin/bash
CREATE_FILE="[]_[]_[]".txt
echo > $CREATE_FILE 2>&1
echo "======12. History File Check Start======" >> $CREATE_FILE 2>&1

HOMEDIRS=`cat /etc/passwd | awk -F":" 'length($6) > 0 {print $6}' | sort -u | grep -v '/bin/false' | grep -v 'nologin' | grep -v`

FILES = ".sh_history .bash_history .history"

for dir in $HOMEDIRS
do
        for file in $FILES
        do
                if [ -f $dir/$file ]
                then
                        if [ `ls -dal $dir/$file | awk '{print $1}' | grep "...------" | wc -l` -eq 1 ]
                        then
                                echo "history Check Result : GOOD " >> history.txt
                                ls -dal $dir/$file >> $CREATE_FILE
                else
                        echo " history file not found" >> temp.txt
                        ls -dal $dir/$file >> $CREATE_FILE
                fi
        else
                echo " history file not found" >> temp.txt
        fi
        done
done

echo "-------[Result]--------" >> $CREATE_FILE 2>&1
if [ `cat history.txt | grep "BAD" | wc -l` -eq 0 ]
then
	        echo "history Check Result : Good " >> $CREATE_FILE
        else
	        echo "history Check Result : BAD " >> $CREATE_FILE
fi
echo "--------[END]-------" >> $CREATE_FILE 2>&1
rm -rf ./history.txt
cat ./$CREATE_FILE







#!/bin/bash
CREATE_FILE="[]_[]_[]".txt

echo > $CREATE_FILE 2>&1

echo "======= 13.profile permission check START =======" >> $CREATE_FILE 2>&1

if [ -f /etc/profile ]
	then
		ls -alL /etc/profile >> $CREATE_FILE 2>&1
	else
		echo "/etc/profile not found" >> $CREATE_FILE 2>&1
fi

echo " ===== [Result] =====" >> $CREATE_FILE 2>&1
if [ `ls -alL /etc/profile | awk '{print $1}' | grep '...-.--.--' | wc -l` -eq 1 ]
	then
		echo "profile permission Check Result : Good" >> $CREATE_FILE 2>&1
	else
		echo "profile permission CHeck Result : BAD" >> $CREATE_FILE 2>&1
fi

echo "===== [Profile permission check END] =====" $CREATE_FILE 2>&1

cat ./$CREATE_FILE



#!/bin/bash
CREATE_FILE="[]_[]_[]".txt

echo > $CREATE_FILE 2>&1

echo "===== 14.host permission check start =====" >> $CREATE_FILE 2>&1

if [ -f /etc/hosts ]
	then
		ls -alL /etc/hosts >> $CREATE_FILE 2>&1
	else
		echo "/etc/hosts file not found" >> $CREATE_FILE 2>&1
fi

echo "====== [Result] ======" >> $CREATE_FILE 2>&1

if [ `ls -alL /etc/hosts | awk '{print $1}' | grep '...-.--.--' | wc -l` -eq 1 ]
	then
		echo "host permissin Check REsult : GOOD" >> $CREATE_FILE 2>&1
	else
		echo "Host permissin check Result : Bad" >> $CREATE_FILE 2>&1
fi


echo "===== [hosts permission check end] ======" >> $CREATE_FILE 2>&1

cat ./$CREATE_FILE








echo ":::::::::: ::::    ::: :::::::::  "
echo ":+:        :+:+:   :+: :+:    :+: "
echo "+:+        :+:+:+  +:+ +:+    +:+ "
echo "+#++:++#   +#+ +:+ +#+ +#+    +:+ "
echo "+#+        +#+  +#+#+# +#+    +#+ "
echo "#+#        #+#   #+#+# #+#    #+# "
echo "########## ###    #### #########  "



echo " *******   ******** **********   *******   *******  "
echo "/**////** **////// /////**///   **/////** /**////** "
echo "/**   /**/**           /**     **     //**/**   /** "
echo "/******* /*********    /**    /**      /**/*******  "
echo "/**////  ////////**    /**    /**      /**/**///**  "
echo "/**             /**    /**    //**     ** /**  //** "
echo "/**       ********     /**     //*******  /**   //**"
echo "//       ////////      //       ///////   //     // "



echo "************************** 취약점 체크 종료 **************************" 
