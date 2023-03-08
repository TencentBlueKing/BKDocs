# 构建资源
用户可以通过在自己机器上安装蓝盾agent，将自己的机器托管到蓝盾上，使其成为私有构建机资源，在流水线里可以选择私有构建机。

## 私有构建机agent包
蓝盾私有构建支持Mac、linux、windows，蓝盾部署完成后，默认只有linux系统的蓝盾agent安装包，Mac和windows需要手动打包。打包步骤：

1. 下载mac和windows的jdk8，将jdk包上传到中控机/data/src下，下载链接：https://adoptium.net/temurin/releases/?version=8
   
   ![image-jdk8-download](../../assets/image-jdk8-download.png)

2. 打包，中控机上执行
    ```bash
    # 假设mac jdk8包是OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz
    # windows jdk8包是OpenJDK8U-jdk_x64_windows_hotspot_8u292b10.zip
    # 执行下述操作打包
    jdk_windows="/data/src/OpenJDK8U-jdk_x64_windows_hotspot_8u292b10.zip"
    mkdir -p /data/src/bkci-agent-package-patch/jre/macos /data/src/bkci-agent-package-patch/jre/windows
    /data/src/ci/scripts/bk-ci-gen-jrezip.sh macos "$jdk_macos" /data/src/bkci-agent-package-patch/jre/macos/jre.zip
    /data/src/ci/scripts/bk-ci-gen-jrezip.sh windows "$jdk_windows" /data/src/bkci-agent-package-patch/jre/windows/jre.zip
    
    cd /data/src/bkci-agent-package-patch/jre/macos
    mkdir -p Contents/Home
    unzip jre.zip -d Contents/Home/
    zip -r jre.zip Contents
    mkdir -p /data/src/bkci-agent-package-patch/packages/windows/
    ```
3. 下载unzip二进制包并解压，将bin/unzip.exe上传到中控机/data/src/bkci-agent-package-patch/packages/windows/目录下，unzip包下载链接参考：http://gnuwin32.sourceforge.net/packages/unzip.htm
   
    ![image-unzip-download](../../assets/image-unzip-download.png)

4. 然后重新部署蓝盾，从标准运维模板 “蓝鲸持续集成部署或升级流水线” 新建任务并执行，版本号和上次部署一样
5. 机器安装蓝盾agent，添加为私有构建机

