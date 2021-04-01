do_install[postfuncs] += "do_install_tagging"

# tag from (package, tag)
export EXEIN_TAG=__PACKAGE_TAG__


# same function for every recipe
do_install_tagging () {
    bash -c "echo -ne '$EXEIN_TAG' > exein"
    
    EXEFILES=$(find ${D} -type f ! \( -name "*.so.*" -o -name "*.so" \) -print0 | xargs -0 -n 10 file -i | egrep "application\/x-sharedlib|application\/x-executable|application\/x-pie-executable" | cut -d ':' -f 1);

    for f in ${EXEFILES};
    do
        bbplain "[EXEIN on ${PN}]:  TAGGING: $f"
        ${OBJCOPY} --add-section .exein=exein --set-section-flags .exein=noload,readonly $f
    done

    rm exein
}

# Could be used also: 
#do_install_append() {
# same as do_install_tagging
#}