# ConfigMap 数据定义

## 1. 配置模板说明

``` json
{
    "apiVersion":"v4",
    "kind":"configmap",
    "metadata":{
        "name":"template-configmap",
        "namespace":"defaultGroup",
        "labels":{
            "io.tencent.bcs.app.appid": "756",
            "io.tencent.bcs.cluster": "SET-SH-16111614092707",
            "io.tencent.bcs.app.moduleid": "5088",
            "io.tencent.bcs.app.setid": "1767"
        }
    },
    "datas":{
        "bcs.conf": {
            "type": "file",
            "content": "Y29uZmlnIGNvbnRleHQ="
        },
        "config-one": {
            "type": "http",
            "content": "http://adfasdasdasdfasdfad/a.txt"
        },
        "myftp": {
            "type": "ftp",
            "content": "ftp://path/to/a.txt",
            "RemoteUser": "myuyser",
            "remotePasswd": "nIGNvbnRleHQ="
        }
    }
}
```

* RemoteUser  //存储该文件第三方存储的用户名，如果请求需要认证
* remotePasswd   //密码

**bcs application**数据结构

```json
"configmaps": [
    {
        "name": "template-configmap",
        "items": [
            {
                "type": "env",
                "dataKey": "config-one",
                "KeyOrPath": "SECRET_ENV"
            },
            {
                "type": "file",
                "dataKey": "config_two",
                "dataKeyAlias": "config-two",
                "KeyOrPath": "/data/contianer/path/myfile.conf",
                "readOnly": false,
                "user": "root"
            }
        ]
    }
]
```

字段含义：(field comment)

* name：索引 configmap 名字 （index configmap name）
* type：
  * env：将 configmap 子项注入环境变量
  * file：将 configmap 注入文件
* dataKey：索引 configmap 中子项（subitem index in index configmap）
* KeyOrPath：在容器中绝对路径（absolute directory in container）
* readOnly：权限（permission, true or false）
* user：文件用户，默认 root，如果用户在系统中找不到，默认 root （file user, default value is root. default is root if user is not exist in OS）
