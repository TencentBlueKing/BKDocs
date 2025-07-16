BEGIN{
  stderr="/dev/stderr"
  FS="\t"
  OFS="\t"

  # 默认启用行的前2列自动置空。
  if(length(enable_empty_leading)==0)enable_empty_leading=1
}

BEGINFILE{
  if(FILENAME~/\/release-/){
    is_release_file=1;
    match(FILENAME, /release-([0-9.]+)[.]tsv$/, am)
    if(am[1])release=am[1]; else {
      print "ERROR: bad release filename, must be release-([0-9.]+)[.]tsv:", FILENAME > stderr;
      nextfile;}
  } else {
    is_release_file=0
    table_head=1
  }
}

# release文件。
is_release_file{
  pname=$1;version=$2;appversion=$3
  release_tags[pname,version][release]=appversion
}

# 渲染表格
!is_release_file{
  # 如有字段数量不足，则原样输出。并重置表格状态寄存器。
  if(NF<5){print; delete table_state; table_state["head"]=1; next; }
  # 如果遇到表格，检测并显示表头。兼容产品更新表和更新日志表。
  if($1~/^[0-9]{8}$/){
    fndate=1;fnproduct=2;fnpname=3;fnversion=4;fnappversion=5;fntags=6
    date=$1;product=$2;pname=$3;version=$4;appversion=$5;tags=$6
  } else {
    fnproduct=1;fnpname=2;fnversion=3;fnappversion=4;fndate=5;fntags=6
    product=$1;pname=$2;version=$3;appversion=$4;date=$5;tags=$6
  }
  if(table_state["head"]==1){
    if(fnversion==3)print "| 产品 | 包名 | 包版本号 | 软件版本号 | 发布日期 | 标签 |"
    else print "| 发布日期 | 产品 | 包名 | 包版本号 | 软件版本号 | 标签 |"
    print "|--|--|--|--|--|--|"
    table_state["head"]=0  # 表头输出完毕。
  }
  # 判断前 2 列是输出新内容还是空格占位。仅当 $1 相同时，才合并 $2。
  if(enable_empty_leading){
    if($1==table_state["last1"]){
      $1="";
      if($2==table_state["last2"])$2=""; else table_state["last2"]=$2;
    } else { table_state["last1"]=$1; table_state["last2"]=$2; }
  }
  # 处理标签，先按空格分词。
  # if($NF)$NF="<code>"gensub(/( |、)+/, "</code>&nbsp;<code>", "g", $NF)"</code>"
  patsplit($NF, as, /[^ ]+/)
  new_tags=""
  delete tag_state
  for(i=1;i<=length(as);i++){
    tag=as[i]
    # 过滤重复标签，忽略功能体验标签。
    if(!tag_state[pname,version][tag]++&&tag!~/^功能体验/){
      new_tags=new_tags" `"tag"`"
    }
  }
  # 追加发行版标签。一个版本可能在多个发行版出现。
  if(isarray(release_tags[pname,version])){
    for(release in release_tags[pname,version]){
      new_tags=new_tags" `"release"`"
    }
  }
  # 标签回写标签字段。
  $fntags=gensub(/^ /, "", 1, new_tags)
  # 处理包版本号字段的超链接
  version_url=sprintf("updates/%s.md#%s-%s", substr(date, 1, 6), pname, version)
  $fnversion="["version"]("version_url")"
  # printf " %s | %s |\n", date, comments
  print "| "gensub("\t", " | ", "g", $0)" |"
}
