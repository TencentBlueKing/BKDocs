## 开发可视化 SaaS

## 情景

业务数据都已经接入到平台，同时进行了实时计算、离线计算，并将数据保存到平台中。需要将 **数据可视化**，通过 **视图的形式** 呈现出来。

本文介绍从平台获取一个 IP 的进程(pid)的 CPU 使用率数据来绘制曲线图。

## 前提条件

- [在平台上创建项目，并给项目申请一个结果数据表权限](../user-guide/user-center/projects.md)
- 熟悉一门脚本语言，如 `Python` ，本教程以 `Python` 为例
- [使用平台的接口进行数据查询](../user-guide/auth-management/token.md)

## 操作步骤

- 代码实现获取数据
- Echart 绘制曲线图

 
### 代码实现获取数据

```python
# -*- coding: utf-8 -*-
import json
import requests 
BK_DATA_URL = 'http://<BK_PAAS_HOST>/prod/v3/'
headers = {"Content-Type": "application/json; charset=utf-8"}
sql = "select dtEventTime,cpu_usage_pct as count,pid from table_name where ip='10.0.0.1' group by pid,dtEventTime order by dtEventTime limit 100000"
data = json.dumps({
  "bk_app_code": '<YOUR bk_app_code>',
  "bk_app_secret": '<YOUR bk_app_secret>',
  "bkdata_authentication_method": "user",
  "bk_username": '<username>',
  "sql": sql,
  "prefer_storage": "tspider"
})
response = requests.post(
  url=BK_DATA_URL + '/dataquery/query/',
  headers=headers,
  data=data
)
print("Status Code: {status_code}".format(
  status_code=response.status_code))
print("Response Body: {content}".format(
  content=response.content))
res = json.loads(response.content)
data  = res.get('data', {}).get('list', [])
# 构造绘制echart所需的数据格式 
xAxis = []
pid_data = {}
series = []
for d in data:
  xAxis.append(d['dtEventTime'])
  pid = str(d['pid'])
  if pid not in pid_data:
      pid_data.update({pid: [d['count']]})
  else:
      old_data = pid_data[pid]
      old_data.append(d['count'])
      pid_data.update({pid: old_data})
for pid, p_data in pid_data.items():
    series.append({
      "name": pid,
      "type": "line",
      "data":p_data
    })
xAxis = list(set(xAxis))
xAxis = sorted(xAxis)
res.update({"data":{"xAxis": xAxis,"series": series}})
return JsonResponse(res)
```
  
### Echart 绘制曲线图

  - JavaScript 源码

    需要先引入 JQuery， echarts 等依赖的 jsplainplain

  ```javascript
<script>
          $(function(){
              initEStandLineChart({
                  url: 'http://get_chart_data/',
                  dataType: 'json',
                  containerId: 'chart_1586682196265'
              });
          });
          function createEStandLineChart(conf){
              var myChart = echarts.init(document.getElementById(conf.selector));
              var legendData = []
              for(var i=0; i < conf.data.series.length;i++){
                  legendData.push(conf.data.series[i].name)
              }
              myChart.setOption({
                  tooltip : {
                      trigger: 'axis'
                  },
                  legend: {
                      y: 'bottom',
                      data:legendData
                  },
                  toolbox: {
                      show : true,
                      feature : {
                          mark : {show: true},
                          dataView : {show: true, readOnly: false},
                          magicType : {show: true, type: ['bar','line']},
                          restore : {show: true},
                          saveAsImage : {show: true}
                      }
                  },
                  calculable : true,
                  xAxis : [
                      {
                          type : 'category',
                          data : conf.data.xAxis
                      }
                  ],
                  yAxis : [
                      {
                          type : 'value',
                          splitArea : {show : true}
                      }
                  ],
                  series : conf.data.series
              });
           }
          function initEStandLineChart(conf){
              $.ajax({
                  url: conf.url,
                  type: 'GET',
                  dataType: conf.dataType,
                  success: function(res){
                      //获取数据成功
                      if (res.result){
                          createEStandLineChart({
                              selector: conf.containerId, // 图表容器
                              data: res.data, // 图表数据
                          });
                      }
                  }
              })
          }
</script>
  ```
  
  - HTML 源码

  ```html
<div class="king-page-box">
          <div class="king-container clearfix">
              <div style="height: 300px; -webkit-tap-highlight-color: transparent; user-select: none; background-color: rgba(0, 0, 0, 0); cursor: default;" id="chart_1586682196265" class="king-chart-box chart-line " _echarts_instance_="1586682164129"></div>
          </div>
</div>
```
  
    

## 最终效果

以上例子从平台结果表中查询数据，然后构造绘制 echart 曲线图所需的数据格式，最后呈现出一个 IP 下主要进程 pid 的 CPU 使用情况，结果如下：

![image-20200412182915307](media/image-20200412182915307.png)



