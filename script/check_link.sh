npm i -g markdown-link-check 
if  [ $? -ne 0 ];then
    echo "nmp安装插件失败"
    exit 1
fi


DIR=$(cd `dirname $(readlink -f $0)` && cd ../${language} && pwd)

#检测ZH目录所有文件路径并把结果写入 support-docs/script/ZH.log ,用完log记得删除掉

# cd $DIR/ZH
# [ -f  $DIR/script/ZH.log ] && rm -rf $DIR/script/ZH.log
# for i in $(find . -type  f  -name "*.md") 
# do
# markdown-link-check  $i   >>  $DIR/script/ZH.log
# done

# #检测EN目录所有文件路径并把结果写入 support-docs/script/EN.log ,用完log记得删除掉
# cd $DIR/EN
# [ -f  $DIR/script/EN.log ] && rm -rf $DIR/script/EN.log
# for i in $(find . -type  f -name "*.md") 
# do
# markdown-link-check  $i   >>  $DIR/script/EN.log
# done

cd $DIR/EN

for i in  NodeMan/2.2 PaaS/1.0
do
    cd  $i
    echo "------------------------------------$i-------------------------------" >> $DIR/script/EN.log
    for j in $(find . -type  f -name "*.md") 
        do
            markdown-link-check  $j   >>  $DIR/script/EN.log
        done
    cd ../..
done

