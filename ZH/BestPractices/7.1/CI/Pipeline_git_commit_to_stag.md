# 测试环境自动更新

## 情景

开发同学完成功能开发、本地测试通过后，运维通过自动化工具或人工登录服务器更新，由于开发和运维存在 **沟通成本**，导致持续集成的测试环节效率低下，影响整体研发效率。

接下来看蓝盾（BK-CI）是如何做到 **测试环境自动更新**。

## 前提条件

- [部署蓝盾（BK-CI）](../../../DeploymentGuides/7.1/install-ci-suite.md)

## 操作步骤

- 配置自动构建流水线
- 提交代码（Git Commit）验证

### 配置自动构建流水线

![bk-ci-demo](assets/bk-ci-demo.png)

### 提交代码（Git Commit）验证

下面为一次自动更新记录，从 **提交代码到更新测试环境**，**不到 1 分钟**。

{% video %}https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/bk_solutions/CI/assets/bk-ci-demo-HD.mp4{% endvideo %}
