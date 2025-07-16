# 此脚本不可复用，历史内容仅供参考。
BEGIN{
  stderr="/dev/stderr"
  FS="\t"
  OFS="\t"

  while(("gawk -f scripts/journal.awk scripts/patches.tsv scripts/features.tsv" | getline) >0){
    date=$1;product=$2;pname=$3;version=$4;appversion=$5;tags=$6
    #print pname, product > stderr
    m_product_name_date_version[product][pname][date][version]=appversion
    # 输出3级标题： date proudct pname-version(额外a anchor date-pname-version)
    o_text[date][product][pname"-"version]=""
  }
  #
  alt_product[" GSE 服务端"]="管控平台"
  alt_product["蓝盾平台"]="持续集成平台"
  alt_product["蓝鲸运维开发平台"]="运维开发平台"
  alt_product[" bk-apigateway"]="API 网关"
  alt_product[" bkmonitor-operator"]="监控平台"
  alt_product[" GSE 插件"]="监控平台"
  alt_product[" GSE Agent"]="管控平台"
  FS=" +"
}

/^## /{
  mode=1  # 探测
  product=substr($0, 6)
  if(product in alt_product) product=alt_product[product]
  # print "DEBUG product", product > stderr
  if(!(product in m_product_name_date_version)){
    print "ERROR: unknown product:", product > stderr
    exit
  }
  FS=" *[|] *"
  last0=""  # 清空缓存。
  next
}

# 探测日期和版本信息。
# mode==1{
#   if($0~/^[|] *202/){
#     # 当202开头，则记录标题和版本号
#     heading=$2;version=$3;appversion=$4
#     date=substr(heading, 1, 8)
#     # print "DEBUG found", product, date, version > stderr
#     th_product_name_date[product][pname][date]=version
#     th_product_n_date[product]
#   }
#   if($0==""){
#     pname=product  # 复用产品名。
#   }else if($0~/[|] *软件版本号 *[|]/){
#     if(last0~/^[a-z0-9._-]+$/){
#       pname=last0
#       if(!(pname in m_product_name_date_version[product])){
#         print "ERROR: unknown name in product:", pname, product > stderr
#         exit
#       }
#     }
#   } else last0=$0
# }

/^### /{
  mode=2  # 追加

  # date=substr($0, 5, 8)
  # 人工修改了之前的update.md的3级标题为新格式，从而确保正常定位。
  anchor=substr($0, 5)
  # print "DEBUG h3", date > stderr
  # if(date in m_date_product){
  #   version=m_date_product[date][product]
  #   pname=m_product_name_date_version[product][date][version]
  #   print "INFO date-product-name-version:", date, product, pname, version > stderr
  #   if(!version||!pname){
  #     print "DEBUG unknown d-p-p-v", date, product, pname, version > stderr
  #     exit
  #   }
  # } else {
  #   print "ERROR: unknown date-product:", date, product, pname, version > stderr
  #   exit
  # }
  # FS=" +"
  next
}

# 采集$0到指定的数组
mode==2{
  # print "DEBUG mode2 anchor=" anchor"." > stderr
  # text[pname][version]=text[pname][version] $0 "\n"
  text[anchor]=text[anchor] $0 "\n"
}

END{
  # exit
  PROCINFO["sorted_in"]="@ind_str_asc"
  for(date in o_text){
    ofn="updates/"substr(date, 1, 6)".md"
    # ofn="/dev/stdout"
    print "\n# "date > ofn
    for(product in o_text[date]){
      print "\n## "product > ofn
      for(anchor in o_text[date][product]){
        #version=o_text[date][product][pname]
        # anchor=date"-"pname"-"version
        #anchor=pname"-"version
        # print ""
        # printf "<a name=\"%s\" id=\"%s\" />\n", anchor, anchor
        print "\n### "anchor > ofn
        if(length(text[anchor])<100)
          print "WARNING: text is small than 100:", length(text[anchor]), ofn, date, product, anchor > stderr
        printf text[anchor] > ofn
      }
    }
    # exit
  }
}
