# Append path for freescale layer to include bsp xorg.conf 
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://xorg.conf "
