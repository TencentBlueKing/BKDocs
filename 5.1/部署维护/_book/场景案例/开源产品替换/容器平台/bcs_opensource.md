## 开源 bk-bcs-saas 替换社区版部署指南[基础版]

### 一、替换 bcs-cc

- 备份原社区版 `bcs` 目录，将开源 `bcs` 代码解压到中控机的 `/tmp` 目录下。

  ```bash
  mkdir -p /data/bcs_bak
  cp -a  /data/src/bcs/ /data/bcs_bak/
  ```

- 替换 `bcs/cc/bin/bcs_cc` 文件

  - 将编译生成的 `bcs_cc` 二进制文件替换到原 `/data/src/bcs/cc/bin/` 目录下

    ```bash
    rm -f /data/src/bcs/cc/bin/bcs_cc  # 删除原 bcs_cc二进制文件
    cp -a bcs-cc/bin/bcs_cc /data/src/bcs/cc/bin/  # 替换编译后生成的 bcs_cc 二进制文件
    ```

### 二、替换 bcs_web_console

- 替换 `bcs/web_console` 目录

  ```bash
  rm -rf /data/src/bcs/web_console/manage.py # 删除原文件
  rm -rf /data/src/bcs/web_console/backend # 删除原文件
  tar xf bcs-app/build/bcs_web_console-ce-20190619173651.tar.gz -C /data/src/  # 将开源构建的 backend 目录同步到 src下
  ```

### 三、替换 devops

- 备份原社区版 `devops` 目录，将开源 `devops` 代码解压到中控机的 `/tmp` 目录下。

  ```bash
   mkdir -p /data/devops_bak
   cp -a /data/src/devops /data/devops_bak  # 备份为开源目录
  ```
- 替换 `frontend/console` 目录

  ```bash
  rm -rf /data/src/devops/navigator/frontend/console/* # 删除原文件
  rsync -a bcs-projmgr/frontend/dist/*  /data/src/devops/navigator/frontend/console/ # 更新开源文件
  ```
- 替换 `gateway/lua` 目录

  ```bash
  rm -rf /data/src/devops/navigator/gateway/lua/*  # 删除原文件
  rsync -a bcs-projmgr/gateway/lua/*  src/devops/navigator/gateway/lua
  ```

- 替换 `devops/pm` 目录
  ```bash
  rm -f /data/src/devops/pm/project-admin.jar
  rsync -a bcs-projmgr/pm/release/service-project-1.0.0.jar /data/src/devops/pm/project-admin.jar
  ```

### 四、安装 bcs，devops

- 未安装 bcs
  - 安装 bcs

    ```bash
    ./bk_install bcs  # 集成安装
    ```

- 已安装 bcs
  - 停进程

    ```bash
    echo bcs devops | xargs -n 1 ./bkcec stop
    echo bcs devops | xargs -n 1 ./bkcec status
    ```

  - 备份原数据

    ```bash
    ssh $DEVOPS_NAVIGATOR_IP
    mv /data/bkce/devops /data/bkce/devops_bak
    ssh $DEVOPS_PM_IP
    mv /data/bkce/devops/pm /data/bkce/devops/pm_bak  
    ssh $BCS_CC_IP
    mv /data/bkce/bcs/cc /data/bkce/bcs/cc_bak
    ssh $BCS_WEB_CONSOLE_IP
    mv /data/bkce/bcs/web_console /data/bkce/bcs/web_console_bak    
    ```

  - 更新 devops

    ```bash
    ./bkcec sync bcs
    ./bkcec install devops
    ./bkcec upgrade devops
    ./bkcec start devops
    ./bkcec status devops
    ```

  - 更新 bcs

    ```bash
    ./bkcec sync bcs
    ./bkcec install bcs
    ./bkcec upgrade bcs  
    ./bkcec start bcs
    ./bkcec status bcs
    ```

### 五、验证

- 登陆 PaaS 平台，能否正常打开容器管理平台应用，各页面显示是否正常，数据上报是否正常。
