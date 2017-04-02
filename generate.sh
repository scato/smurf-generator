#!/bin/bash

toBaseName='{ split($0, parts, "/"); len = length(parts); print parts[len] }'
toCamelCase='{ print tolower(substr($0, 1, 1)) substr($0, 2) }'
toUpperCase='{ rest = substr($0, 2); gsub(/[A-Z]/, "_&", rest); print substr($0, 1, 1) toupper(rest) }'

target=$1
artifact=$(echo $target | sed -e 's/^.*\/\(.*\)$/\1/')
examples=$(cd examples; find * -type f)

for example in $examples
do
    src="examples/$example"
    regexp=$(echo $example | sed -e 's/\./\\./g' -e 's/Smurf/\\(.*\\)/g')
    match=$(echo $artifact | grep "$regexp" | sed "s/$regexp/\\1/")

    if [ "$match" != "" ]
    then
        pascalCase=$match
        camelCase=$(echo $pascalCase | awk "$toCamelCase")
        upperCase=$(echo $pascalCase | awk "$toUpperCase")

        cat $src | sed -e "s/Smurf/$pascalCase/g" -e "s/smurf/$camelCase/g" -e "s/SMURF/$upperCase/g" > $target
    fi
done
