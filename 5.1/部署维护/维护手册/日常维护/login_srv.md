## 蓝鲸日常维护

### 登陆指定服务器

一般维护操作时，均从中控机出发，跳转到其他模块服务器进行操作

假设发现作业平台模块启动失败，想登陆到作业平台模块所在服务器查看相关日志：

```bash
source utils.fc

# 这个命令用来加载环境变量（/data/install/*.env）和蓝鲸安装维护的函数（/data/install/*.{rc,fc})。
# 在该文档中，凡是提到查看 xx 函数的地方，可以用以下方法找到：
# source utils.fc;  type 函数名，例如想看 initdata_rabbitmq 做了什么事情，请运行 type initdata_rabbitmq ，返回的内容里可能也有没见过的函数调用，那继续使用 `type 函数名` 来查看
# grep "函数名 *()" *.rc *.fc 通过过滤函数定义，来寻找位置
#  编辑器内的搜索跳转
```

```bash
ssh $JOB_IP
# 因为 /data/install/config.env 里通过解析 install.config ，生成了模块对应的 IP ，所以，我们可以直接用 $MODULE_IP 这样的方式来访问。MODULE，用 install.config 里模块名的大写形式进行替换。譬如 bkdata 所在的 IP 为 $BKDATA_IP ，配置平台所在IP为 $CMDB_IP ，依此类推。
# 也可以输入 $ 符号后，用 <tab> 补全试试。
```