SUMMARY = "A command line tool for updating and displaying info about boot loaders"
DESCRIPTION = " \
Exein Core has the main objective of protecting as many different types of \
firmware as possibile. This is why we have developed several versions of our product, always ensuring \
the best performance and, in turn, the maximum level of security. \
"
HOMEPAGE = "https://exein.io"
LICENSE = "GPLv2+"

LIC_FILES_CHKSUM = "file://LICENSE;md5=e49f4652534af377a713df3d9dec60cb"

DEPENDS = "tensorflow-lite libexnl xtensor"

S = "${WORKDIR}/git"

#SRCREV = "${AUTOREV}"
SRC_URI = "git://github.com/Exein-io/mle-player.git;protocol=https;tag=v0.8.2 \
		   file://0001-makefile.patch \
           "

do_compile() {
	oe_runmake -C ${S}
}


do_install() {
	install -d ${D}${bindir}
	cp -r \
		${S}/mle-player \
		${D}${bindir}
}


RDEPENDS_${PN} = "libexnl"

#COMPATIBLE_HOST = '(x86_64.*|i.86.*)-(linux|freebsd.*)'
