#!/usr/bin/gawk -f
# 输出chart的appversion。基准为指定名字的镜像。存在多个镜像时，要求取值一致。

# chart-appversion-to-image-map: chart-name image-names...

# chart-images.txt: chart-name  chart-version  image-specs...
# 获取方法： bkdl-7.1-stable.sh -r 7.1.3 chart-images
BEGIN{
  stderr="/dev/stderr"

  while((getline < "scripts/chart-appversion.tsv")>0){
    for(i=2;i<=NF;i++){
      tpl_chart_image[$1][$i]=1
      #print "DEBUG loaded", $1, $i > stderr
      cnt_images++
    }
    cnt_chart++
  }
  print "DEBUG: cnt_chart, cnt_images", cnt_chart, cnt_images > stderr
}
BEGINFILE{
  delete m_chart_image_version
}
{
  chart=$1;version=$2;
  # 处理待检数据
  for(i=3;i<=NF;i++){
    match($i, /([^/]+):v?([^:]+)$/, am)
    image=am[1]
    image_tag=am[2]
    pending_chart_image[chart][image]=image_tag
  }
  # 提取检查
  if(chart in tpl_chart_image){
    if("--" in tpl_chart_image[chart]){
      appversion=version
    } else {
      appversion=""
      error=""
      n_image_in_chart=length(tpl_chart_image[chart])
      for(image in tpl_chart_image[chart]){
        image_tag=pending_chart_image[chart][image]
        if(!appversion)appversion=image_tag
        else if(appversion==image_tag) continue
        else error=error" "image":"image_tag
      }
      if(error){
        print "ERROR: version mismatch:", error > stderr
        next
      }
    }
  } else {
    print "ERROR: unknown chart:", chart > stderr
    next
  }
  # 结论
  print chart"\t"version"\t"appversion
}

