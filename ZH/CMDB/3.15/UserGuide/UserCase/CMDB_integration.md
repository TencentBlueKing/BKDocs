# 企业原有 CMDB 同步至蓝鲸 CMDB

> 感谢社区用户 [kevin1024](https://bk.tencent.com/s-mart/personal_center/user/10966) 提供该文档.

## 情景

公司基础部门维护公司统一的一套 CMDB，资源主要以服务器为主，资源交付后会直接进入公司的 CMDB，需要手动导出列表，修改成蓝鲸 CMDB 的导入格式，导入蓝鲸 CMDB。存在如下问题：

- 资源交付后需要手动导出、导入，少量机器频繁交付，为了让机器及时加入蓝鲸管控，需要频繁人工参与
- 公司 CMDB 与蓝鲸 CMDB 字段不统一，需要手动复制、编辑字段属性，再导入蓝鲸，非常繁琐

## 前提条件

- 在配置平台中 [新建好业务](../QuickStart/case1.md)。
- 熟悉一门脚本语言，如 `Python`，本教程以 `Python` 为例
- 了解 蓝鲸 CMDB API

## 操作步骤

- 梳理同步逻辑
- 代码实践及解读
- 定时同步

### 梳理同步逻辑

查询公司 CMDB 与蓝鲸 CMDB 服务器属性的对应关系，生成属性映射 MAP 表，MAP 表中只记录需要关注的属性，并确认相关属性都已在蓝鲸 CMDB 中创建。

**新增资源**

- 通过接口查询公司 CMDB，获取自己所在业务部门下的全量服务器列表
- 通过接口获取蓝鲸 CMDB 的服务器列表
- 遍历两个列表，找出蓝鲸 CMDB 中没有的服务器，汇总成列表，并通过接口录入到蓝鲸 CMDB

**更新资源**

- 分别获取两个 CMDB 的数据，遍历两组数据，对比属性 MAP 表中的属性字段，找出数据不同的服务器，汇总成列表，再统一更新到蓝鲸 CMDB

### 代码实践及解读

#### 新建应用

在蓝鲸开发者中心 新建一个应用，用于调用 CMDB 的 API。

```python
import urllib2
import json
import logging

PAAS_API = 'https://paas.bk.com' # 蓝鲸 PaaS 地址

logging.basicConfig(level=logging.DEBUG,
    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
    datefmt='%a, %d %b %Y %H:%M:%S',
    filename='./update.log',
    filemode='a')

BASE_ARGS = {
    '''
    接口调用中的通用参数
    蓝鲸中新建一个应用，获取相关应用信息
    并在https://paas.bk.com/admin/bkcore/functioncontroller/中添加认证白名单，否则调用CMDB     接口会失败，参考： 开发者中心-API网关-使用指南-API调用说明
    '''
    'bk_app_code': 'sync-cmdb',  # 应用 ID
    'bk_app_secret': 'xxxx-xxxxxxxxxxxx', # 应用 Token
    'bk_username':'user.name' # 蓝鲸系统中的用户名
    }
```

#### 获取蓝鲸 CMDB 主机列表

查询蓝鲸 CMDB 的获取主机 `search_host` API ，返回主机列表

```python
def getBkCmdbHost():
    # 查询蓝鲸CMDB，返回主机列表
    bkList = {}
    url = PAAS_API + '/api/c/compapi/v2/cc/search_host/' # api请求地址
    apiArgs = {
        # api相关参数，参考https://paas.bk.com/esb/api_docs/system/CC/search_host/
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

#### 获取 公司 CMDB 主机列表

调用公司 CMDB 获取主机列表 API，返回主机列表

```python
def getCmdbHost():
    # 根据企业内部接口自己实现，返回IP信息列表
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

#### 生成新增 IP 列表、更新 IP 列表、更新信息列表

根据 **获取蓝鲸 CMDB 主机列表**操作步骤 和  **获取 公司 CMDB 主机列表**操作步骤 获取到的两个主机列表，对比生成所需的新增列表和更新列表。

```python
def genAddList(cmdbList, bkList):
    # 对比两个列表，返回新增IP列表
    addList = []
    for k in cmdbList.keys():
        if k not in bkList.keys():
            #print k, cmdbList[k]
            addList.append(k)
    return addList

def genUpdateList(cmdbList, bkList):
    # 对比两个列表，生成需要更新的IP列表
    ipList = []
    attrMAP = {k: v for k, v in attributeMAP.items() if v is not None} # 过滤出自己关心的主机属性
    for ip, cmdbHost in cmdbList.items():
        if ip not in bkList.keys():
            continue
        bkHost = bkList[ip]
        for cmdbAttr, bkAttr in attrMAP.items():
            if cmdbAttr in cmdbHost.keys() and bkAttr in bkHost.keys() and cmdbHost[cmdbAttr] != bkHost[bkAttr]:
                ipList.append(ip)
    return ipList

def genInfoList(cmdbList, bkList, ipList, attributeMAP):
    # 根据IP列表生成主机详细信息列表
    infoList = {}
    attrMAP = {k: v for k, v in attributeMAP.items() if v is not None}
    for ip in ipList:
        ipInfo = {}
        for k, v in attrMAP.items():
            if k in cmdbList[ip].keys():
                ipInfo[attrMAP[k]] = cmdbList[ip][k]
        if ip in bkList.keys(): #添加bk_host_id
            ipInfo['bk_host_id'] = bkList[ip]['bk_host_id']
        infoList[ip] = ipInfo
    return infoList

attributeMAP = {
    # 属性对应列表，值为None的字段不关心，不录入蓝鲸cmdb
    'AssetNo':          'bk_asset_id',          #资产编号
    'SN':               'bk_sn',                #序列号
    'Manufacture':      'machine_manufacturer', #厂商
    'ManufactureType':  'machine_model',        #厂商型号
    'MachineType':      'machine_type',         #MachineType
    'HostName':         None,                   #主机名
    'IP':               'bk_host_innerip',      #IP
    'BusinessIP':       'bk_host_bizip',        #业务IP
    'PublicIP':         'bk_host_outerip',      #公网IP
    'VNetIP':           'bk_host_usernetip',    #用户网IP
    'tags':             None,                   #资产类型
    #其它...
}

addList = genAddList(cmdbList, bkList)
updateList = genUpdateList(cmdbList, bkList):
addInfoList = genInfoList(cmdbList, bkList, addList, attributeMAP)
updateInfoList = genInfoList(cmdbList, bkList, addList, attributeMAP)
```

#### 录入、更新主机数据到蓝鲸 CMDB

- 录入新增主机信息：使用  **生成新增 IP 列表、更新 IP 列表、更新信息列表**操作步骤 中生成的新增主机信息列表，录入蓝鲸 CMDB

```python
def addBkCmdbHost(infoList):
    # 录入新增数据到cmdb
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

- 更新主机数据：使用 **生成新增 IP 列表、更新 IP 列表、更新信息列表**操作步骤 中生成的更新主机信息列表，更新蓝鲸 CMDB

```python
def updateBkCmdbHost(infoList):
    # 更新数据到cmdb
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

### 定时同步

- CMDB 同步脚本使用 JOB 的定时作业或 标准运维 的定时任务进行周期托管，方便迁移或者修改维护

![1562225679643](../media/1562225679643.png)

注：上述教程是企业 CMDB `单向`、`定期`同步主机实例至蓝鲸 CMDB 的实践，如果需要实时同步，一般推荐 事件订阅 的方式。
