#!/bin/bash 


ret=$(git diff HEAD~1..HEAD | grep "ZH/.*/.*.md" | grep -v "diff")
read -r  -d ''  DIFF <<< "$ret" 

for line in "${DIFF[@]}"; do
	echo "$line" ----------------
#	  echo "${line#*/}"
  done
