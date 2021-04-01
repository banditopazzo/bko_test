FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto_${@".".join(d.getVar("LINUX_VERSION").split(".")[0:2])}:"

SRCREV_machine_genericx86 = "${AUTOREV}"
KERNEL_VERSION_SANITY_SKIP="1" 

COMPATIBLE_MACHINE = "genericx86-64|genericx86|qemux86|qemux86-64|qemuarm|qemuarm64|qemumips|qemumips64"

SRC_URI += "file://exein.cfg"
SRC_URI += "file://999-exein.patch"

