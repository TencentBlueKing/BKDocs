#!/bin/bash
# 生成单产品更新的文档。
# shellcheck disable=SC1111
set -eu

doc_main (){
  h1="# $DATE"
  h2="## $PRODUCT"
  h3="### $PACKAGE-$VERSION"
  # 如果没有h1及h2，则补齐。
  if ! grep -qxF "$h1" "$update_doc_file"; then echo $'\n'"$h1"$'\n'; fi
  if ! grep -qxF "$h2" "$update_doc_file"; then echo "$h2"$'\n'; fi
  # 如果存在h3，则跳过生成文档。
  if grep -HnxF "$h3" "$update_doc_file" >&2; then
    echo >&2 "  SKIP: will NOT gen doc due to h3 exist: $h3."; return; fi
  echo "$h3"$'\n'
  cat <<EOF
$PATCH_LEVEL_TIP
<!-- 版本日志见 GitHub_URL 。-->

EOF
  "$cmd_gen_doc"
  echo ""
}

gen_doc (){
  case "$TAGS" in
    *安全更新*) PATCH_LEVEL_TIP="这是 **安全更新**，修复了安全问题，请尽快安排更新。";;
    *重要补丁*) PATCH_LEVEL_TIP="这是 **重要更新**，主要修复了 “问题 1”、“问题 2” 等问题，强烈建议更新。";;
    *) PATCH_LEVEL_TIP="这是 **补丁更新**，修复了一些问题。";;
  esac
  # 获取产品，重新获取准确类型。
  IFS=$'\t' read -r PRODUCT PACKAGE PTYPE < <(awk -F"\t" -v p="$PACKAGE" '$2==p' scripts/packages.tsv)
  # 如果存在包专属的模板，则调用。
  if [ -x "scripts/update-doc-$PACKAGE.sh" ]; then
    cmd_gen_doc="scripts/update-doc-$PACKAGE.sh"
  else
    # 否则使用类型共享的模板。
    case $PTYPE in
      chart) cmd_gen_doc=scripts/update-doc-chart.sh;;
      SaaS) cmd_gen_doc=scripts/update-doc-saas.sh;;
      agent) cmd_gen_doc=scripts/update-doc-agent.sh;;
      proxy) cmd_gen_doc=scripts/update-doc-proxy.sh;;
      *) echo >&2 "ERROR: no render for $PTYPE"; exit 5;;
    esac
  fi

  update_doc_file="updates/${DATE%??}.md"
  export PRODUCT DATE PACKAGE PTYPE VERSION APP_VERSION PATCH_LEVEL_TIP
  echo >&2 "package version: $DATE $PRODUCT $PACKAGE $PTYPE $VERSION $APP_VERSION $TAGS."
  doc_main >> "$update_doc_file"
}

while IFS=$'\t' read -r DATE PRODUCT PACKAGE VERSION APP_VERSION TAGS; do
  gen_doc
done < <(gawk -f scripts/journal.awk scripts/patches.tsv scripts/features.tsv)
