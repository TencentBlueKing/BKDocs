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

# 补丁更新：按产品、包名分组，按时间升序展示版本号，链接到对应的文档。
{
  if($0~/^[ \t]*$/){ next; }
  date=$1;pname=$2;ptype=$3;version=$4;appversion=$5;flags=$6
  # 先包名后时间。
  m_version[pname][date]=version"\t"appversion
  m_flags[pname][date]=flags
}
END{
  PROCINFO["sorted_in"]="@ind_str_asc"
  for(product in m_product_pname){
    for(pname in m_product_pname[product]){
      if(!(pname in m_version)){ continue; }
      for(date in m_version[pname]){
        version=m_version[pname][date]
        flags=m_flags[pname][date]
        print product, pname, version, date, flags
      }
    }
  }
}
