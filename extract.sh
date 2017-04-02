#!/bin/bash

toBaseName='{ split($0, parts, "/"); len = length(parts); print parts[len] }'
toCamelCase='{ print tolower(substr($0, 1, 1)) substr($0, 2) }'
toUpperCase='{ rest = substr($0, 2); gsub(/[A-Z]/, "_&", rest); print substr($0, 1, 1) toupper(rest) }'

template=$1
input=$2
artifact=$(echo $input | sed -e 's/^.*\/\(.*\)$/\1/')

output="examples/$template"
regexp=$(echo $template | sed -e 's/\./\\./g' -e 's/Smurf/\\(.*\\)/g')
match=$(echo $artifact | grep "$regexp" | sed "s/$regexp/\\1/")

pascalCase=$match
camelCase=$(echo $pascalCase | awk "$toCamelCase")
upperCase=$(echo $pascalCase | awk "$toUpperCase")

cat $input | sed -e "s/$pascalCase/Smurf/g" -e "s/$camelCase/smurf/g" -e "s/$upperCase/SMURF/g" > $output
