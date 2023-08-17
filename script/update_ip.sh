path=$(cat a.txt | awk '{print $1}')
ip=$(cat a.txt | awk '{print $3}' |  grep -Eo "\w+\.\w+\.\w+\.\w+")
lines=$(wc -l a.txt | awk '{print $1}')

# echo ${path[0]}

while read line
do
    file=$(echo $line | awk '{print $1}'  | sed  -r  's/\/data\/landun\/workspace/\.\./')
    sed -rn '/1/p'  $file
    exit 1
done < a.txt
