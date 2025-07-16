#!/bin/bash
set -eu

echo >&2 "  RENDER: proxy: ${PACKAGE}=${VERSION}"

cat <<EOF
登录到 **中控机**，下载 GSE Proxy ${VERSION} 版本：
\`\`\` bash
bkdl-7.2-stable.sh -ur latest ${PACKAGE}=${VERSION}
\`\`\`

上传 Proxy 到 节点管理：
\`\`\` bash
cd \$INSTALL_DIR/blueking/  # 进入工作目录
./scripts/setup_bkce7.sh -u proxy
\`\`\`

随后访问“节点管理”，在顶部导航栏切换为 “管控区域管理”，展开“更多”菜单，选择“升级”，即可进入升级界面。
EOF
