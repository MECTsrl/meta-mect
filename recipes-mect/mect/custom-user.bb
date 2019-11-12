SUMMARY = "admin + user"
SECTION = "USR"
LICENSE = "CLOSED"

inherit useradd

SRC_URI += " \
	file://authorized_keys \ 
	file://.profile \
	file://shadow \
	file://session \
	file://group \
	"

S = "${WORKDIR}/*"

PASSWORD ?= ""

USERADD_PACKAGES = "${PN}"

GROUPADD_PARAM_${PN} = "-g 1000 username"

USERADD_PARAM_${PN} = "-u 1000 -d /home/username -r -N -s /bin/bash -p "$6$0wFtZ/yp/u7/$x97VQ4SmHnucPUhXxiEDTQc9lQb8PaanVfkYf5k6pk0CvUpHI1uk9NMBZV7R5l1xndpM.2dD./lsPu9FGbaTE1" username"
USERADD_PARAM_${PN} = "-g username username"


do_install_append () {

    install -d -m 755 	${D}/home/username
    install -d -m 755 	${D}/home/username/.ssh/
    install -d -m 755 	${D}/home/username/.matchbox/
    install -d 	      	${D}${sysconfdir}/
    install -d 	      	${D}/local/data/store
    install -d 		${D}/local/data/alarms


    install -m 0600    ${WORKDIR}/authorized_keys	${D}/home/username/.ssh/
    install -m 0755    ${WORKDIR}/.profile		${D}/home/username/
    install -m 0755    ${WORKDIR}/session		${D}/home/username/.matchbox/


    # users
    chown -R username ${D}/home/username
    chown -R username ${D}/home/username/.ssh/authorized_keys
    chown -R username ${D}/local/data/store
    chown -R username ${D}/local/data/alarms
    

    # groups
    chgrp -R username ${D}/home/username
    chgrp -R username ${D}/home/username/.ssh/authorized_keys
    chgrp -R username ${D}/local/data/store
    chgrp -R username ${D}/local/data/alarms

    install -m 0755    ${WORKDIR}/shadow	   	${D}${sysconfdir}/
    install -m 0755    ${WORKDIR}/group		   	${D}${sysconfdir}/
}

FILES_${PN} = "/home/username/ \
	       /home/username/.ssh/ \
	       ${sysconfdir}/shadow \
	       ${sysconfdir}/group \
	       /home/username/.matchbox/session \
	       /local/data/alarms \
 	       /local/data/store \
	      "
#ALLOW_EMPTY_${PN} = "1"
