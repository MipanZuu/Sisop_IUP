#!/bin/bash

if [ -z "$1" ]
then
	echo "missing argument, please insert." 
	exit
else

logloc=${1}

# First Task
rm -r -f forensic_log_website_daffainfo_log
mkdir forensic_log_website_daffainfo_log

# Second Task
reqeachhour=`awk 'BEGIN{FS="\":\""} {if (NR!=1) {print substr($2, 1, length($2)-6)}}' $logloc | sort | uniq -c | awk '{print $1}'| sed 's/ /\n/g'`
numberofhour=`echo $reqeachhour | awk '{print NF}'`
sumhour=`echo $reqeachhour | awk '{for(i=1;i<=NF;i++) t+=$i; print t}'`
rata_rata=`expr $sumhour / $numberofhour`
echo "Rata-rata serangan adalah sebanyak $rata_rata requests per jam" > forensic_log_website_daffainfo_log/ratarata.txt

# Third Task
mostcommonip=`awk 'BEGIN{FS="\""} {if (NR!=1) {print $2}}' $logloc | sort | uniq -c | sort -snrk1,1 | awk '{if (NR==1) {print}}'`
ip_address=`echo $mostcommonip | awk '{print $2}'`
jumlah_request=`echo $mostcommonip | awk '{print $1}'`
echo "IP yang paling banyak mengakses server adalah: $ip_address sebanyak $jumlah_request requests" > forensic_log_website_daffainfo_log/result.txt
echo "" >> forensic_log_website_daffainfo_log/result.txt

# Fourth Task
jumlah_req_curl=`awk '/curl/ {if (NR!=1) {print}}' $logloc | awk 'END {print NR}'`
echo "Ada $jumlah_req_curl requests yang menggunakan curl sebagai user-agent" >> forensic_log_website_daffainfo_log/result.txt
echo "" >> forensic_log_website_daffainfo_log/result.txt

# Fifth Task
IP_Address_Jam_2_pagi=`awk -F'":"|"' '/22\/Jan\/2022:02/{if (NR!=1) {print $2}}' $logloc`
jumlah_req_curl=`echo "$IP_Address_Jam_2_pagi" | awk 'END {print NR}'`
echo "Ada $jumlah_req_curl requests yang menggunakan curl sebagai user-agent" >> forensic_log_website_daffainfo_log/result.txt
echo "" >> forensic_log_website_daffainfo_log/result.txt
echo "$IP_Address_Jam_2_pagi" >> forensic_log_website_daffainfo_log/result.txt
fi

