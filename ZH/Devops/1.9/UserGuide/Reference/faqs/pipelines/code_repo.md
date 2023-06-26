# 关联代码库

## Q1:关联GitLab代码库报错常见原因

![](../../../assets/repo_gitlab.png)

1、应该使用 Personal Access Tokens 而非项目令牌。

2、确认Access_Tokens生成时是否给予了对应权限。必须要包含对应的API权限。

3、如果是自建的 GitLab，请确认”repository/branches“API接口是否能通。

https://docs.gitlab.com/ee/api/branches.html

4、如果GitLab为https访问。请确认代码库是否有做 http-->https 跳转。BKCI默认以 http 方式进行代码库访问。

若未做跳转，请按此临时方案，修改BKCI文件：

```bash
vim /data/bkce/etc/ci/application-repository.yml

#修改application-repository.yml文件，把apiUrl 修改为 https
#gitlab v4.
gitlab:
apiUrl: https://devops.bktencent.com/api/v4
```

重启 BKCI-repository.service 服务

```systemctl restart BKCI-repository.service```



## Q2:无法关联 GitHub 代码库

目前BKCI与 GItHub 的对接还存在一些问题。如果一定要使用 GitHub 代码库，请按照此方法进行配
[如何关联 GitHub 代码库](https://bk.tencent.com/s-mart/community/question/3184?type=article)