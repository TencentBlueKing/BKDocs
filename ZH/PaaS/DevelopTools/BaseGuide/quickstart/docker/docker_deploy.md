# 发布你的应用

## 推送镜像
与提供源码部署的应用不同, 提供镜像的应用需要用户自行将镜像推送至 Docker Registry, 我们在上一步已在本地构建镜像, 现在让我们将镜像推送至腾讯镜像源吧！

```bash
# 重新打镜像标签
docker tag bk-helloworld mirrors.tencent.com/bkpaas/helloworld

# 推送！
docker push mirrors.tencent.com/bkpaas/helloworld
```

**注意事项：**
1. 推送镜像前需要确保已登录至腾讯镜像源提供的 Docker Registry   
2. 如果推送失败, 有可能是你没有 bkpaas/helloworld 这个命名空间的操作权限, 可以将镜像标签调整为 mirrors.tencent.com/{你的账号名}/helloworld

## 部署应用
关于部署应用，你可以阅读 [如何部署蓝鲸应用](../../topics/paas/deploy_intro.md) 了解更多。

### 发布到应用市场
在你部署到生产环境之前，你需要：
- 在『应用推广』-『应用市场』完善你的市场信息
- 部署到生产环境 

然后就能够直接在应用市场找到你的应用了 :)

## 下一步

恭喜你完成提供（容器）镜像来部署蓝鲸应用的开发教程，接下来你可以：

- 了解更多关于蓝鲸PaaS平台的内容
- 阅读 [开发指南](../../topics/company_tencent/python_framework_usage.md)，深入学习如何开发更优秀的蓝鲸应用
