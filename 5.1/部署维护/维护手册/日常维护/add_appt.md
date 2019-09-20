## 蓝鲸日常维护

### 单机部署增加一台 APPT

使用单机部署方案，虽然 install.config 里自动配置了 APPT 和 APPO 两个模块，但实际生效的只有 APPO 。部署蓝鲸官方的 SaaS，只需要 APPO 即可。

用户如果有自己开发 SaaS 应用，提测时，平台会提示没有可用的测试环境。这时需要扩充一个 APPT 环境。运维操作如下, 以下命令均在中控机上执行：

1. 新增一台服务器 (假设 IP 为 10.0.0.2) 作为 APPT ，机器配置 1 核 1G 以上即可，跑的测试 SaaS 越多，配置需求越高。

2. 登陆中控机，编辑 install.config , 新增一行
    ```bash
    10.0.0.2 appt
    ```
    并将原来 install.config 第一行中的 `APPO,APPT` 换成 `APPO`
3. 对 10.0.0.2 配置好 SSH 免密登陆。

4. 依次运行以下命令开始安装 APPT

    ```bash
    ./bkcec sync common
    ./bkcec sync consul
    ./bkcec sync appt
    ./bkcec install consul
    ./bkcec stop consul
    ./bkcec start consul
    ./bkcec install appt
    ./bkcec initdata appt
    ./bkcec start appt
    ./bkcec activate appt
    ```
5. 查看开发者中心->服务器信息中，类别为《测试服务器》的信息是否正确，状态是否激活。