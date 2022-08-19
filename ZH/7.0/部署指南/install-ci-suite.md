# 部署持续集成套餐

## 部署流水线（蓝盾）
先配置 coredns。

在 中控机 执行：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" devops.$BK_DOMAIN codecc.$BK_DOMAIN bktbs.$BK_DOMAIN
./scripts/control_coredns.sh list  # 检查添加的记录。
```

在 中控机 执行
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f 03-bkci.yaml.gotmpl sync  # 部署流水线。
# 在admin桌面添加应用，也可以登录后自行添加。
scripts/add_user_desktop_app.sh -u "admin" -a "bk_ci"
```
部署需 5 ~ 10 分钟。上述命令结束后，可在中控机检查所有 Pod 是否正常：
``` bash
kubectl get pod -A | grep bk-ci
```
然后您可以在桌面找到刚才添加的 “” 应用打开了。

访问域名为 `devops.$BK_DOMAIN`，[《基础套餐部署》文档的“配置用户侧的 DNS”章节](install-bkce.md#hosts-in-user-pc) 中已经配置了此域名。如果您的浏览器提示无此域名，请检查更新本地 hosts 文件。


