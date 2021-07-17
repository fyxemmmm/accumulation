#!/bin/bash
#Author:feixiang1209
#init the centos7
#--- source file instead of bash it ---#
ssh_port=22
###   stop firewall  ###
systemctl stop firewalld &> /dev/null
systemctl disable firewalld &> /dev/null
# Check If You Were Root ?
function checkAdmin(){
  if [ `id -u` -ne 0 ];then
    echo "please switch to root then doing next." && exit
  fi
}
## Init The System Staring Environment
function changeLoginLimit(){
  local line is_empty
  if [ -f "/etc/gdm/custom.conf" ];then
    line=`awk '/daemon/{print NR}' /etc/gdm/custom.conf`
    is_empty=`sed -n "$[line+1]p" /etc/gdm/custom.conf`
    if [ ! -n "$is_empty" ];then
      sed -i '/daemon/aAutomaticLoginEnable=true\nAutomaticLogin=root' /etc/gdm/custom.conf
    fi
  fi
}
### Close Selinux
function closeSelinux(){
  sed -ir '/^SELINUX=/s/SE.*/SELINUX=disabled/' /etc/selinux/config
}
#### Set Profile To Be Convenient Operating
function setProfile(){
  cd /root || return
  profile=`sed -nr '/cdnet/p' .bashrc`
  if [ ! -n "$profile" ];then
    echo "alias cdnet='cd /etc/sysconfig/network-scripts/'" >> .bashrc
  fi
  source .bashrc
}
##### Change SSH Port In Order To Escape From Attack
function changeSSHport(){
  cd /etc/ssh && sed -ir "/.*Port\>/s/.*/Port ${ssh_port}/" sshd_config
  # may be it won't make,because of selinux
  systemctl restart sshd  &> /dev/null
}
###### Set NetWork
function setNetWork(){
  local filename ip netmask gateway dns
  cd /etc/sysconfig/network-scripts || return
  read -p "please input the network filename(eg:ifcfg-ens33): " filename
  if [ ! -f "$filename" ];then
    echo "file not exist!" && return
  fi
  read -p "please input the ip(eg:192.168.30.11): " ip
  read -p "please input the netmask(eg:255.255.255.0): " netmask
  read -p "please input the gateway(eg:192.168.1.1): " gateway
  read -p "please input the dns(eg:8.8.8.8): " dns
  sed -i '/BOOTPROTO/s/.*/BOOTPROTO=static/' $filename
  sed -i '/ONBOOT=/s/.*/ONBOOT=yes/' $filename

  if [ -v `sed -nr '/IPADDR/p' $filename` ];then
    echo "IPADDR=$ip" >> $filename
  fi
        if [ -v `sed -nr '/NETMASK/p' $filename` ];then
                echo "NETMASK=$netmask" >> $filename
        fi
        if [ -v `sed -nr '/GATEWAY/p' $filename` ];then
                echo "GATEWAY=$gateway" >> $filename
        fi
        if [ -v `sed -nr '/DNS/p' $filename` ];then
                echo "DNS1=$dns" >> $filename
        fi
   systemctl restart network
  return
}
PS3="please make your choice: "
setIp="I want to init the network ip by some options"
setOthers="I want to init other settings automaticlly"
select menu in "$setIp" "$setOthers";do
  case $REPLY in
    1)
      setNetWork  # set ip addr
      break
      ;;
    2)
      checkAdmin
      changeLoginLimit
      closeSelinux
      setProfile
      changeSSHport
      break
      ;;
  esac
done
exit 0