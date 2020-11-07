#!/bin/zsh

# Validate a Nova.app extension.
#
# USAGE: validate.sh [-j|-v|-s|-r|-x] <my.novaextension>
#
# -j: Validate using jing
# -v: Validate using rnv
# -s: Validate Relax-NG schema using xmlstarlet
# -r: Validate Relax-NG schema using xmllint (default)
# -x: Validate XSD schema using xmllint

base=$(cd $(dirname "$0") && pwd)
fail=0
vstyle=xmllint

while getopts 'jvsrx' opt; do
    case $opt in
        j) vstyle=jing ;;
        v) vstyle=rnv ;;
        s) vstyle=xmlstarlet ;;
        r) vstyle=xmllint ;;
        x) vstyle=xsd ;;
        \?) exit ;;
    esac
done
shift $((OPTIND-1))

if [ $# -lt 1 ]; then
    echo "USAGE: $0 <my.novaextension>..." >&2
    exit 1
fi

# validate <schema-base> <instance-xml>
function validate() {
    echo "Validating($vstyle) $2"
    case $vstyle in
        jing)
            jing -c "$base/$1.rnc" "$2"
            ;;
        rnv)
            rnv "$base/$1.rnc" "$2"
            ;;
        xmlstarlet)
            xmlstarlet val --err --relaxng "$base/gen/$1.rng" "$2"
            ;;
        xmllint)
            xmllint --relaxng "$base/gen/$1.rng" --noout "$2"
            ;;
        xsd)
            xmllint --schema "$base/gen/$1.xsd" --noout "$2"
            ;;
    esac
    if [ $? -ne 0 ]; then
        fail=1
    fi
}

# do_subdir <schema-base> <dir>
function do_subdir() {
    if [ -d "$2" ]; then
        for syntax in "$2"/*.xml; do
            validate "$1" "$syntax"
        done
    fi
}

# do_extension <novaextension-dir>
function do_extension() {
    do_subdir syntax "$1/Syntaxes"
    do_subdir completions "$1/Completions"
}

for novaext in "$@"; do
    do_extension "$novaext"
done

exit $fail