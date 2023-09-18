# 安装 Agent 常见报错
## 常见报错一：安装 agent 报 utf-8 问题

- 产品版本： 2.0.927
- 报错信息：
```bash
[2022-03-30 16:08:57 ERROR] Traceback (most recent call last):
  File "/data/bkce/bknodemandeman/apps/backend/utils/ssh.py", line 445, in send_cmd
UnicodeDecodeError: 'utf-8' codec can't decode byte 0xba in position 450: invalid start byte
During handling of the above exception, another exception occurred:
```
![](../assets/002.png)

**解决方案：** 
[https://bk.tencent.com/s-mart/community/question/7033](https://bk.tencent.com/s-mart/community/question/7033)

## 常见报错二: 部署插件程序-下发安装包 失败
```bash
[2022 06-15 16:20:58 ERROR] [processbeat] 部署插件程序-下发安装包 失败，[basereport] 部署插件程序-下发安装包失败，[exceptionbeat ]部署插件程序-下发安装包失败 ➊[2022- 06-15 16:20:58 ERROR] 安装预设插件失败，请先尝试查看日志并处理，若无法解决，请联系管理员处理。
```
![](../assets/003.png)

**解决方案**
[https://bk.tencent.com/s-mart/community/question/8142?type=article](https://bk.tencent.com/s-mart/community/question/8142?type=article)