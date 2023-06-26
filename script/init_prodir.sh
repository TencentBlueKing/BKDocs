product= #产品目录名
language=   #中文目录
version=   #创建的版本号目录


[[ -z ${product} || -z ${version} || -z ${language} ]]  && echo "请设定配置" && exit 1

product_dir="${version} ErrorCode ReleaseNotes"
product_file="Vedios.md GithubContributorGuide.md"
version_dir="APIDocs Architecture Operation UserGuide"
userguide_dir="Advantage Architecture Conclusion FAQ Feature Introduce QuickStart UserCase assert"
summary="# Summary \n\n## $product"
DIR=$(cd `dirname $(readlink -f $0)` && cd ../${language} && pwd)

function init(){
    cd ${DIR}
    [ -d ${product} ] && echo "改产品已经存在" && exit 1  
    mkdir ${product}
    for i in ${product_file}
        do 
            echo "待补充" >> ${product}/$i
        done
    for i in ${product_dir}
        do 
            mkdir -p ${product}/${i}
            if  [[ $i == "ReleaseNotes" ]];then
                echo "待补充" >> ${product}/${i}/ReleaseNotes.md
            elif [[ $i == "ErrorCode" ]];then
                echo "待补充" >> ${product}/${i}/${product}.md
            elif [[ $i == ${version} ]];then
            cat >> ${product}/${version}/SUMMARY.md  <<EOF
$(echo -e ${summary})
EOF
                for j in ${version_dir}
                    do 
                        mkdir -p ${product}/${version}/${j}
                        if [[ $j == "UserGuide" ]];then
                            for k in ${userguide_dir}
                                do 
                                     mkdir -p ${product}/${version}/${j}/${k}
                                     echo "待补充" >> ${product}/${version}/${j}/${k}/README.md
                                done
                        else
                            echo "待补充" >> ${product}/${version}/${j}/README.md
                        fi
                    done
            fi 
        done
}

init