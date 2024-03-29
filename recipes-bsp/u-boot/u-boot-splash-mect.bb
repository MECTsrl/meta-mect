SUMMARY = "Copy U-Boot's splash.bmp to rootfs"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"
SECTION = "bootloader"

SRC_URI = "file://splash.png"

S = "${WORKDIR}"

FILES_${PN} = "/boot/splash.png"

do_install () {
	install -d ${D}/boot
	install -m 644 splash.png ${D}/boot/splash.png
}
