#!/bin/bash

# author yuxuan@ankr.com
# time 2021-07-19 16:35:31

appprodip1=192.168.6.4
appprodip2=192.168.6.5
appprodip3=192.168.6.6
grafanaip=192.168.9.1

now_time=$(date +%F-%T)

# reload local nginx -> update stage certificates
/usr/sbin/nginx -t &> /dev/null
if [ $? -eq 0 ]; then
   /usr/sbin/nginx -s reload
else
   exit 1
fi

# update app prod certificates
for ip in $appprodip1 $appprodip2 $appprodip3
do
    # echo $ip
    ssh ${ip} rm -f /tmp/_.ankr.com*
    scp  /root/lego/data/certificates/*  root@${ip}:/tmp &> /dev/null

    ssh ${ip} ls /etc/nginx/cert/certbackup &> /dev/null
    if [ $? -ne 0 ]; then
       ssh ${ip} mkdir -p /etc/nginx/cert/certbackup &> /dev/null
    fi

    #backup old certificates
    ssh ${ip} mv /etc/nginx/cert/_.ankr.com.crt /etc/nginx/cert/certbackup/_.ankr.com.crt-${now_time}  &> /dev/null
    ssh ${ip} mv /etc/nginx/cert/_.ankr.com.key /etc/nginx/cert/certbackup/_.ankr.com.key-${now_time}  &> /dev/null

    # update certificates
    ssh ${ip} mv /tmp/_.ankr.com.crt  /etc/nginx/cert/_.ankr.com.crt
    ssh ${ip} mv /tmp/_.ankr.com.key  /etc/nginx/cert/_.ankr.com.key

    ssh ${ip} rm -f /tmp/_.ankr.com*

    # test nginx and reload
    ssh ${ip} /usr/sbin/nginx -t &> /dev/null
    if [ $? -eq 0 ]; then
       ssh ${ip} /usr/sbin/nginx -s reload
    fi
done

apistageip=113.142.1.139
apiprodip=113.142.1.141

for ip in $apistageip $apiprodip
do
    if [[ $ip = $apistageip ]];then
            namespace="kube-system"
    else
            namespace="apiservice"
    fi

    ssh ${ip} rm -f /tmp/_.ankr.com*
    scp  /root/lego/data/certificates/*  root@${ip}:/tmp &> /dev/null
    ssh  ${ip} "cd /tmp  && mv _.ankr.com.crt tls.crt &&  mv _.ankr.com.key tls.key"

    if [[ $ip = $apistageip ]];then
        # update stage
        ssh  ${ip} "cd /tmp &&  /usr/bin/kubectl create secret generic tls-dot-ankr-dot-com  -n ${namespace}  --save-config --dry-run=client  --from-file=./tls.key --from-file=./tls.crt -o yaml | /usr/bin/kubectl apply -f -"
    elif [[ $ip = $apiprodip ]];then
        # update prod hk
        ssh  ${ip} "cd /tmp &&  /usr/bin/kubectl create secret generic tls-dot-ankr-dot-com  -n ${namespace}  --save-config --dry-run=client  --from-file=./tls.key --from-file=./tls.crt -o yaml | /usr/bin/kubectl apply -f -"
        # update prod la
        ssh  ${ip} "cd /tmp &&  /usr/bin/kubectl create secret generic tls-dot-ankr-dot-com  -n ${namespace} --kubeconfig=/root/lakubeconfig/config  --save-config --dry-run=client  --from-file=./tls.key --from-file=./tls.crt -o yaml | /usr/bin/kubectl --kubeconfig=/root/lakubeconfig/config apply -f -"
    else
        echo "never happens"
    fi

    ssh ${ip} "rm -f /tmp/_.ankr.com* && rm -f /tmp/tls.*"
done


# update grafana certificates, but why not use nginx to parse ssl??
ssh ${grafanaip} rm -f /tmp/_.ankr.com*
scp  /root/lego/data/certificates/*  root@${grafanaip}:/tmp &> /dev/null
ssh ${grafanaip} ls /opt/cert/certbackup &> /dev/null
if [ $? -ne 0 ]; then
   ssh ${grafanaip} mkdir -p /opt/cert/certbackup &> /dev/null
fi
# backup old certificates
ssh ${grafanaip} mv /opt/cert/monitor.ankr.com.crt /opt/cert/certbackup/monitor.ankr.com.crt-${now_time}  &> /dev/null
ssh ${grafanaip} mv /opt/cert/monitor.ankr.com.key /opt/cert/certbackup/monitor.ankr.com.key-${now_time}  &> /dev/null
# update certificates
ssh ${grafanaip} mv /tmp/_.ankr.com.crt  /opt/cert/monitor.ankr.com.crt
ssh ${grafanaip} mv /tmp/_.ankr.com.key  /opt/cert/monitor.ankr.com.key
# clean
ssh ${grafanaip} rm -f /tmp/_.ankr.com*
# reload server
ssh ${grafanaip} systemctl restart grafana-server