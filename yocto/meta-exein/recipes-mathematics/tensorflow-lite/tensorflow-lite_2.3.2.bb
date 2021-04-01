DESCRIPTION = "TensorFlow Lite C++ Library"
LICENSE = "Apache-2.0"

LIC_FILES_CHKSUM = "file://LICENSE;md5=64a34301f8e355f57ec992c2af3e5157"

# tag 2.3.2
SRCREV = "9edbe5075f79a4a95ed14a2be831f9b59e61f49d"

SRC_URI = " \
	git://github.com/tensorflow/tensorflow.git;branch=r2.3 \
	file://0001-tensorflow-lite.patch \
"
PR = "r0"

#COMPATIBLE_MACHINE = "(iwg20m-g1m|iwg21m|iwg22m|hihope-rzg2h|hihope-rzg2m|hihope-rzg2n|ek874)"

S = "${WORKDIR}/git"

PACKAGES += "${PN}-examples ${PN}-examples-dbg"
RDEPENDS_${PN}-examples += "${PN}"
RDEPENDS_${PN}-examples-dbg += "${PN}"

DEPENDS = "gzip-native unzip-native zlib"

do_configure(){
	export HTTP_PROXY=${HTTP_PROXY}
	export HTTPS_PROXY=${HTTPS_PROXY}
	export http_proxy=${HTTP_PROXY}
	export https_proxy=${HTTPS_PROXY}

	${S}/tensorflow/lite/tools/make/download_dependencies.sh
}

CXXFLAGS += "--std=c++11"
FULL_OPTIMIZATION += "-O3 -DNDEBUG"

do_compile() {
	oe_runmake BUILD_WITH_NNAPI=true
}

do_install(){
	install -d ${D}${libdir}
	cp -r \
		${S}/tensorflow/lite/tools/make/gen/lib/* \
		${D}${libdir}

	cd ${S}
	find tensorflow/lite -name "*.h" | cpio -pdm ${D}${includedir}/
	find tensorflow/lite -name "*.inc" | cpio -pdm ${D}${includedir}/

	install -d ${D}${includedir}/tensorflow_lite
	cd ${S}/tensorflow/lite
	cp --parents \
		$(find . -name "*.h*") \
		${D}${includedir}/tensorflow_lite

	install -d ${D}${includedir}/flatbuffers
	cd ${S}/tensorflow/lite/tools/make/downloads/flatbuffers/include
	cp --parents \
		$(find . -name "*.h*") \
		${D}${includedir}
}

ALLOW_EMPTY_${PN} = "1"

FILES_${PN} = ""

FILES_${PN}-dev = " \
	${includedir} \
"

FILES_${PN}-staticdev = " \
	${libdir} \
"
