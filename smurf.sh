#!/bin/sh

toBaseName='{ split($0, parts, "/"); len = length(parts); print parts[len] }'
toCamelCase='{ print tolower(substr($0, 1, 1)) substr($0, 2) }'
toUpperCase='{ rest = substr($0, 2); gsub(/[A-Z]/, "_&", rest); print substr($0, 1, 1) toupper(rest) }'

extract() {
    artifact=${source##*/}

    output=".smurf/$template"
    regexp=$(echo $template | sed -e 's/\./\\./g' -e 's/Smurf/\\(.*\\)/g')
    match=$(echo $artifact | grep "$regexp" | sed "s/$regexp/\\1/")

    pascalCase=$match
    camelCase=$(echo $pascalCase | awk "$toCamelCase")
    upperCase=$(echo $pascalCase | awk "$toUpperCase")

    cat $source | sed -e "s/$pascalCase/Smurf/g" -e "s/$camelCase/smurf/g" -e "s/$upperCase/SMURF/g" > $output
}

generate() {
    artifact=${source##*/}
    templates=$(cd .smurf; find * -type f)

    for template in $templates
    do
        input=".smurf/$template"
        regexp=$(echo $template | sed -e 's/\./\\./g' -e 's/Smurf/\\(.*\\)/g')
        match=$(echo $artifact | grep "$regexp" | sed "s/$regexp/\\1/")

        if [ "$match" != "" ]
        then
            pascalCase=$match
            camelCase=$(echo $pascalCase | awk "$toCamelCase")
            upperCase=$(echo $pascalCase | awk "$toUpperCase")

            cat $input | sed -e "s/Smurf/$pascalCase/g" -e "s/smurf/$camelCase/g" -e "s/SMURF/$upperCase/g" > $source
        fi
    done
}

usage() {
    echo "usage: $0 <command> [<args>]"
    echo ""
    echo "These are the supported commands:"
    echo "   extract    Create a new template using an existing file"
    echo "   generate   Generate a file using a template"
    echo ""
}

usage_extract() {
    echo "usage: $0 extract <template> <source>"
    echo ""
    echo "The extract command takes the following arguments:"
    echo "   template   The name of the template"
    echo "   source     The location of the existing source code file"
    echo ""
}

usage_generate() {
    echo "usage: $0 generate <source>"
    echo ""
    echo "The generate command takes the following argument:"
    echo "   source     The location of the source code file that should be generated"
    echo ""
}

case "$1" in
    'extract')
        template=$2
        source=$3

        if (test $2 && test -e $3); then
            extract
        else
            usage_extract
        fi
        ;;
    'generate')
        source=$2

        if (test $2); then
            generate
        else
            usage_generate
        fi
        ;;
    'help')
        case "$2" in
            'extract')
                usage_extract
                ;;
            'generate')
                usage_generate
                ;;
            *)
                usage
        esac
        ;;
    *)
        usage
        exit 1
esac
