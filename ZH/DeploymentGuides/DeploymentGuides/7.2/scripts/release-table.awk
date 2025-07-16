BEGIN{
  stderr="/dev/stderr"
  FS="\t"
  OFS="\t"

  while((getline < "scripts/packages.tsv") >0){
    nr++
    product=$1;pname=$2;ptype=$3
    #print pname, product > stderr
    products[pname]=product
    ptypes[pname]=ptype
    # matrix，生成按product和pname排序的输出。
    anr_product[product]=nr
    m_product_pname[product][pname]=nr
  }
}

# 补丁更新：按产品、包名分组，按时间升序展示版本号，链接到对应的文档。
{
  if($0~/^[ \t]*$/){ next; }
  pname=$1;version=$2;appversion=$3?$3:"--";
  # 先包名后时间。
  a_version[pname]=version
  a_appversion[pname]=appversion
  missing_products[pname]=1
  #print "DEBUG:"pname
}
END{
  print "| 产品 | 包名 | 包版本号 | 软件版本号 | 包类型 |"
  print "|--|--|--|--|--|"
  PROCINFO["sorted_in"]="@val_num_asc"
  for(product in anr_product){
    for(pname in m_product_pname[product]){
      ptype=ptypes[pname]
      #if(!(pname in a_version)){ continue; }
      version=a_version[pname]
      appversion=a_appversion[pname]
      #print "DEBUG: " product, oldp >stderr
      printf "| %s | %s | %s | %s | %s |\n", product==oldp?"":product, pname, version, appversion, ptype
      delete missing_products[pname]
      oldp=product
    }
  }
  print "orphan packages:" > stderr
  PROCINFO["sorted_in"]="@val_num_asc"
  for(pname in missing_products){
    print pname > stderr
  }
}
