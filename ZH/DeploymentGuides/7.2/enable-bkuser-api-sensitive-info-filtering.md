# 开启用户管理 API 敏感信息过滤

> 最低支持版本 v2.5.4-beta.30（对应 Chart 版本 1.4.14-beta.30）

## 说明

当前用户管理接口返回默认不过滤敏感信息（如手机号码、邮箱等），如若用户希望接口返回不展示敏感信息，请参考以下指引进行调整。

## 开启步骤

1. 调整 bk-user 配置，新增 5 个环境变量
    ```bash
    cd $INSTALL_DIR/blueking

    touch environments/default/./environments/default/bkuser-custom-values.yaml.gotmpl

    yq -i '.api.env += [
        {"name": "ENABLE_PROFILE_SENSITIVE_FILTER", "value": "True"},
        {"name": "PROFILE_SENSITIVE_FIELDS", "value": "telephone,email"},
        {"name": "PROFILE_EXTRAS_SENSITIVE_FIELDS", "value": ""},
        {"name": "PROFILE_SENSITIVE_FIELDS_WHITELIST_APP_CODES", "value": "bk_apigateway"},
        {"name": "PROFILE_EXTRAS_SENSITIVE_FIELDS_WHITELIST_APP_CODES", "value": ""}
    ]' environments/default/./environments/default/bkuser-custom-values.yaml.gotmpl      
    ```
    - 字段解析
        - ENABLE_PROFILE_SENSITIVE_FILTER: 表示启动敏感字段过滤，敏感字段将会被置空
        - PROFILE_SENSITIVE_FIELDS: 声明哪些用户内置字段是敏感字段
        - PROFILE_EXTRAS_SENSITIVE_FIELDS: 声明哪些用户额外字段是敏感字段
        - PROFILE_SENSITIVE_FIELDS_WHITELIST_APP_CODES: 允许返回用户内置敏感字段的 AppCode 列表，多个使用英文逗号分隔；默认值 "bk_apigateway", CMSI 通知功能所需
        - PROFILE_EXTRAS_SENSITIVE_FIELDS_WHITELIST_APP_CODES: 允许返回用户额外敏感字段的 AppCode 列表，多个使用英文逗号分隔
2. 应用设置
    ```bash
    cd $INSTALL_DIR/blueking

    helmfile -f base-blueking.yaml.gotmpl -l bk-user sync
    ```