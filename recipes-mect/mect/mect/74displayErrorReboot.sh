#!/bin/sh

if( dmesg | grep "timeout when waiting for flip irq" )
then 
	echo " [DISPLAY ERROR]: timeout when waiting for flip irq ---> Rebooting Needed"

		if [ -f /home/username/irqErrorLog.txt ]
		then
			echo "[DISPLAY ERROR]: timeout when waiting for flip irq ---> It happened again!!"
		else 
			sudo echo "[DISPLAY ERROR]: timeout when waiting for flip irq" > /home/username/irqErrorLog.txt
			sudo reboot
		fi
else
	
	echo "Boot Completed!"
	sudo rm /home/username/irqErrorLog.txt
fi
