#!/bin/bash

file_name="full_script.sql"

rm -f $file_name
touch $file_name

for file in *
do 
	if [[ ${file##*.} == sql ]] && [[ "$file" != "$file_name" ]]
	then
		echo "$file"
		cat $file >> $file_name
	fi
done
