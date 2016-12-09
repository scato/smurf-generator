#!/bin/bash

target=$1
artifact=$(echo $target | sed "s/^.*\\/\(.*\)$/\\1/")
examples=$(cd examples; find * -type f)

for example in $examples
do
    src="examples/$example"
    regexp=$(echo $example | sed "s/\\./\\\\./g;s/Smurf/\\\\(.*\\\\)/g")
    match=$(echo $artifact | grep "$regexp" | sed "s/$regexp/\\1/")

    if [ "$match" != "" ]
    then
        pascalCase=$match
        camelCase=$(echo $pascalCase | gsed -r "s/^./\L\0/")
        upperCase=$(echo $camelCase | gsed -r "s/[A-Z]/_\0/g;s/./\U\0/g")

        cat $src | sed "s/Smurf/$pascalCase/g;s/smurf/$camelCase/g;s/SMURF/$upperCase/g" > $target
    fi
done
