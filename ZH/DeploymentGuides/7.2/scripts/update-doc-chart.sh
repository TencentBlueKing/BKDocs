#!/bin/bash
set -eu

# 因为是chart，所以需要根据包名查询出
CHART_REPO=blueking
IFS=$'\t' read -r CHART_NAME HELMFILE_PATH K8S_NS HELM_RELEASE _ < <(
  awk -v CHART_NAME="$PACKAGE" '$1==CHART_NAME' scripts/chart-release.tsv
)

echo >&2 "  RENDER: chart: $CHART_REPO/$CHART_NAME; release in $HELMFILE_PATH: $K8S_NS/$HELM_RELEASE."

cat <<EOF
登录到 **中控机**，先更新 helm 仓库缓存：
\`\`\` bash
helm repo update
\`\`\`
检查仓库里的版本：
\`\`\` bash
helm search repo $CHART_NAME --version $VERSION
\`\`\`
预期输出如下所示：
>\`\`\` plain
$(column -ts $'\t' <<EOT
>NAME	CHART VERSION	APP VERSION	DESCRIPTION
>$CHART_REPO/$CHART_NAME	$VERSION	$APP_VERSION	略
EOT
)
>\`\`\`

接下来开始升级了。

先进入工作目录：
\`\`\` bash
cd \$INSTALL_DIR/blueking/  # 进入工作目录
\`\`\`

修改 \`environments/default/version.yaml\` 文件，配置 $CHART_NAME charts version 为 \`$VERSION\`：
\`\`\` bash
sed -i 's/$CHART_NAME:.*/$CHART_NAME: "$VERSION"/' environments/default/version.yaml
grep $CHART_NAME environments/default/version.yaml  # 检查修改结果
\`\`\`
预期输出：
>\`\`\` yaml
>  $CHART_NAME: "$VERSION"
>\`\`\`

更新 ${HELM_RELEASE}：
\`\`\` bash
helmfile -f $HELMFILE_PATH -l name=$HELM_RELEASE sync
\`\`\`

等待命令执行完毕，结尾输出如下即为更新成功：
>\`\`\` plain
>UPDATED RELEASES:
$(column -ts $'\t' <<EOT
>NAME	CHART	VERSION
>$HELM_RELEASE	$CHART_REPO/$CHART_NAME	$VERSION
EOT
)
>\`\`\`
EOF
