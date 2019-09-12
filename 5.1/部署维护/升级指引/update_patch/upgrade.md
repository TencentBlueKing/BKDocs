## 补丁包常规更新通用操作指南

- 下载补丁包上传到中控机
   - 以 open_paas 补丁包更新为例：

   ```bash
   tar xf open_paas_ce-x.x.x.tgz -C  src/    #解压到src目录下
   cd install/
   ./bkcec stop paas
   ./bkcec upgrade paas
   ./bkcec start paas
   ./bkcec status paas #状态正常，页面访问正常
   ```
