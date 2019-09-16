## 注册主机到 CMDB

成功的进行手动安装 agent/proxy/pagent 后，需要手动将客户端节点注册到 CMDB 中，方法如下：

- 找一台安装了 curl 命令同时能访问到 Nginx 的机器。
- 登陆机器执行以下命令。
获取 CLOUD_ID（云区域 ID ）。详情参考 [新增云区域](4.产品功能/agent.md#Cloudarea) 。

```plain
**[terminal]
**[prompt root@rbtnode1 ]**[path ~]**[delimiter # ]
**[prompt root@rbtnode1 ]**[path ~]**[delimiter # ]
**[prompt root@rbtnode1 ]**[path ~]**[delimiter # ]**[command curl -s -X POST \
        -H 'cache-control: no-cache' \
        -H 'content-type: application/x-www-form-urlencoded' \
        -H 'BK_USER: admin' \
        -H 'HTTP_BLUEKING_SUPPLIER_ID: 0' \
        -H 'HTTP_BLUEKING_LANGUAGE: zh-cn' \
        -d ip=<IP_ADDR> \
        -d appName=<想注册到CMDB中的业务名称> \
        -d platId=<CLOUD_ID> \
        $post_args http://<CMDB_HOST>:<NGINX_PORT>/api/host/addhost]
```

若脚本返回如下信息表示注册成功：`{"code":0,"data":""}` 。

> **[info] Note:**
>
> 1. 注意替换上述命令中的 CLOUD_ID, IP_ADDR, CMDB_HOST,NGINX_PORT 为实际值。
> 2. 若一台机器上有多个 IP，则需要填写 get_lan_ip 函数中获得的第一个 IP。
> 3. 若执行安装过程中，使用了 -e 选项输入 IP，则注册时填写 -e 选项后面的 IP 。
