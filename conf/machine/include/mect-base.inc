MACHINE_FEATURES += " pci bluetooth touchscreen wifi"

# UBIFS for Variscite 0.5GB NAND flash
# erase block size of 128KiB
export MKUBIFS_ARGS_128kbpeb = " -m 2048 -e 124KiB -c 3965 "
export UBINIZE_ARGS_128kbpeb = " -m 2048 -p 128KiB -s 2048 "

# erase block size of 256KiB
export MKUBIFS_ARGS_256kbpeb = " -m 4096 -e 248KiB -c 2000 "
export UBINIZE_ARGS_256kbpeb = " -m 4096 -p 256KiB -s 4096 "

# UBIFS for Variscite 1GB NAND flash
# erase block size of 128KiB
#MKUBIFS_ARGS = " -m 2048 -e 124KiB -c 7855 "
#UBINIZE_ARGS = " -m 2048 -p 128KiB -s 2048 "

# erase block size of 512KiB
#MKUBIFS_ARGS = " -m 4096 -e 504KiB -c 2000 "
#UBINIZE_ARGS = " -m 4096 -p 512KiB -s 4096 "

MULTIUBI_BUILD ?= "128kbpeb 256kbpeb"

UBI_VOLNAME  = "rootfs"

# Variscite BSP default providers
# PREFERRED_PROVIDER_virtual/kernel = "linux-variscite"
# enable for preempt-rt 
PREFERRED_PROVIDER_virtual/kernel = "linux-variscite-rt"
# PREFERRED_PROVIDER_virtual/kernel = "linux-fslc-imx-rt"
# PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-rt"

PREFERRED_VERSION_linux-variscite = "4.14.78"

PREFERRED_PROVIDER_u-boot = "u-boot-variscite"
PREFERRED_PROVIDER_virtual/bootloader = "u-boot-variscite"
PREFERRED_PROVIDER_u-boot-fw-utils = "u-boot-fw-utils-tp"

PREFERRED_PROVIDER_wpa-supplicant-cli = "wpa-supplicant"
PREFERRED_PROVIDER_wpa-supplicant-passphrase = "wpa-supplicant"
PREFERRED_PROVIDER_wpa-supplicant = "wpa-supplicant"

PREFERRED_RPROVIDER_ptpd = "ptpd"
PREFERRED_RPROVIDER_ptpd-dev = "ptpd"

# MACHINE_GSTREAMER_1_0_PLUGIN ?= "gstreamer1.0-plugins-imx-meta"
# PREFERRED_VERSION_libdrm ?= "2.4.91.imx"

MACHINE_EXTRA_RDEPENDS += " \
			   crda \
			   bridge-utils \
			   connman \
			   hostapd \
			   imx-kobs \
			   iw \
			   kernel-modules \
			   packagegroup-tools-bluetooth \
			   pm-utils \
			   rng-tools \
			   hdparm \
			   gptfdisk \
			   tslib-calibrate \
			   tslib-tests \
			   u-boot-fw-utils-tp \
			   u-boot-splash \
			   wpa-supplicant \
			   ${@bb.utils.contains('DISTRO_FEATURES', 'x11', "x11vnc", "", d)} \
			   "

# Packages added to all images (including core-image-minimal)
IMAGE_INSTALL_append = "fsl-rc-local \
	    tcf-agent \
	    openssh-sftp-server \
	    openvpn \
	    openjpeg \
	    freerdp \
	    rsync \
	    sqlite3 \
	    minicom \
	    qtbase \
	    qtserialbus \
	    qtvirtualkeyboard \
	    qtcharts \
	    qtdeclarative \
	    qtquickcontrols qtquickcontrols-qmlplugins \
	    qtquickcontrols2 qtquickcontrols2-qmlplugins \
	    x11vnc \
 	    bmap-tools \  
	    mect \ 
	    custom-user \
	    u-boot-splash-mect \
	    psplash \ 
	    rt-tests \
	    hwlatdetect \
	    tzdata \
	    devmem2 \
	    libgpiod \
	    xf86-video-imx-vivante \
	"

BBMASK += "/meta-variscite-fslc/recipes-core/psplash/psplash_git.bbappend \
	   /meta-variscite-fslc/recipes-fsl/packagegroup/packagegroup-qt5-demos \
	   /meta-variscite-fslc/recipes-fsl/packagegroup/packagegroup-qt5-3d \
	   /meta-variscite-fslc/recipes-fsl/packagegroup/packagegroup-qt5-webkit \
	   "

PREFERRED_VERSION_libgpiod = "1.2"

