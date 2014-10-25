#!/bin/bash

# Copyright(C) 2014, Stamus Networks
# All rights reserved
# Part of Debian SELKS scripts
# Written by Peter Manev <pmanev@stamus-networks.com>
#
# Please run on Debian
#
# This script comes with ABSOLUTELY NO WARRANTY!
# 


interface=$1
ARGS=1         # The script requires 1 argument.


echo -e "\n The supplied network interface is :  ${interface} \n";

  if [ $# -ne "$ARGS" ];
    then
      echo -e "\n USAGE: `basename $0` -> the script requires 1 argument - a network interface!"
      echo -e "\n Please supply a network interface. Ex - ./disable-interface-offloading.sh eth0 \n"
      exit 1;
  fi

/sbin/ethtool -K ${interface} tso off
/sbin/ethtool -K ${interface} gro off
/sbin/ethtool -K ${interface} lro off
/sbin/ethtool -K ${interface} gso off
/sbin/ethtool -K ${interface} rx off
/sbin/ethtool -K ${interface} tx off
/sbin/ethtool -K ${interface} sg off
/sbin/ethtool -K ${interface} rxvlan off
/sbin/ethtool -K ${interface} txvlan off
/sbin/ethtool -N ${interface} rx-flow-hash udp4 sdfn
/sbin/ethtool -N ${interface} rx-flow-hash udp6 sdfn
/sbin/ethtool -n ${interface} rx-flow-hash udp6
/sbin/ethtool -n ${interface} rx-flow-hash udp4
/sbin/ethtool -C ${interface} rx-usecs 1 rx-frames 0
/sbin/ethtool -C ${interface} adaptive-rx off
/sbin/ethtool -G ${interface} rx 4096

echo -e "###################################"
echo -e "# CURRENT STATUS - NIC OFFLOADING #"
echo -e "###################################"
/sbin/ethtool -k ${interface} 
echo -e "######################################"
echo -e "# CURRENT STATUS - NIC RINGS BUFFERS #"
echo -e "######################################"
/sbin/ethtool -g ${interface} 
