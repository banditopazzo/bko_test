SUMMARY = "A package to deploy Exein's models"
DESCRIPTION = " \
A package to deploy Exein's models \
"
HOMEPAGE = "https://exein.io"
LICENSE = "CLOSED"

S = "${WORKDIR}"

#deploy everything in files/models -> /etc/exein/models
SRC_URI = " \
		   file://models/* \
           "

do_install() {
    rm ${S}/models/__EXEIN_MODELS_PLACEHOLDER__ || true

	install -d ${D}/etc/exein/models 
	cp -r \
		${S}/models/* \
		${D}/etc/exein/models || true
}

ALLOW_EMPTY_${PN} = "1"

