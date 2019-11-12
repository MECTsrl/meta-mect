FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://xserver-nodm.conf.in \
	    file://xserver-nodm.service.in \
		"
