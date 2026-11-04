# 手动卸载 Agent

正常情况下请优先使用节点管理页面上的「卸载」功能。当卸载任务异常、需要手动清理时，可参考以下步骤。

> 以下路径以默认部署配置为例：Linux 安装目录为 `/usr/local/<env>/`（`<env>` 为后端配置中的 GSE 环境标识，如 `gse2`），工作目录为 `/tmp/bknm/`；Windows 安装目录默认为 `C:\` 下对应目录。实际路径请以部署时 `gseDeployConfs` 中 `baseDeployDir` / `baseWorkDir` 的配置为准。

## Linux 手动卸载 Agent

1. 在节点管理页面执行「移除 Agent」。

2. 到配置平台（CMDB）把主机删除（如果需要重装 Agent 并且安装在同一个业务下，可以不删除：把主机转移到空闲机 → 转移到主机池，切换到主机池删除即可）。

3. 停止进程：

```bash
/usr/local/<env>/bin/gsectl stop
```

4. 删除目录（以实际安装目录为准）：

```bash
rm -rf /run/<env>
rm -rf /var/lib/<env>
rm -rf /var/log/<env>
rm -rf /usr/local/<env>
rm -rf /tmp/bknm
```

## Windows 手动卸载 Agent

1. 在节点管理页面执行「移除 Agent」。

2. 到配置平台（CMDB）把主机删除（同上，如需重装到同一业务可以不删除）。

3. 停止服务：

```bat
cd c:\<env>\agent\bin
gsectl.bat stop
```

4. 删除安装目录与工作目录（默认 `C:\<env>` 与 `C:\tmp\bknm`，以实际部署配置为准）。
