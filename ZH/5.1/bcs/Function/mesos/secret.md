# Secret 数据定义

## 1. 数据结构说明

``` json
{
    "apiVersion":"v4",
    "kind":"secret",
    "metadata":{
        "name":"template-secret",
        "namespace":"defaultGroup",
        "labels":{
            "io.tencent.bcs.app.appid": "756",
            "io.tencent.bcs.cluster": "SET-SH-16111614092707",
            "io.tencent.bcs.app.moduleid": "5088",
            "io.tencent.bcs.app.setid": "1767"
        }
    },
    "type": "",
    "datas":{
        "first-secret": {
            "path": "/path/to/store/in/vault",
            "content":"Y29uZmlnIGNvbnRleHQ="
        },
        "second-secret": {
            "path": "/path/to/store/in/vault",
            "content":"Y29uZmlnIGNvbnRleHQ="
        }
    }
}
```

字段含义：

* name：具体 secret 名字
* content：secret 内容

**bcs application**数据结构

```json
"secrets": [
    {
        "secretName": "mySecret",
        "items": [
            {
                "type": "env",
                "dataKey": "abc",
                "keyOrPath": "SRECT_ENV"
            },
            {
                "type": "file",
                "dataKey": "abc",
                "keyOrPath": "/data/container/path/myfile.conf",
                "readOnly": false,
                "user": "user00"
            }
        ]
    }
]
```

## 2. 工作机制和流程

数据**流转流程**

* bcs-client create --type secret --name template-secret --clusterid saldfkaslkdfj
  * --path vault 存储 path，必填
  * --file key:/path/to/file.conf 指定文件，文件大小不能超过 100k
  * --from-files dir 指定文件夹，根据文件名做 key，总大小不能超过 2M
  * --content key:content 直接指定具体内容
* bcs-apiserver（正常存入 vault？）
  * DELETE: 根据规则删除 secret
  * POST：存储 vault 中
  * GET: 查询 secret 信息
* bcs-route 流程
  * 查询 secret 信息，并入 taskgroup 请求，转发给 scheduler

**相关调整**工作

* apiserver 增加 secret 接口
  * post
  * get
  * delete
* bcs-route 数据解析
  * 捕获 secret 字段，提取 secret 具体内容
  * 转发给 bcs-scheduler
* bcs-client 增加 secret 子命令，参数如下
  * --path vault 存储 path，必填
  * --file key:/path/to/file.conf 指定文件，文件大小不能超过 100k
  * --from-files dir 指定文件夹，根据文件名做 key，总大小不能超过 2M
  * --content key:content 直接指定具体内容
