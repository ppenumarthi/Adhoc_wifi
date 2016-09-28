#/bin/bash

declare CH=1;
declare ESS="RPIwireless";
declare IP=11;

until [ -z "$1" ]
  do
  case "$1" in
       -c | --channel)
	    CH=$2;
	    echo "Channel is set to $2";
            shift 2;
            ;;
       -e | --essid)
	    ESS=$2;
	    echo "ESSID is set to $2";
            shift 2;
            ;;
       -i | --ipaddr)
	    IP=$2;
	    echo "Last digits of IP are set to $2";
            shift 2;
            ;;
       *)
            echo "Unknown option $1"
            break ;
            # unknown option
            ;;

  esac
  done
      

declare start="192.168.1."
#declare ip_addr;
#$ip_addr=$start$IP
echo "ip_addr is $ip_addr"

ifconfig wlan0 down

service avahi-daemon stop
service network-manager stop
pkill wpa_supplicant
pkill dhclient

iwconfig wlan0 channel $CH essid $ESS mode ad-hoc

ifconfig wlan0 up

ifconfig wlan0 $start$IP netmask 255.255.255.0
