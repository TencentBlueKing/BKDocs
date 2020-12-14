## 拉取镜像

提前在构建机拉取测试镜像，然后在创建流水线时选择手动填写镜像。
注意：构建机需要能访问 Docker hub 。用户亦可自行修改 `/etc/docker/daemon.json` 指定私有 registry 。
```bash
pcmd -m ci_dockerhost 'docker pull bkci/ci'
```