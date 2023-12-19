#!/bin/bash 



data=$(git diff HEAD~1..HEAD | grep "ZH/.*/.*.md" | grep -v "diff")
#read -r  -d ''  DIFF <<< "$data" 



# for line in "${DIFF}"; do
# 	echo "$line -------"
#   done
OLD_IFS="$IFS"
IFS="\n"
while read -r line; do
  for word in $line; do
    echo "$word---"
  done
done <<< "$data"
OLD_IFS="$IFS"

exit 2



input="Hello World"

# 保存原始 IFS 值
OLD_IFS="$IFS"

# 设置 IFS 为空格
IFS=" "

# 使用 while 循环遍历读取到的数据
while read -r line; do
  for word in $line; do
    echo "$word---"
  done
done <<< "$input"

# 恢复原始 IFS 值
IFS="$OLD_IFS"




