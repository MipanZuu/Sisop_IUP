#!/bin/bash
logloc=`readlink -f ${BASH_SOURCE}`

DIR="$HOME/log"
cd $HOME

if [ ! -d $DIR ]; then
    mkdir $DIR
fi

logname=$DIR/$(date +"metrics_%Y%m%d%H%M%S").log

freem=`free -m | awk 'BEGIN{ORS=","}1 {if(NR != 1){for (i=2; i<=NF;i++) print $i}}'`
dush=`du -sh | awk '{print $1}'`
echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > $logname
echo "$freem$DIR","$dush" >> $logname
(crontab -l; echo "* * * * * bash $logloc") | awk '!x[$0]++'|crontab
