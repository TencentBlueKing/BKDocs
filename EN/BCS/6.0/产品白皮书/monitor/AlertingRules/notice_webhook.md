## 产品配置回调地址

> 产品入口：http://bcs.bktencent.com/console/monitor/ (有多个项目请在导航切换，域名地址请以安装部署的域名为准) -> 新建告警策略

![-w2021](./_image/2020-11-16-17-08-45.jpg)

添加 IP 或者域名地址即可。

## 查看告警历史

配置好回调接口后，可以到告警历史查看回调通知是否成功。

![-w2021](./_image/2020-11-16-17-09-53.jpg)

鼠标移动可以看到错误详情

![-w2021](./_image/2020-11-16-17-09-40.jpg)

## 回调接口说明

#### 请求方式

接口回调会以 http `POST` 方式请求回调 URL，其中：
- Content-Type：application/json
- UserAgent：BCS-Generic-Alertmanager/0.9.0-bcs.v1.1.10 (注意，后面的版本号会可能升级为更高的版本)
- Body： 为 json 格式的数据，详情见下面的消息格式

#### 合法返回

返回 200 状态码，系统认为是请求正常，否则会再发送`3次`请求，如果连续都失败，系统认为回调失败，等下个告警周期再回调。

#### 消息格式

- alerts：告警的具体内容
- commonAnnotations：公共的 Annotations
- commonLabels：公共的 Labels
- groupKey：分组的 key
- version：版本，目前固定为`4`
- noticeHistoryId：BCS 系统记录的 ID，可以通过这个排查告警链路

#### 消息格式示例

```json
{
    "alerts": [
        {
            "annotations": {
                "comment": "测试",
                "message": "服务器 192.168.1.1:9100, 当前CPU使用率 0.59%, 已持续5分钟超过设定阈值90%, 请尽快处理"
            },
            "endsAt": "0001-01-01T00:00:00Z",
            "fingerprint": "33e5e99cde6f03ea",
            "generatorURL": "/graph?g0.expr=%28avg+by%28instance%2C+cluster_id%29+%28irate%28node_cpu_seconds_total%7Bmode%21%3D%22idle%22%7D%5B5m%5D%29%29+%2A+100%29+%3C+90&g0.tab=1",
            "labels": {
                "alertname": "测试",
                "cc_biz_id": "10000",
                "cluster_id": "BCS-K8S-15091",
                "instance": "192.168.1.1:9100",
                "project_id": "b37778ec757544868a01e1f01f07037f",
                "rule_id": "1",
                "source_type": "BCS_ALERTING_RULE"
            },
            "startsAt": "2020-04-02T11:39:06.083535213+08:00",
            "status": "firing"
        },
        {
            "annotations": {
                "comment": "测试",
                "message": "服务器 192.168.1.1:9100, 当前CPU使用率 0.33%, 已持续5分钟超过设定阈值90%, 请尽快处理"
            },
            "endsAt": "0001-01-01T00:00:00Z",
            "fingerprint": "ccdf584208098e7d",
            "generatorURL": "/graph?g0.expr=%28avg+by%28instance%2C+cluster_id%29+%28irate%28node_cpu_seconds_total%7Bmode%21%3D%22idle%22%7D%5B5m%5D%29%29+%2A+100%29+%3C+90&g0.tab=1",
            "labels": {
                "alertname": "测试",
                "cc_biz_id": "10000",
                "cluster_id": "BCS-K8S-15091",
                "instance": "192.168.1.1:9100",
                "project_id": "b37778ec757544868a01e1f01f07037f",
                "rule_id": "1",
                "source_type": "BCS_ALERTING_RULE"
            },
            "startsAt": "2020-04-02T11:39:06.083535213+08:00",
            "status": "firing"
        }
    ],
    "commonAnnotations": {
        "comment": "测试"
    },
    "commonLabels": {
        "alertname": "测试",
        "cc_biz_id": "10000",
        "cluster_id": "BCS-K8S-15091",
        "project_id": "b37778ec757544868a01e1f01f07037f",
        "rule_id": "1",
        "source_type": "BCS_ALERTING_RULE"
    },
    "externalURL": "http://test:9093",
    "groupKey": "{project_id=\"b37778ec757544868a01e1f01f07037f\",rule_id=\"1\"}:{alertname=\"测试\", cluster_id=\"BCS-K8S-15091\", project_id=\"b37778ec757544868a01e1f01f07037f\", rule_id=\"1\", source_type=\"BCS_ALERTING_RULE\"}",
    "groupLabels": {
        "alertname": "测试",
        "cluster_id": "BCS-K8S-15091",
        "project_id": "b37778ec757544868a01e1f01f07037f",
        "rule_id": "1",
        "source_type": "BCS_ALERTING_RULE"
    },
    "receiver": "1",
    "status": "firing",
    "version": "4",
    "noticeHistoryId":15117
}
```

## 参考文档

- [Alertmanager Webhook 配置](https://prometheus.io/docs/alerting/configuration/#webhook_config)