 # Synchronize the original CMDB to BlueKing CMDB 

 > Thanks to community user [Kevin](https://bk.tencent.com/s-mart/personal/10966/) for provided The The document. 

 ## Scenario 

 The Base department of the company maintains a unified set of CMDB of the company. The resources are mainly service. After the resources are delivered, they will directly Enter the CMDB of the company. You need to manual exportPipelineJson the list, Revise it into the import format of BlueKing CMDB, and import BlueKing CMDB.  The following problems exist: 

 - resources need to be exportPipelineJson and import manual after delivery, and a small number of machines are delivered frequently. In order to enable the machines to join the BlueKing control in time, frequent manual participation is required 
 - The Field in the Company CMDB and BlueKing CMDB are not uniform. You need to manual copy and edit the field attributes before import BlueKing, which is very tedious 

 ## Prerequisites 

 - In the CMDB,[add New Business Name](../../../CMDB/UserGuide/QuickStart/case1.md). 
 - Be familiar with One Script language, such as `Python`. This tutorial takes `Python` as an example. 
 - Learn about BlueKing CMDB API 

 # Operation 

 - combing synchronization logic 
 - Code practice and interpretation 
 - timing synchronization 

 ### Combing Synchronization Logic 

 Query the corresponding relationship between the company CMDB and BlueKing CMDB service attributes, Generate an attribute mapping MAP table, in which only the attributes to be concerned are recorded, and Confirm that the relevant attributes have been create in BlueKing CMDB. 

 **new resources** 

 - Query the company CMDB approve the API to obtain the list of All service in your Business Name department 
 - Get the list of BlueKing CMDB service approve API 
 - Iteration two lists to find the service that are not in BlueKing CMDB, summarize them into a list, and enter them into BlueKing CMDB approve the API 

 **Update resources** 

 - Obtain data of two CMDB respectively, Iteration two groups of data, Compared attribute Field in attribute MAP table, find out service with different data, summarize them into a list, and then uniformly Update to BlueKing CMDB 

 ### Code Practice and Interpretation 

 #### New Application 

 Create One new Application in the BlueKing Developer Center to call the CMDB API. 

 ```python 
 import urllib2 
 import json 
 import logging 

 PAAS_API = 'paas.bk.com' #BlueKing PaaS address 

 logging.basicConfig(level=logging.DEBUG, 
    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s', 
    datefmt='%a, %d %b %Y %H:%M:%S', 
    filename='./  update.log', 
    filemode='a') 

 BASE_ARGS = { 
    ''' 
    general Parameter in interface calls 
    Create One new Application in BlueKing and get relevant Application Information 
    append the authentication whiteList in https://paas.bk.com/admin/bkcore/functioncontroller/, otherwise call CMDB     The API will failed. For more information, please see Developer Center-API Gateway-Guide-API Call Description 
    ''' 
    'bk_app_code':'sync-cmdb', #App ID 
    'bk_app_secret':'xxxx-xxxx', #Apply Token 
    'bk_username':'user.name' #username in BlueKing 
    } 
 ``` 

 #### Get the list of BlueKing CMDB CVMs 

 Query Host `search_host` API of BlueKing CMDB to Return the host list. 

```python
def getBkCmdbHost():
    #  Query BlueKing CMDB and Return Host list 
    bkList = {} 
    url = PAAS_API + '/api/c/compapi/v2/CC/search_host/' # api Request Url 
    apiArgs = { 
        # API related Parameter, see paas.bk.com/esb/api_docs/system/CC/search_host/ 
        'condition':[ 
            { 
                "bk_obj_id": "host", 
                "fields": [], 
                "condition": [] 
            }] 
    } 

    args = dict(BASE_ARGS.items() + apiArgs.items()) 
    data = json.dumps(args) 
    request = urllib2.Request(url, data=data) 
    response = urllib2.urlopen(request) 
    content = response.read() 
    j_content = json.loads(content) 
    for item in j_content['data']['info']: 
        bkList[item['host']['bk_host_innerip']] = item['host'] 
    return bkList 
 ``` 

 #### Get the list of CMDB CVMs in the company 

 Call the company CMDB get the Host list, and Return the host list 

 ```python 
 def getCmdbHost(): 
    #Implement it according to the internal interface of the enterprise, and Return the IP information list 
    ''' 
    infoList = [ 
        "ip1": { 
            "sn": "xxxx", 
            "service_term": 3, 
            ... 
        }, 
        "ip2": {}, 
        ... 
    ] 
    ''' 
 ``` 

 #### Generate new IP list, Update IP list and update information list 

 According to the two host lists obtained in **Obtain BlueKing CMDB Host List** Operation and **Obtain Company CMDB Host List**, Generate the required new list and Update list by comparison. 

 ```python 
 def genAddList(cmdbList, bkList): 
    #Compared the two lists and Return the list of new IPs 
    addList = [] 
    for k in cmdbList.keys(): 
        if k not in bkList.keys(): 
            #print k, cmdbList[k] 
            addList.append(k) 
    return addList 

 def genUpdateList(cmdbList, bkList): 
    #Compared the two lists to Generate a list of IPs to be Update 
    ipList = [] 
    attrMAP = {k: v for k, v in attributeMAP.items() if v is not None 
    for ip, cmdbHost in cmdbList.items(): 
        if ip not in bkList.keys(): 
            continue 
        bkHost = bkList[ip] 
        for cmdbAttr, bkAttr in attrMAP.items(): 
            if cmdbAttr in cmdbHost.keys() and bkAttr in bkHost.keys() and cmdbHost[cmdbAttr] != bkHost[bkAttr]: 
                ipList.append(ip) 
    return ipList 

 def genInfoList(cmdbList, bkList, ipList, attributeMAP): 
    #Generate a list of Host details based on the IP list 
    infoList = {} 
    attrMAP = {k: v for k, v in attributeMAP.items() if v is not None} 
    for ip in ipList: 
        ipInfo = {} 
        for k, v in attrMAP.items(): 
            if k in cmdbList[ip].keys(): 
                ipInfo[attrMAP[k]] = cmdbList[ip][k] 
        if ip in bkList.keys():#append bk_host_id 
            ipInfo['bk_host_id'] = bkList[ip]['bk_host_id'] 
        infoList[ip] = ipInfo 
    return infoList 

 attributeMAP = { 
    #List of attribute correspondences. Don't care about the Field with the value of None, and don't enter the BlueKing CMDB 
    'AssetNo':          'bk_asset_id',          #Asset Number 
    'SN':               'bk_sn',                #index Number 
    'Manufacture':      'machine_manufacturer',#manufacturer 
    'ManufactureType':  'machine_model',        #Manufacturer Model 
    'MachineType':      'machine_type',         #MachineType 
    'HostName':         None,                   #cpuName 
    'IP':               'bk_host_innerip',      #IP 
    'BusinessIP':       'bk_host_bizip',        #Business Name IP 
    'PublicIP':         'bk_host_outerip',      #Public IP 
    'VNetIP':           'bk_host_usernetip',    #user IP 
    'tags':             None,                   #type of Assets 
    #Other... 
 } 

 addList = genAddList(cmdbList, bkList) 
 updateList = genUpdateList(cmdbList, bkList): 
 addInfoList = genInfoList(cmdbList, bkList, addList, attributeMAP) 
 updateInfoList = genInfoList(cmdbList, bkList, addList, attributeMAP) 
 ``` 

 #### Enter and Update Host data to BlueKing CMDB 

 - Enter new Host information: Use the new CVM information list generated in ** Generate new IP list, Update IP list, update information list * Operation steps to enter the new CVM information list into BlueKing CMDB 

 ```python 
 def addBkCmdbHost(infoList): 
    #Enter new data into CMDB 
    ''' 
    infoList = [ 
        "ip1": { 
            "bk_sn": "xxxx", 
            "bk_service_term": 3, 
            ... 
        }, 
        "ip2": {}, 
        ... 
    ] 
    ''' 

    ipInfoList = {} 
    for k, v in enumerate(infoList.values()): 
        v['bk_cloud_id'] = 0 
        v['import_from'] = '3' 
        if 'bk_host_id' in v.keys(): 
            del(v['bk_host_id']) 
        #print k, v 
        ipInfoList[str(k)] = v 

    url = PAAS_API + '/api/c/compapi/v2/cc/add_host_to_resource/' 
    apiArgs = { 
        'host_info': ipInfoList 
    } 

    args = dict(BASE_ARGS.items() + apiArgs.items()) 
    logging.debug(args) 
    data = json.dumps(args) 
    request = urllib2.Request(url, data=data) 
    response = urllib2.urlopen(request) 
    content = response.read() 
    print content 

 addBkCmdbHost(addInfoList) 
 ``` 

 - Update Host data: Use the updated CVM information list generated in **Generate new IP List, Update IP List and Update Information List** to update BlueKing CMDB 
```python
def updateBkCmdbHost(infoList):
    #  Update data to CMDB 
    url = PAAS_API + '/api/c/compapi/v2/cc/update_host/'
    for ip, ipInfo in infoList.items():
        bk_host_id = ipInfo['bk_host_id']
        del(ipInfo['bk_host_id'])
        apiArgs = {
            'bk_host_id': bk_host_id,
            'data': ipInfo
        }

        #print apiArgs
        args = dict(BASE_ARGS.items() + apiArgs.items())
        logging.debug(args)
        data = json.dumps(args)
        request = urllib2.Request(url, data=data)
        response = urllib2.urlopen(request)
        content = response.read()
        logging.debug('bk_host_id: ' + str(bk_host_id) + content)
        print json.loads(content)

updateBkCmdbHost(updateInfoList)
```

 ### Timing Synchronization 

 - CMDB synchronization Script are periodically hosted by JOB scheduled jobs or Standard OPS Cron for easy migrate or Revise maintenance 

 ![1562225679643](../media/1562225679643.png) 

 Note: The above tutorial is the practice of `one-way` and `regular` synchronization of Host instances to BlueKing CMDB. If Real time synchronization is required, event subscription is generally Recommended. 
