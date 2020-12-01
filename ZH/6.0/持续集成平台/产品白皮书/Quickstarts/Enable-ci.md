# 为你的 Git 工程开启 CI

## 准备事项

- 一个 gitlab 工程

如没有，请参考[关联你的第一个代码库](Link-your-first-repo.md)

- 一个 bk-ci 项目
- 了解[流水线基本概念和使用](../Concepts/Learn-pipeline-in-5min.md)

## 通过 BK-CI 监听代码库 push 事件

1. 创建一条空白流水线
2. 在 Job1-1 中添加触发器：GitLab![gitlab](../assets/quickstart_4.png)

3. 添加 Job2-1，用来执行具体的编译任务

   ![gitlab](../assets/quickstart_5.png)

4. 依次添加如下 3 个插件：

   - Checkout GitLab

     ![gitlab](../assets/quickstart_7.png)

   - Shell Script

     ![shell](../assets/quickstart_8.png)

   - Upload artifacts

     ![shell](../assets/quickstart_9.png)
