cd /c/Users/v_cyuliu/Desktop/文档中心/BKDocs/ZH/7.0
for i in `ls`;
do 
	[ -d $i ] && cd $i || continue 
	echo `pwd`
	ret=$(md5sum SUMMARY.md | awk '{print $1}')
	sed -ri '/^\* \[产品白皮书\]\(\)/d' SUMMARY.md ;
	ret1=$(md5sum SUMMARY.md | awk '{print $1}')
	echo -----ret = $ret--------
	echo -------ret1 = $ret1 ------------
	if [[ $ret != $ret1 ]];then
		sed -ri 's/^    //g' SUMMARY.md;   
	fi
	cd ..
	done
