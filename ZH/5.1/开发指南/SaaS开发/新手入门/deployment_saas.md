# 部署 SaaS 到测试/正式环境

## 创建测试环境和正式环境数据库

准备 MySQL Server，创建测试环境和正式环境数据库，确保 `install.config` 中配置的 `appt` 和 `appt` 服务器可访问该 DB

并修改 `config/prod.py` 和 `stag.py`

## 提交代码到仓库

- 安装 [Git](https://www.git-scm.com/download/win)

- 使用 `Git Bash` 右键打开项目根目录

    ![使用git打开目录](../assets/%E4%BD%BF%E7%94%A8git%E6%89%93%E5%BC%80%E7%9B%AE%E5%BD%95.png)

- 提交项目到仓库

```bash
git init
git remote add origin {GIT_Repository_URL}
git add .
git commit -m "add blueking framework2.0"
git push -u origin master
```

## 在开发者中心部署至测试环境和正式环境

- 测试环境部署

  `开发者中心` - `我的应用` - `部署` - `测试环境一键部署`

- 正式环境部署

   `开发者中心` - `我的应用` - `部署` - `正式环境一键部署`