PACKAGECONFIG_remove_pn-qtbase = "qtwebkit"
PACKAGECONFIG_remove_pn-qttools = "qtwebkit"
PACKAGECONFIG_remove_pn-qtquick1 = "qtwebkit"
PACKAGECONFIG_append_pn-qtbase = " sql-sqlite -nomake examples"

TOOLCHAIN_TARGET_TASK_append = " qtvirtualkeyboard"
TOOLCHAIN_TARGET_TASK_append = " qtvirtualkeyboard-dev"

# set image root password
#EXTRA_USERS_PARAMS = "useradd -p "$6$0wFtZ/yp/u7/$x97VQ4SmHnucPUhXxiEDTQc9lQb8PaanVfkYf5k6pk0CvUpHI1uk9NMBZV7R5l1xndpM.2dD./lsPu9FGbaTE1" username; \
#		      usermod -P "$6$GB7LN/WkWRzOMrLQ$JdIbOH9jMhq/Zd8VYPHBRwcuyw6Wt9IOER848Pb22eL.gUsgTS23SexvSBNzIdH5pNhf1Leh8QNoa7aVkoaaS1" root;"

EXTRA_IMAGE_FEATURES = " \
    debug-tweaks \
    tools-debug \
    eclipse-debug \
    "
IMAGE_FSTYPES += " wic wic.bmap"

BBMASK_prepend = "fsl-image-mfgtool-initramfs "
BBMASK += "meta-freescale/dynamic-layers/browser-layer/recipes-browser/chromium"

WKS_FILE = "imx-uboot-spl-bootpart.wks"
IMAGE_FSTYPES += "tar.gz multiubi"

# do multiubi last
IMAGE_TYPEDEP_multiubi += "${IMAGE_FSTYPES}"
IMAGE_TYPEDEP_multiubi_remove = "multiubi"

xorg_nohw_accel() {
  sed -i '7i    Option      "NoAccel" "true"' ${IMAGE_ROOTFS}/etc/X11/xorg.conf
}

set_ntp_server() {

  sed -i '/NTPSERVERS=""/d' 			${IMAGE_ROOTFS}/etc/default/ntpdate
  sed -i '3i    NTPSERVERS="tempo.ien.it"' 	${IMAGE_ROOTFS}/etc/default/ntpdate
  sed -i '/UPDATE_HWCLOCK="no"/d' 		${IMAGE_ROOTFS}/etc/default/ntpdate
  sed -i '6i 	UPDATE_HWCLOCK="yes"' 		${IMAGE_ROOTFS}/etc/default/ntpdate
}

set_timezone() {

   sed -i '1i Europe/Paris'  		 	 ${IMAGE_ROOTFS}/etc/timezone   
   sed -i '/Universal/d' 		 	 ${IMAGE_ROOTFS}/etc/timezone 
   rm  ${IMAGE_ROOTFS}/etc/localtime
   ln -s /usr/share/zoneinfo/Europe/Paris 	 ${IMAGE_ROOTFS}/etc/localtime
}

add_username_sudoers() {

sed -i '88i %sudo	ALL=(ALL) NOPASSWD: ALL'  	${IMAGE_ROOTFS}/etc/sudoers   
}

set_smily_ls_script() {

ln -sf /bin/ls.sh 		  ${IMAGE_ROOTFS}/bin/ls 
}

ROOTFS_POSTPROCESS_COMMAND += "xorg_nohw_accel; \
			       set_ntp_server; \
			       set_timezone; \
			       add_username_sudoers; \
			       set_smily_ls_script;"

multiubi_mkfs_prepend() {
	# Update PEB size in fw_env.config (u-boot-fw-utils)
	if [ -f ${IMAGE_ROOTFS}${sysconfdir}/fw_env.config ]; then
		# Get PEB from UBINIZE_ARGS
		MTD_ERASESIZE=`echo "$2" | tr ' =' '\n' | awk '/^-p$|^--peb-size$/{getline; print}'`
		# Convert to bytes (decimal)
		MTD_ERASESIZE=`echo $MTD_ERASESIZE | sed 's/MiB/ * 1024 KiB/;s/KiB/ * 1024/' | bc`
		# Convert to hexadecimal
		MTD_ERASESIZE=`printf 0x%x $MTD_ERASESIZE`

		awk -i inplace -v n=4 -v ERASESIZE="${MTD_ERASESIZE}" '/\/dev\/mtd/{$(n)=ERASESIZE}1' ${IMAGE_ROOTFS}${sysconfdir}/fw_env.config
	fi
}
