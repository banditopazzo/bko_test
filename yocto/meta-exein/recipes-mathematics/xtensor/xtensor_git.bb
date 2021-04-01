SUMMARY = "Multi-dimensional arrays with broadcasting and lazy computing."
DESCRIPTION = " \
xtensor is a C++ library meant for numerical analysis with multi-dimensional array expressions. \
"
HOMEPAGE = "https://github.com/xtensor-stack/xtensor"
LICENSE = "BSD-3-Clause"

DEPENDS = "xtl"

LIC_FILES_CHKSUM = "file://LICENSE;md5=5c67ec4d3eb9c5b7eed4c37e69571b93"

inherit cmake

S = "${WORKDIR}/git"

SRCREV = "${AUTOREV}"
SRC_URI = "\
			git://github.com/xtensor-stack/xtensor.git;protocol=https;branch=stable \
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
