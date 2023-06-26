# 开源项目: 接入权限中心的实现

注意, 以下项目, 每个项目有各自的业务场景, 所以权限模型有简单也有复杂的, 可以参考其模型和实现, 并配合企业版/社区版的权限配置页面和产品交互了解到最终实现的权限形态; 应该了解并思考自身产品的权限模型, 切忌`生搬硬套`

## Tencent/bk-PaaS(python)

- Github 地址: [Tencent/bk-PaaS: develop](https://github.com/Tencent/bk-PaaS/tree/develop/paas2/paas)
    - 对 iam 调用的封装: [common/bk_iam.py](https://github.com/Tencent/bk-PaaS/blob/develop/paas2/paas/common/bk_iam.py)

## Tencent/bk-sops(python)

- Github 地址: [Tencent/bk-sops](https://github.com/Tencent/bk-sops)
    - 权限模型: [support-files/iam](https://github.com/Tencent/bk-sops/tree/V3.6.X/support-files/iam)
    - 对 iam 调用的封装: [gcloud/iam_auth](https://github.com/Tencent/bk-sops/tree/V3.6.X/gcloud/iam_auth)

    
## Tencent/bk-bcs-saas(python)

- Github 地址: [Tencent/bk-bcs-saas](https://github.com/Tencent/bk-bcs-saas)
    - 权限模型: [bcs-app/support-files/iam](https://github.com/Tencent/bk-bcs-saas/tree/master/bcs-app/support-files/iam)
    - 对 iam 调用的封装: [bcs-app/backend/iam](https://github.com/Tencent/bk-bcs-saas/tree/master/bcs-app/backend/iam)

## TencentBlueKing/bk-itsm(python)

- Github 地址: [TencentBlueKing/bk-itsm](https://github.com/TencentBlueKing/bk-itsm)
    - 对 iam 调用的封装: [itsm/auth_iam](https://github.com/TencentBlueKing/bk-itsm/tree/master/itsm/auth_iam)

## TencentBlueKing/bk-user(python)

- Github 地址: [TencentBlueKing/bk-user](https://github.com/TencentBlueKing/bk-user)
    - 对 iam 调用的封装: [src/api/bkuser_core/bkiam](https://github.com/TencentBlueKing/bk-user/tree/master/src/api/bkuser_core/bkiam)

## TencentBlueKing/bk-log(python)

- Github 地址: [TencentBlueKing/bk-log](https://github.com/TencentBlueKing/bk-log)
    - 对 iam 调用的封装: [apps/iam](https://github.com/TencentBlueKing/bk-log/tree/master/apps/iam)

## TencentBlueKing/bk-nodeman(python)

- Github 地址: [TencentBlueKing/bk-nodeman](https://github.com/TencentBlueKing/bk-nodeman)
    - 对 iam 调用的封装: [apps/node_man/handlers/iam.py](https://github.com/TencentBlueKing/bk-nodeman/blob/V2.1.X/apps/node_man/handlers/iam.py)


## Tencent/bk-job(java)

- Github 地址: [Tencent/bk-job](https://github.com/Tencent/bk-job)
    - 对 iam 调用的封装: [src/backend/commons/common-iam/src/main/java/com/tencent/bk/job/common/iam](https://github.com/Tencent/bk-job/tree/master/src/backend/commons/common-iam/src/main/java/com/tencent/bk/job/common/iam)