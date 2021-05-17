FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://tp2101-01-a.dtsi;subdir=git/arch/${ARCH}/boot/dts\
	    file://tp2101-01-a-cdisplay.dtsi;subdir=git/arch/${ARCH}/boot/dts\
	    https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.78-rt47.patch.gz;name=rt-patch \
	    file://tp2101-01-a.dtb;subdir=git/arch/${ARCH}/boot/dts\
	    file://logo_linux_clut224.ppm \
	    file://ili251x.patch \
	"

#SRC_URI[rt-patch.md5sum] = "6e86714997e190a45fb5b9c951d2c179"
SRC_URI[rt-patch.sha256sum] = "ee732338e0a8d1647621e3780ad48c602220aeabdd2d6e475e68385b21ba0314"

#;subdir= ${S}/arch/arm/boot/dts

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_configure() {
	
    install -d ${B}/arch/${ARCH}/boot/dts/
    #install -d ${B}/arch/arm/boot/dts/

    #install -m 0755 ${WORKDIR}/tp2101-01-a.dtsi 		${S}/arch/arm/boot/dts/
    #install -m 0755 ${WORKDIR}/tp2101-01-a-cdisplay.dtsi 	${S}/arch/arm/boot/dts/
    cp ${THISDIR}/${PN}/tp2101-01-a.dtb				${B}/arch/${ARCH}/boot/dts/

    if [ -e ${WORKDIR}/logo_linux_clut224.ppm ]; then
        install -m 0644 ${WORKDIR}/logo_linux_clut224.ppm ${S}/drivers/video/logo/logo_linux_clut224.ppm
        kernel_conf_variable LOGO y
        kernel_conf_variable LOGO_LINUX_CLUT224 y
        kernel_conf_variable LOGO_VARISCITE_CLUT224 n
    fi
}

COMPATIBLE_MACHINE = "tp2101-01-a"  

