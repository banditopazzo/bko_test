SUMMARY = "Multi-dimensional arrays with broadcasting and lazy computing."
DESCRIPTION = " \
xtensor is a C++ library meant for numerical analysis with multi-dimensional array expressions. \
"
HOMEPAGE = "https://github.com/xtensor-stack/xtl"
LICENSE = "BSD-3-Clause"

LIC_FILES_CHKSUM = "file://LICENSE;md5=c12cbcb0f50cce3b0c58db4e3db8c2da"

inherit cmake

S = "${WORKDIR}/git"

SRCREV = "${AUTOREV}"
SRC_URI = "\
			git://github.com/xtensor-stack/xtl.git;protocol=https;branch=master \
           "
SRC_URI[sha256sum] = "2362db1de3a5909235f6e7f5ea24def883ecfecafa7d4008800569e2c1d07af4"

EXTRA_OECMAKE = ""

#do_compile() {
#	oe_runmake -C ${S}/libexnl
#}


#do_install() {
#	install -d ${D}${libdir}
#	cp -r \
#		${S}/libexnl/lib/* \
#		${D}${libdir}
#
#	cp -r \
#		${S}/libexnl/include \
#		${D}${includedir}
#}
