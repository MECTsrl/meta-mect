SUMMARY = "Recipe Mect per aggiungere file e cartelle"
DESCRIPTION = "Aggiungo serial.conf, rootfs_version, authorized_keys, ,ls.sh e le cartelle local/data/ store e alarms "
LICENSE = "CLOSED"

SRC_URI += " \
     	file://rootfs_version \
     	file://serial.conf \
	file://authorized_keys \		
	file://ls.sh  \
	file://hmi_only.sh \
	file://connman.desktop \
	file://hmi_only.desktop \
	file://70display-settings.sh \
	file://73touchscreen-settings.sh \
	file://71vnc-start.sh \
	file://echos.sh \
	file://install_yocto_emmc.sh \
	file://ovpn-mect-up.sh \
	file://ovpn-mect-down.sh \
	file://74displayErrorReboot.sh \
	"

PACKAGE_ARCH = "${MACHINE_ARCH}"

S = "${WORKDIR}/*"

do_install () {

     install -d 	${D}/home/root/.ssh/
     install -d 	${D}${base_bindir}/
     install -d 	${D}${sysconfdir}/
     install -d 	${D}${sysconfdir}/default/
     install -d 	${D}${sysconfdir}/default/
     install -d 	${D}${datadir}/applications/
     install -d 	${D}${sysconfdir}/X11/Xsession.d/
     install -d 	${D}${sbindir}/

     install -m 0755    ${WORKDIR}/rootfs_version       	${D}/
     install -m 0600    ${WORKDIR}/authorized_keys		${D}/home/root/.ssh/
     install -m 0755    ${WORKDIR}/serial.conf	   		${D}${sysconfdir}/
     install -m 0755    ${WORKDIR}/ls.sh			${D}${base_bindir}/
     install -m 0755    ${WORKDIR}/hmi_only.sh	   		${D}${sysconfdir}/default/
     install -m 0755    ${WORKDIR}/connman.desktop	   	${D}${datadir}/applications/
     install -m 0755    ${WORKDIR}/hmi_only.desktop	   	${D}${datadir}/applications/
     install -m 0755    ${WORKDIR}/70display-settings.sh   	${D}${sysconfdir}/X11/Xsession.d/
     install -m 0755    ${WORKDIR}/73touchscreen-settings.sh    ${D}${sysconfdir}/X11/Xsession.d/
     install -m 0755    ${WORKDIR}/71vnc-start.sh   		${D}${sysconfdir}/X11/Xsession.d/
     install -m 0755    ${WORKDIR}/echos.sh	   		${D}${base_bindir}/
     install -m 0755    ${WORKDIR}/install_yocto_emmc.sh   	${D}${base_bindir}/
     install -m 0755    ${WORKDIR}/ovpn-mect-up.sh	   	${D}${sbindir}/
     install -m 0755    ${WORKDIR}/ovpn-mect-down.sh	   	${D}${sbindir}/
     install -m 0755    ${WORKDIR}/74displayErrorReboot.sh   	${D}${sysconfdir}/X11/Xsession.d/
}

PACKAGES = "${PN}"
RDEPENDS_${PN} += "bash"




FILES_${PN} += "${sysconfdir}/serial.conf \
	        /rootfs_version \
		/home/root/.ssh/authorized_keys \		
		${base_bindir}/ls.sh \
		${sysconfdir}/default/hmi_only.sh \
		${datadir}/applications/connman.desktop \
		${datadir}/applications/hmi_only.desktop \
		${sysconfdir}/X11/Xsession.d/70display-settings.sh \
		${sysconfdir}/X11/Xsession.d/73touchscreen-settings.sh \
		${sysconfdir}/X11/Xsession.d/71vnc-start.sh \
		${base_bindir}/echos.sh \
		${base_bindir}/install_yocto_emmc.sh  \
		${sbindir}/ovpn-mect-up.sh \
		${sbindir}/ovpn-mect-down.sh \
		${sysconfdir}/X11/Xsession.d/74displayErrorReboot.sh \
		"
