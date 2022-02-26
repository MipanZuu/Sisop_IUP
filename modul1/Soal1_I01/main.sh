#!/bin/bash
function_starting () {
        while [ $i -le $N ]; do
                if [ $i -le 9 ]; then
                add="0"
                else
                add=""
                fi
                
                link=`curl -i https://loremflickr.com/320/240 -s | awk '/location/{print $2}'`
                lorem=https://loremflickr.com
		dot=".jpg"
		url=${lorem}${link:0:$((${#link} - 4 - 1))}${dot}
                # url=${lorem:0:-1}
		echo $url
                curl "$url" > $directory/PIC_${add}${i}.jpg
                # echo ""
                i=$(($i+1))
                done
                zip --password $password -r $directory.zip $directory
                rm -rf $directory
}

find_range () {
    	i=`ls $directory | sort -r | awk 'NR==1{x=substr($1,5,2);printf "%d\n",x}'`
    	i=`expr $i + 1`
    	N=`expr $N + $i - 1`
}


info=$(date +"%m/%d/%y %H:%M:%S")
info_date=$(date +"%y-%m-%d")
direct="users/user.txt"
input1="dl"
input2="att"
i=1

echo "LOGIN!!"
echo "Please enter your username: "
read username;
echo "Please enter your password: "
read -s password;
if grep -qF "$password" $direct
then
    echo $info "LOGIN: INFO User $username logged in" >> log.txt
    echo "LOGIN: INFO User $username logged in"
    echo "please choose what you want to do"
    echo "1. dl N (how many picture that you want to download)"
    echo "2. att (to count how many tries login sucessful or not from the user)"
    read answer
        if [ `echo $answer | awk '{print $1}'` == $input1 ]
        then
                N=`echo $answer | awk '{print $2}'`
                directory=$info_date"_"$username
                
                if [[ ! -f "$directory.zip" ]] 
                then
                mkdir $directory
                function_starting
                
                else 
                unzip -P $password $directory.zip
                find_range
                function_starting
                fi
                
        elif [ "$answer" == "$input2" ]
	then
                # awk -v user="$username" ' BEGIN { print "success user login and failed " }
                # $5 == user { ++n } || $9 == user{ ++i }
                # END { print "success login:", n, "time(s)." "\nfailed login:", i, "times(s)." }' log.txt

                awk -v user="$username" 'BEGIN {count=0} 
                $6 == user || $10 == user {count++} 
                END {print "Counting:", count-1}' log.txt
                fi

else
	echo "Login Failed!"
    echo $info "LOGIN: ERROR Failed login attempt on user $username" >> log.txt
fi

