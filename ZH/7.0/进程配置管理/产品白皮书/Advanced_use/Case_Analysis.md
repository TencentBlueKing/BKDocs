### 进程配置管理 中的配置模版长啥样
 
```bash
###listen port
local_server_public_host=${ InnerIP }
local_server_public_port=8803
```
该配置文件中， local_server_public_host 的值需要填这个配置文件实例所在的主机的内网IP地址。在配置模版中可以通过全局配置变量 InnerIP 获取这个属性。（更多的全局变量可在模板编辑窗口内点击 “变量” 按钮获取）
进程配置管理 会在生成配置文件时，根据具体配置文件实例所在的主机，填充不同的 InnerIP 地址。

### 如何在配种模版中进行条件判断？

#### 写法一：使用函数封装条件判断
```bash
# auth_type 手Q=1, 微信=2
auth_type=${ seq_sq_wx("1", "2") }
```
在函数 seq_sq_wx 中封装条件判断逻辑：如果当前配置文件所在实例的主机是手Q区，函数输出第一个值 1，否则输出第二个值 2（seq_sq_wx 不是一个内置函数，我们后面的内容会详细介绍如何编写这个函数）

#### 写法二：使用 Python 表达式判断
```bash
# auth_type 手Q=1, 微信=2
auth_type=${ "1" if is_sq else "2" }
```
is_sq 是一个 bool 型的变量，它不是一个全局配置变量，您不能在模版中直接引用它，我们会在后面的内容中讲解它是如何产生的。

#### 写法三：使用 Mako 条件判断语句
```bash
# auth_type 手Q=1, 微信=2
% if is_sq:
auth_type=1
% else:
auth_type=2
% endif
```

### 如何获取 配置平台 自定义属性？
 
```bash
# 获取一个具体配置文件实例所在集群的属性 bk_set_name
db_domain=${ this.cc_set.attrib['bk_set_name'] }

# 如果要使用配置平台中集群的自定义属性，如 set_config 
db_domain=${ this.cc_set.attrib['set_config'] }
```
this 是一个 全局配置变量 ，表示当前实例在拓扑结构中所处的节点。通过 this 关键字可以获取一个具体配置文件实例所在的主机对象 this.cc_host 、模块对象 this.cc_module 和集群对象 this.cc_set

更多的属性以及用法，可在模板中沉浸 ${HELP} 变量来查看结果。

 

### 如何获取当前集群的所有主机的IP？

#### 业务配置模版部分

```bash
<ServerList>
% for host in get_hosts(SetName):
    <server ip="${host}" port="8080"/>
% endfor
</ServerList>
```

通过函数 get_hosts 获取一个指定集群的所有主机IP，然后通过Mako模版的for循环输出每一个IP地址的数据。（ SetName 是一个全局模版变量）

#### get_hosts 函数
 
```bash
def get_hosts(set_name):
    # 组装 XPath 查询语句，从 CC 中查询指定 SetName 的所有主机
    xpath = "Set[@SetName='%s']//Host" % set_name
    hosts = []
    for host in cc.xpath(xpath):
        # XPath 查询的结果是一个主机对象，包含了主机的所有属性
        # 通过一个循环取出 InnerIP 属性，放到一个列表中
        hosts.append(host.attrib['InnerIP'])
    # 返回存储了所有 InnerIP 的列表
    return hosts
```