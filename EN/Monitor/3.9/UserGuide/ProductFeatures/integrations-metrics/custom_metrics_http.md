# Customize reporting HTTP JSON data format

Custom reporting allows users to report directly through HTTP without installing an Agent. A common method is to report in the program.

Custom reporting mainly involves registering custom reporting. Only after registering first can you perform reporting, which is divided into custom events and custom indicator data.

## Preliminary steps

**How custom indicator data reporting works**:

![-w2021](media/15769097214595.jpg)

## Function Description

Navigation: Integrations -> Custom Indicators -> New
![](media/16613200801474.jpg)

After the new creation is completed and data is received, indicator management is performed.
![](media/16613201573933.jpg)

Data review via inspection view
![](media/16613201923866.jpg)


### Report format description

```
{
         # Data channel identifier, required
         "data_id": 21212,
         # Data channel identification verification code, required
         "access_token": "cf0ee24141234132413wefwerqera9af3a",
         "data": [{
             #Indicator, required
         "metrics": {
             "cpu_load": 10
         },
             # Source identifier such as IP, required
             "target": "10.0.0.1",
             # Custom dimensions, optional
             "dimension": {
                 "module": "db",
                 "location": "guangdong",
                 # event_type is optional and is used to mark event types. The default is exception events.
                 # recovery: recovery event, abnormal: abnormal event
                 "event_type": "abnormal"
             },
             # Data time, accurate to milliseconds, optional
             "timestamp": 1661320521493
         }]
     }
```

### Usage Example-Customized Indicator Reporting

Example of reporting indicators using Python language requests library

```python
# -*- coding: utf-8 -*-
import datetime
import time
import requests
import json
import random
 
timestamp=int(time.time() * 1000)
 
#PROXY_IP
PROXY_IP='X.X.X.X' #You can fill in this IP in the direct connection area
PROXY_URL='http://%s:10205/v2/push/'%(PROXY_IP)
 
#data_id
DATA_ID=1500101 #Change to your own data_id
#access_token
ACCESS_TOKEN="XXXX" #Modify to your own access_token
 
result = requests.post(PROXY_URL, data=json.dumps({
     "data_id": DATA_ID,
     "access_token": ACCESS_TOKEN,
     "data": [{
         "metrics": { #metric data type
             "cpu_load": random.random(), #The indicator value must be a numeric type
             "mem_usage":random.random() #The indicator value must be a numeric type
         },
         "target": "0:10.0.0.1", #Change to your own device IP
         "dimension": {
             "module": "db", #The dimension must be a string
             "location": "guangdong" #The dimension must be a string
         },
         "timestamp": timestamp
     }]
}))
print(result.text)
```

Return content:

```python
{"code":"200","message":"success","request_id":"a75ad22e-3c4f-4481-9096-c4947bf47187","result":"true"}
```

### Custom command line tools

For details, please see [Introduction to custom command line tools](../integrations-events/custom_report_tools.md)

### Precautions

- The API frequency limit is 1000/min, and the maximum size of a single body report is 500KB; if there is a need to report larger amounts of data, please consider using a plug-in to report data.
- bkmonitorproxy deployment instructions
   - Directly connected area
     The deployment of direct-connected areas relies on the environment administrator to deploy commands provided by the monitoring background. It should be noted that the 10205 port of the deployed directly connected zone machine should remain available, and ensure that the network between the directly connected zone machine and this machine is available. The deployment operation command is as follows:

## Deploy a custom reporting server
### Binary version
```bash
# Log in to the central control machine
source /data/install/utils.fc
ssh $BKMONITORV3_MONITOR_IP
workon bkmonitorv3-monitor
# Execute deployment bkmonitorproxy
./bin/manage.sh deploy_official_plugin --plugin_name bkmonitorproxy --target_hosts ${target_ip},${target_ip}
```

> The target_ip filled in will be displayed on the page as the reported IP of cloud area 0 (directly connected area)

- Indirectly connected cloud areas
   - As long as a custom report is created, the non-directly connected cloud areas will automatically create and deliver configurations. You need to wait about 5 minutes. By default, it is deployed on the same server as GSE Proxy.

### Containerized version
Please refer to the deployment document operation: [Deployment Monitoring Log Package - Customized reporting server](../../../../../DeploymentGuides/7.1/install-co-suite.md#自定义上报服务器).