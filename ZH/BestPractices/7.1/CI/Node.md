# NodeJS Demo

本篇文章将指导你如何在 BKCI 编译**NodeJS**工程。

## 准备材料

- 一个 NodeJS 工程：<https://gitlab.com/BKCI/gs-maven.git>
- 一个包含 npm 命令的 CI 镜像：<https://hub.docker.com/r/bkci/ci>

## 详细步骤

1. 将准备好的 gitlab 代码库关联至 BKCI，[请参考]((../../../Devops/2.0/UserGuide/Quickstarts/Link-your-first-repo.md))
2. 创建一条空白流水线
3. 将 Linux 构建环境添加到 Job2-1，镜像地址填写：bkci/ci:latest
   ![pic](assets/examples_java_1.png)
4. 依次添加如下 3 个插件：
   1. Checkout Gitlab
      ![pic](assets/quickstart_4.png)
   2. Shell Scripts

      ```bash
      #!/usr/bin/env bash
      npm run test
      ```

   3. Upload artifacts
      ![pic](assets/examples_node_1.png)

5. 运行流水线，观察结果
![pic](assets/examples_node_2.png)
