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

# 发布记录：汇总功能和补丁，按时间排序。合并重复版本的全部标签（不显示功能体验标签）。
{
  if($0~/^[ \t]*$/){next; }
  date=$1;pname=$2;ptype=$3;version=$4;appversion=$5;flags=$6
  # 先按flags分组。先出现的先展示。
  patsplit(flags, as, /(功能体验：[^ ]+)/)
  # 按年月分表格，分更新文件。
  YYYYmm=substr(date, 1, 6)
  m_YYYYmm_date_pname[YYYYmm][date]=1
  # 先时间后包名。
  m_version[date][pname]=version"\t"appversion  # 每天每包只记录最新版本，不然排序头疼。
  patsplit(flags, as, / +/)
  # 合并多个文件里同版本的flags
  m_flags[pname][m_version[date][pname]]=m_flags[pname][m_version[date][pname]]" "flags
}
END{
  PROCINFO["sorted_in"]="@ind_str_asc"
  for(YYYYmm in m_YYYYmm_date_pname){
    # print "DEBUG YYYYmm", YYYYmm > stderr
    # 按月拆分太丑了，先不拆了。
    # print ""
    # print "### "YYYYmm
    # print "本月更新记录详见 [单产品更新-"YYYYmm"](update-"YYYYmm".md)。\n"
    for(date in m_YYYYmm_date_pname[YYYYmm]){
      for(product in m_product_pname){
        for(pname in m_product_pname[product]){
          if(!(pname in m_version[date])){ continue; }  # 只有分组下定义过的pname才能出现。
          version=m_version[date][pname]
          flags=m_flags[pname][version]
          # print "DEBUG mflags date", date, pname, date in m_flags > stderr
          # print "DEBUG mflags pname", pname in m_flags[date] > stderr
          # print "DEBUG mflags version", version, version in m_flags[date][pname] > stderr
          print date, product, pname, version, flags
        }
      }
    }
  }
}
