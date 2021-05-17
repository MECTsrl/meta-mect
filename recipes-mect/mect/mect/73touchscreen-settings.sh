# touchscreen HDMI
xinput set-prop 9                  'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 # 0 -1 1 1 0 0 0 0 1

# touchscreen VAR-SOM-MX6
xinput set-prop "EP0700M06"        'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 # 0 -1 1 1 0 0 0 0 1

# touchscreen DART-MX6
xinput set-prop "EP07110M09"       'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 # 0 -1 1 1 0 0 0 0 1

# touchscreen HDMI armadio ILITEK ILITEK-TP
xinput set-prop "ILITEK ILITEK-TP" 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 # 0 -1 1 1 0 0 0 0 1

# touchscreen DART-MX6 MECT ILITEK Multi-Touch-V3000
xinput set-prop "ILITEK Multi-Touch-V3000" 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1 # 0 -1 1 1 0 0 0 0 1

echo "Touch Rotation Completed"
