BEGIN{
  stderr="/dev/stderr"
  FS="\t"
  OFS="\t"

  while((getline < "scripts/packages.tsv") >0){
    product=$1;pname=$2
    #print pname, product > stderr
    products[pname]=product
    # matrix，生成按product和pname排序的输出。
    m_product_pname[product][pname]=1
  }
}

# 功能体验：按功能分组（复用标签字段，不展示，每条记录1个功能，多个功能使用多条记录），无标签内容属于共享更新。
{
  if($0~/^[ \t]*$/){next; }
  date=$1;pname=$2;ptype=$3;version=$4;appversion=$5;flags=$6
  # 先按flags分组。先出现的先展示。
  patsplit(flags, as, /(功能体验：[^ ]+)/)
  for(i=1;i<=length(as);i++){
    tag=as[i]
    # 定义分组时记录次序，仅一次。规则：日期、出现的行(最大9999)、列中的次序(最大9)
    if(!(tag in tag_order)) tag_order[tag]=date*10000+NR*10+i
    # 约束分组下能出现的name。并记录最早的date。
    if(!m_tag_pname[tag][pname])m_tag_pname[tag][pname]=date
    # 所有的版本需要记录到对应tag下。
    m_version[pname][date][tag]=version"\t"appversion
  }
  # 如果没有任何tag，则为公共更新。
  if(length(as)==0)m_version[pname][date][""]=version"\t"appversion
  m_flags[pname][date]=flags
}
END{
  PROCINFO["sorted_in"]="@val_num_asc"
  for(tag in tag_order){
    PROCINFO["sorted_in"]="@ind_str_asc"
    # print "DEBUG tag", tag > stderr
    print ""
    print "### "tag
    for(product in m_product_pname){
      for(pname in m_product_pname[product]){
        if(!(pname in m_tag_pname[tag])){ continue; }  # 只有分组下定义过的pname才能出现。
        tag_date=m_tag_pname[tag][pname]
        for(date in m_version[pname]){
          if(date<tag_date){continue;}  # 早于分组定义时间的包不要。
          if(tag in m_version[pname][date])version=m_version[pname][date][tag]
          else version=m_version[pname][date][""]
          if(!version){ continue; }  # 如果版本号无效，则忽略。
          flags=m_flags[pname][date]
          print product, pname, version, date, flags
        }
      }
    }
  }
}
