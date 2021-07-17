#!/bin/bash
# auth:feixiang1209
# time:2020-02-14 13:11
# used to monitor sms-code
set -e
sshua_file_log='/root/logs/sshua_api.log'
xijin_loan_file_log='/root/logs/xijin_loan_api.log'
function getDate(){
        local ago_day=$1
        if [ "${#1}" = 0 ];then
                date
        else
                date -d  "-$ago_day days"
        fi
}
function monitor(){
        local file="$1"
        local test=${file##*\/}
        echo -e "\e[33mlooking at the $test ...... \e[0m"
        if [ ${#day} = 1 ];then
                local day=`printf "%02d" ${day}`
        fi
        local res=$(cat "$file" |awk  '$4 > "['"$day"'/'"$month"'/'"$year"':00:00:00" && $4 < "['"$day"'/'"$month"'/'"$year"':23:59:59" && $7 ~ "send-sms" {print $1}'|sort -nr| uniq -c|sort -k1 -nr|head -30)        if [ ${#res} != 0 ];then                echo "$res" | while read line                        do                                echo $line                        done
                echo
        else
                echo nothing
        fi
}
final_date=`getDate $1`
year=`echo "$final_date" | awk '{print $NF}'`
month=`echo "$final_date" | awk '{print $2}'`
day=`echo "$final_date" | awk '{print $3}'`
monitor $sshua_file_log
monitor $xijin_loan_file_log