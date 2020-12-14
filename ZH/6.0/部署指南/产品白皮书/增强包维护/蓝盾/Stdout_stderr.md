## 检查服务的 stdout 和 stderr

一般登录到对应的机器上操作， 不建议使用 pcmd 封装运行。

```bash
journalctl -xeu 服务名
```
