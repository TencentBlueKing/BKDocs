#!/bin/bash
set -eu

# 因为是SaaS，所以需要根据包名查询出所属的文档地址。
case $PACKAGE in
  bk_itsm) DEPLOY_DOC="[部署流程服务（bk_itsm）](../manual-install-saas.md#部署流程服务（bk_itsm）)";;
  bk_sops) DEPLOY_DOC="[部署流程服务（bk_sops）](../manual-install-saas.md#部署流程服务（bk_sops）)";;
  bk_cmdb_saas) DEPLOY_DOC="[部署流程服务（bk_cmdb_saas）](../manual-install-saas.md#部署流程服务（bk_cmdb_saas）)";;
  bk_lesscode) DEPLOY_DOC="[部署运维开发平台](../install-lesscode.md)";;
  bk_flow_engine) DEPLOY_DOC="[部署流程引擎服务](../install-flowengine.md)";;
  bk_notice) DEPLOY_DOC="[部署消息通知中心](../install-notice.md)";;
  *) echo >&2 "ERROR: unknown saas DEPLOY_DOC: $PACKAGE."; exit 5;;
esac

case $PACKAGE in
  bk_sops) setup_bkce7_cmd="sops";;
  bk_itsm) setup_bkce7_cmd="itsm";;
  bk_cmdb_saas) setup_bkce7_cmd="bk_cmdb_saas";;
  bk_notice) setup_bkce7_cmd="notice";;
  bk_lesscode) setup_bkce7_cmd="lesscode";;
  bk_flow_engine) setup_bkce7_cmd="flow_engine";;
  someone) setup_bkce7_cmd="";;
  *) echo >&2 "ERROR: unknown saas setup_bkce7_cmd: $PACKAGE."; exit 5;;
esac

echo >&2 "  RENDER: saas: setup_bkce7_cmd=$setup_bkce7_cmd, DEPLOY_DOC=$DEPLOY_DOC."

if [ -n "$setup_bkce7_cmd" ]; then
  cat <<EOF
#### 在中控机更新
在 **中控机** 下载：
\`\`\` bash
bkdl-7.2-stable.sh -ur latest ${PACKAGE}=${VERSION}
\`\`\`
在 **中控机** 更新：
\`\`\` bash
cd \$INSTALL_DIR/blueking/  # 进入工作目录
scripts/setup_bkce7.sh -i $setup_bkce7_cmd -f
\`\`\`
EOF
fi

cat <<EOF
#### 在浏览器里下载并更新
下载适用于蓝鲸 7.x 的安装包：
* [${PACKAGE}-V${VERSION}.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/${PACKAGE}/${PACKAGE}-V${VERSION}.tar.gz)

参考 《[更新安装包](../manual-install-saas.md#更新安装包)》文档上传安装包，无需调整环境变量，参考《${DEPLOY_DOC}》文档重新部署。

部署成功后，即可在桌面访问了。
EOF
