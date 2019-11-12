# display HDMI 10.1" 1280x800 su DART-MX6
xrandr -o right # left
xrandr --dpi 149 # --dpi 96
xrandr --newmode "1280x800_60.00"  83.46  1280 1344 1480 1680  800 801 804 828 -HSync +Vsync
xrandr --addmode "DISP4 BG" "1280x800_60.00"
xrandr --output "DISP4 BG" --mode "1280x800_60.00"

