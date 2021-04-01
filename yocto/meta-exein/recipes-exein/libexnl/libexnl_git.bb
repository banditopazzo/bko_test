SUMMARY = "This library is intended to be used for interfacing the machine learning engine with the kernel infrastructure. "
DESCRIPTION = " \
This library is intended to be used for interfacing the machine learning engine with the kernel infrastructure. \
"
HOMEPAGE = "https://exein.io"
LICENSE = "GPLv2+"

LIC_FILES_CHKSUM = "file://LICENSE;md5=1ebbd3e34237af26da5dc08a4e440464"


S = "${WORKDIR}/git"

#tag 0.7.0
#SRCREV = "c09bd8815d3baa122193796c7bde772366fcdeb4"

SRC_URI = "\
		   git://github.com/Exein-io/libexnl.git;protocol=https;tag=v0.7.1 \
		   file://0001-use-cc-ar-if-defined.patch \
           "
do_compile() {
	oe_runmake -C ${S}
}


do_install() {
	install -d ${D}${libdir}
	cp -r \
		${S}/lib/* \
		${D}${libdir}

	cp -r \
		${S}/include \
		${D}${includedir}
}

FILES_${PN} = " \
	${libdir}/libexnl.so \
"

FILES_${PN}-dev = " \
	${includedir} \
"

FILES_${PN}-staticdev = " \
	${libdir}/libexnl.a \
"


#COMPATIBLE_HOST = '(x86_64.*|i.86.*)-(linux|freebsd.*)'
