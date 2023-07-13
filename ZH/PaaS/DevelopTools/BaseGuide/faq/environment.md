# 开发环境与配置类

### pip install 安装某个包时，提示包未找到

可能是仓库源配置问题。建议使用腾讯云提供的 PYPI 源: `mirrors.cloud.tencent.com/pypi/simple/`

如果使用了腾讯云的 pypi 源，仍旧无法安装，例如
```bash
Looking in indexes: http://mirrors.cloud.tencent.com/pypi/simple/
Collecting blueking-component-ieod==0.0.68
  Could not find a version that satisfies the requirement blueking-component==0.0.68 (from versions: )
No matching distribution found for blueking-component==0.0.68
You are using pip version 18.0, however version 20.1.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```
主要的原因是 pip 版本过旧，请升级到 >=19.0 的版本重试。

### 如何安装私有 Python 包

这个问题可以拆分成两个流程，分别是 如何上传私有的包 以及 如何在 v3 应用上安装私有的包。

Q: 如何上传私有的包
A: 使用蓝鲸制品库提供的 PyPI 源服务上传私有 python 包，具体参考蓝鲸制品库的API文档

Q: 如何在 v3 应用上安装私有的包
A: 可以通过 requirement.txt 的高级用法增加额外的PyPI源, 具体的操作参考以下内容:

```bash
# 在 requirements.txt 末尾追加以下内容
# 参数解释: --extra-index-url 指定PyPI源作为额外源
--extra-index-url https://your_pip.bking.com/repository/pypi/simple/
# 参数解释: --trusted-host 信任腾讯内部源域名
--trusted-host your_pip.bking.com
# 接下来就可以如往常一样, 在此处追加私有 Python 包
# e.g.
blue-krill >= 0.0.7
bkuser >= 0.0.1
```


### 需要在外部服务添加 IP 白名单时，如何获取应用出口 IP？

平台提供了“出口 IP 管理”服务，专门供应用访问一些需要校验 IP 白名单的服务时使用。

功能入口：

- 进入应用的“模块管理”管理页面
- 打开对应环境的“获取出口 IP”链接

### 如何使用独立域名访问应用？

当你部署完应用后，可以用平台提供的独立子域名（旧版本为子路径）来访问应用。这个访问地址是平台按照规则生成的，不可修改。假如你想使用其他域名来访问应用，可以参考下面的流程来操作：

1. 添加域名记录
    - 切换到你想配置域名的应用与模块
    - 访问功能页面：“应用引擎” → “访问入口” → “独立域名配置”
    - 选择预发布或生产环境，添加你想使用的独立域名，比如：foo.bking.com，保存
    - 点击“IP 管理”处，记录下此处展示的域名解析目标 IP，如：x.x.x.x
    > 在进行步骤 2 前，你可以修改本地 Hosts 文件，配置 x.x.x.x foo.bking.com，先测试是否能正常通过域名访问应用。

2. 申请域名并配置解析
