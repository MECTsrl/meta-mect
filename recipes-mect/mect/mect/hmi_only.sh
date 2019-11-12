#!/bin/sh 

# from http://variwiki.com/index.php?title=Static_IP_Address
# root@var-som-mx6:~# connmanctl services
# *AO Wired                ethernet_f8dc7a1d41e3_cable
#     XT190205             wifi_780473fa0a1f_5854313930323035_managed_psk
# root@var-som-mx6:~# connmanctl config ethernet_f8dc7a1d41e3_cable --ipv4 manual 192.168.0.30 255.255.255.0 192.168.0.1
# root@var-som-mx6:~# connmanctl config ethernet_f8dc7a1d41e3_cable --nameservers 8.8.8.8 4.4.4.4
#

# from https://wiki.ubuntu.com/X/InputCoordinateTransformation

# from /etc/X11/xorg.conf

# Section "Device"
#    Identifier  "i.MX Accelerated Framebuffer Device"
#    Driver      "vivante"
#    Option      "fbdev"     "/dev/fb0"
#    Option      "vivante_fbdev" "/dev/fb0"
#    Option      "HWcursor"  "false"
#    Option      "NoAccel" "true"
# EndSection

#xrandr -o right # left
#xrandr --dpi 149 # --dpi 96

# display HDMI 10.1" 1280x800 su DART-MX6
#xrandr --newmode "1280x800_60.00"  83.46  1280 1344 1480 1680  800 801 804 828 -HSync +Vsync
#xrandr --addmode "DISP3 BG" "1280x800_60.00"
#xrandr --output "DISP3 BG" --mode "1280x800_60.00"

# touchscreen HDMI
#xinput set-prop 9                  'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 # 0 -1 1 1 0 0 0 0 1

# touchscreen VAR-SOM-MX6
#xinput set-prop "EP0700M06"        'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 # 0 -1 1 1 0 0 0 0 1

# touchscreen DART-MX6
#xinput set-prop "EP07110M09"       'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 # 0 -1 1 1 0 0 0 0 1

# touchscreen HDMI armadio ILITEK ILITEK-TP
#xinput set-prop "ILITEK ILITEK-TP" 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 # 0 -1 1 1 0 0 0 0 1

# touchscreen DART-MX6 MECT ILITEK Multi-Touch-V3000
#xinput set-prop 10                  'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 # 0 -1 1 1 0 0 0 0 1

# VNC
# x11vnc -forever &

# VPN
# if [ -f /home/root/hmi_only.ovpn ]; then
#    modprobe tun
#    openvpn /home/root/hmi_only.ovpn 2>&1 >/home/root/openvpn.log &
# fi

# ls hack for sMily
#rm /bin/ls
#cp -av /home/root/ls.sh /bin/ls

KEYBOARD_APPLET="keyboard"
START_APPLETS=showdesktop,windowselector
END_APPLETS=$KEYBOARD_APPLET,systray,startup-notify,notify                          
END_APPLETS=clock,$END_APPLETS                                                                       
matchbox-panel --start-applets $START_APPLETS --end-applets $END_APPLETS &

# applicazione
mkdir -p $HOME/logs
$HOME/hmi_only >$HOME/logs/hmi_only_$(date -Is).log 2>&1 &

PROCESS="hmi_only"
PROCANDARGS=$*

while true
do
    RESULT=`pgrep -c ${PROCESS}`

    if [ ${RESULT} -eq 1 ] && [ ${PROCESS} = hmi_only ]; then
	matchbox-desktop 	
        PROCESS="matchbox-desktop"  
    elif [ ${RESULT} -eq 0 ] && [ ${PROCESS} == "matchbox-desktop" ]; then     
	$HOME/hmi_only >$HOME/logs/hmi_only_$(date -Is).log 2>&1 &
	PROCESS="hmi_only"
    fi
done   
