#!/bin/bash
    : ${RCSID:=$Id: - @VERSION@ @DATE@ @TIME@ - $}
    : ${PACKAGE:=@PACKAGE@}
    : ${PROGRAM_TITLE:=Convert SVG to image assets}
    : ${PROGRAM_SYNTAX:=[OPTIONS] [--] ...}

    SVG2ASSETS=svg2assets

    . shlib-import cliboot
    option -t --type = TYPE  "Type of the output directory (png default, jpg)"
    option -q --quiet
    option -v --verbose
    option -h --help
    option    --version

    opt_type=png

function setopt() {
    case "$1" in
        -t|--type)
            opt_type="$2"
            case "$opt_type" in
                png|jpg)
                    ;;
                *)
                    quit "Invalid type: $opt_type (supported: png, jpg)"
                    ;;
            esac
            ;;
        -h|--help)
            help $1; exit;;
        -q|--quiet)
            LOGLEVEL=$((LOGLEVEL - 1));;
        -v|--verbose)
            LOGLEVEL=$((LOGLEVEL + 1));;
        --version)
            show_version; exit;;
        *)
            quit "invalid option: $1";;
    esac
}

function main() {
    $SVG2ASSETS -q -o "$opt_type" -d -s "24,32,48,64"   svg/normal/*.svg
    $SVG2ASSETS -F '%s/%n-solid.%t' \
                -q -o "$opt_type" -d -s "24,32,48,64"   svg/solid/*.svg
    $SVG2ASSETS -q -o "$opt_type" -d -s "20"            svg/mini/*.svg
    $SVG2ASSETS -q -o "$opt_type" -d -s "16"            svg/micro/*.svg
}

boot "$@"
