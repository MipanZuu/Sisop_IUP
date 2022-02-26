#!/bin/bash
info=$(date +"%m/%d/%y %H:%M:%S")
direct="users/user.txt"
fold=`dirname $direct`
flag=1

echo "create a new username and password"
echo "for password there is some criteria:"
echo "1. Password must atleast be 8 character long"
echo "2. Password must have an uppercase and lowercase character"
echo "3. Password must be Alphanumeric"
echo "4. Password cant be the same as username"


echo "Please enter your username: "
read username;

while [ $flag -eq 1 ]
do
echo "Enter your password: "
read -s password;

if [ ${#password} -lt 8 ]; then
	echo "Password must atleast be 8 character long"
elif ! [[ "$password" =~ [[:upper:]] ]] || ! [[ "$password" =~ [[:lower:]] ]]; then
	echo "Password must have an uppercase and lowercase character"
elif ! [[ "$password" =~ ^[[:alnum:]]+$ ]]; then
	echo "Password must be alphanumeric"
elif [[ "$password" == "$username" ]]; then
	echo "Password cant be the same as username"
else
	flag=0
fi
done

if [[ -f $direct ]]; then
	if grep -qF "$username" $direct; then
		echo "username already taken"
		echo $info "REGISTER: ERROR User already exists" >> log.txt
	else
		echo "REGISTER: INFO User $username registered successfully"
		echo $info "REGISTER: INFO User $username registered successfully" >> log.txt
		echo $username   $password >> $direct
	fi
else
        echo "REGISTER: INFO User $username registered successfully"
        echo $info "REGISTER: INFO User $username registered successfully" >> log.txt
        mkdir -p $fold && echo $username   $password >> $direct
fi
exit
