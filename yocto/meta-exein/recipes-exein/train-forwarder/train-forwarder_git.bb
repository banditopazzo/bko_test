SUMMARY = "The application collects training data from the Exein kernel module (LKM) and sends UDP packets to a server"
DESCRIPTION = " \
The application collects training data from the Exein kernel module (LKM) and sends UDP packets to a server \
. \
"
HOMEPAGE = "https://exein.io"
LICENSE = "GPLv2+"

LIC_FILES_CHKSUM = "file://LICENSE;md5=e49f4652534af377a713df3d9dec60cb"


S = "${WORKDIR}/git"

#SRCREV = "${AUTOREV}"
SRC_URI = "\
		   git://github.com/Exein-io/training-forwarder.git;protocol=https;tag=v0.2.0 \
		   file://0001-adding-ldflags.patch \
           "

do_compile() {
	oe_runmake -C ${S}
}

do_install() {
	install -d ${D}${bindir}
	cp -r \
		${S}/training-forwarder \
		${D}${bindir}/exein-forward
}

