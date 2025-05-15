#!/bin/bash
set -eu

echo >&2 "  RENDER: agent: ${PACKAGE}=${VERSION}"

cat <<EOF
登录到 **中控机**，下载 GSE Agent ${VERSION} 版本：
\`\`\` bash
bkdl-7.2-stable.sh -ur latest ${PACKAGE}=${VERSION}
\`\`\`

上传 Agent 到 节点管理：
\`\`\` bash
cd \$INSTALL_DIR/blueking/  # 进入工作目录
./scripts/setup_bkce7.sh -u agent
\`\`\`

随后访问“节点管理”，在 “Agent 状态”界面勾选待升级的 Agent，展开“批量”菜单，选择“升级”，即可进入升级界面。

遵循界面指引完成升级过程，等待 Agent 上报新的版本号，即升级完成。
EOF
