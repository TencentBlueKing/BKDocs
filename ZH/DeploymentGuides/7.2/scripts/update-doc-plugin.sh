#!/bin/bash
set -eu

if [ "${PACKAGE}" = "bk-collector" ];then
  bk_collector_tips=""
fi

echo >&2 "  RENDER: plugin: ${PACKAGE}=${VERSION}"

cat <<EOF
在中控机下载插件包：
\`\`\` bash
bkdl-7.2-stable.sh -ur latest ${PACKAGE}=${VERSION}
\`\`\`
并上传到节点管理：
\`\`\` bash
cd \$INSTALL_DIR/blueking/  # 进入工作目录
scripts/setup_bkce7.sh -u plugin
\`\`\`
EOF

cat <<EOF
在蓝鲸桌面打开 节点管理 应用，默认位于 “节点管理” 界面，侧栏选择 “插件包”。点击插件名字，即可看到新的版本号。

升级 ${PACKAGE}：

1. 确认“插件包”展示的版本正确。
2. 进入“插件状态”界面，选择运行旧插件的 Agent。点击 “安装/更新” 按钮，选择插件为 ${PACKAGE}，开始升级。

当然，也可以参考节点管理产品文档了解 “插件部署” 功能，实现自动升级。
EOF
