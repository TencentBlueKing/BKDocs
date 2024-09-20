## Develop Visualization SaaS

## Scenario

Business data has been accessed to the platform, and real-time calculations and offline calculations are performed at the same time, and the data is saved to the platform. **Data visualization** needs to be presented in the form of **views**.

This article introduces how to obtain the CPU usage data of an IP process (pid) from the platform to draw a curve chart.

## Prerequisites

- [Create a project on the platform and apply for a result data table permission for the project](../user-guide/user-center/projects.md)
- Be familiar with a scripting language, such as `Python`. This tutorial uses `Python` as an example
- [Use the platform's interface for data query](../user-guide/auth-management/token.md)

## Steps

- Code implementation to obtain data
- Echart draws curve graphs

 
### Code implementation to obtain data

```python
# -*- coding: utf-8 -*-
import json
import requests
BK_DATA_URL = 'http://<BK_PAAS_HOST>/api/c/compapi/data/v3/
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
data = res.get('data', {}).get('list', [])
# Construct the data format required to draw echart
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
  
### Echart draws a curve graph

   - JavaScript source code

     You need to first introduce JQuery, echarts and other dependent jsplainplain

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
                       show: true,
                       feature : {
                           mark: {show: true},
                           dataView: {show: true, readOnly: false},
                           magicType : {show: true, type: ['bar','line']},
                           restore : {show: true},
                           saveAsImage: {show: true}
                       }
                   },
                   calculable : true,
                   xAxis : [
                       {
                           type : 'category',
                           data: conf.data.xAxis
                       }
                   ],
                   yAxis : [
                       {
                           type: 'value',
                           splitArea : {show : true}
                       }
                   ],
                   series: conf.data.series
               });
            }
           function initEStandLineChart(conf){
               $.ajax({
                   url: conf.url,
                   type: 'GET',
                   dataType: conf.dataType,
                   success: function(res){
                       //Get data successfully
                       if (res.result){
                           createEStandLineChart({
                               selector: conf.containerId, // chart container
                               data: res.data, // chart data
                           });
                       }
                   }
               })
           }
</script>
   ```
  
   - HTML source code

   ```html
<div class="king-page-box">
           <div class="king-container clearfix">
               <div style="height: 300px; -webkit-tap-highlight-color: transparent; user-select: none; background-color: rgba(0, 0, 0, 0); cursor: default;" id="chart_1586682196265 " class="king-chart-box chart-line " _echarts_instance_="1586682164129"></div>
           </div>
</div>
```
  
    

## final effect

The above example queries data from the platform result table, then constructs the data format required to draw the echart curve, and finally presents the CPU usage of the main process pid under an IP. The results are as follows:

![image-20200412182915307](media/image-20200412182915307.png)