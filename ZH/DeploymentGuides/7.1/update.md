# 单产品更新
我们在蓝鲸 7.1.0 版本发布后，为部分产品提供了新版本，详见各项目下的更新信息表格。

## GSE Agent
|  | 软件版本号 |
|--|--|
| 7.1.0 发布 | 2.1.2-beta.20 |
| 20230808 问题修复 | 2.1.3-beta.3 |

本次主要修复了 job 普通用户传输文件时丢失可执行权限的问题。

登录到 **中控机**，下载 GSE Agent 2.1.3-beta.3 版本：
``` bash
bkdl-7.1-stable.sh -ur latest gsec=2.1.3-beta.3
```

上传 Agent 到 节点管理：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/setup_bkce7.sh -u agent
```

随后访问“节点管理”，在 “Agent 状态”界面勾选待升级的 Agent，展开“批量”菜单，选择“升级”，即可进入升级界面。

遵循界面指引完成升级过程，等待 Agent 上报新的版本号，即升级完成。

