## 10、 日志平台

日志平台可以快速接入日志，与 ELK 日志套件相比，具有入门容易，配置简单，接入成本低等特点，并且可与监控平台对接配置告警。相比 ELK，可以无需关心采集端的部署配置，无需关心数据清洗，而相同点是存储都是有 Elasticsearch。

线上体验环境默认接入了两个日志，系统的 messages 和 nginx 日志，可以直接进行体验

![](./assets/2022-02-18-17-57-34.png)

![](./assets/2022-02-18-17-57-38.png)

考虑到线上 体验环境的性能稳定，暂未开放日志接入，如需体验完整的接入流程，可以在自己私有化环境按照 [https://bk.tencent.com/docs/document/6.0/142/8599](https://bk.tencent.com/docs/document/6.0/142/8599) 来配置接入。

更多日志平台功能详见：[日志平台产品白皮书](../../LogSearch/4.6/UserGuide/Intro/README.md)

---

- 您可能需要：

    1. [立即下载蓝鲸](https://bk.tencent.com/download/)
    2. 了解更多企业定制化服务：[点击咨询](https://bk.tencent.com/applyinfo/ee/)