#/bin/bash

#declare CH = 1;
#declare ESS = "RPIwireless";
#declare IP = 11;
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
       -ip | --ipaddr)
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
      
ifconfig wlan0 down
#Kill a set of processes defaulting to Infrastructure mode in Ubuntu
service avahi-daemon stop
service network-manager stop
pkill wpa_supplicant
pkill dhclient
#Set wifi antenna into Ad-hoc mode
iwconfig wlan0 channel $c essid $ESS mode ad-hoc
#Bring the wifi interface up
ifconfig wlan0 up
#set IP address on that wifi interface
ifconfig wlan0 192.168.1.$IP netmask 255.255.255.0
