# 代码库管理页

在本页面，你可以将企业已有的代码库关联至 BKCI，也可以查阅已关联的代码库列表。

## 关联 gitlab 代码库

![png](../../assets/service_repos_link.png)

点击关联代码库后可弹出“关联代码库”的弹窗，会收集代码库的基本信息：

1. 源代码地址：可以通过 BKCI 服务端正常访问的 gitlab 仓库地址，以 http/https 开头，以.git 结尾；
2. 别名：关联后在 BKCI 里显示的名字，这个别名会在流水线中关联代码库时显示，整个项目下唯一；
3. 访问凭证：点击右侧**新增**按钮可跳转到凭证管理中添加凭证。

## 接下来你可能需要

- [控制台](../Console/Console.md)
- [创建你的第一条流水线](../../Quickstarts/Create-your-first-pipeline.md)