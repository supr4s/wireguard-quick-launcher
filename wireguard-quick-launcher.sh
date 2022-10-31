#!/bin/bash
#Check if the script is launch with root permissions
if [ "$EUID" -ne 0 ]
  then echo -e "\e[91mPlease execute this script with root privileges"
  exit
fi
#Retrieve WireGuard interface
WG_INTERFACE=$(ls /etc/wireguard/*.conf |grep -oP '(?<=[/])\w+(?=[.])')
if [[ "$1" == "UP" ]] ; then
	echo "Wireguard is launching";
	echo "";
	/usr/bin/wg-quick up $WG_INTERFACE > /dev/null 2>&1;
	MYIP=$(curl --silent https://ipinfo.io/ip ; echo)
	echo "Current public IP address : $MYIP";
	echo "";
	echo "Wireguard launched successfully";

elif [[ "$1" == "DOWN" ]] ; then
	echo 'Wireguard is closing';
	echo "";
	/usr/bin/wg-quick down $WG_INTERFACE > /dev/null 2>&1;
    MYIP=$(curl --silent https://ipinfo.io/ip ; echo)
    echo "Current public IP address : $MYIP" ;
    echo "";
    echo "Wireguard closed successfully";

else
	echo 'Bad option : bash wireguard.sh UP/DOWN'
fi
