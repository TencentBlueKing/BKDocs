#!/bin/bash

md_file=$1
file_path=`dirname $md_file`


cat $1 | grep media | awk -F[/.] '{print $2".jpg"}' | while read line ; do 

find . -name $line |  xargs  -I  '{}'  mv  -v {}  ${file_path}/media/

done
