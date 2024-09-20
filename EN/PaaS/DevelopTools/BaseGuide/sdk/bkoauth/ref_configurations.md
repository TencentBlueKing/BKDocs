# bkoauth 所有配置项

## 一：获取 access_token 配置项

请把下面配置复制到 config/settings_custom.py 文件中


```python
# 蓝鲸 SSM 平台访问地址
OAUTH_API_URL = 'http://bkssmee.xxx.com'
OAUTH_COOKIES_PARAMS = {'bk_token': 'bk_token'}
```


### 二：API Gateway 鉴权配置

公钥入口：API Gateway -》 我的网关-》 基本信息 -》API 公钥(指纹) -》 复制

```python
APIGW_PUBLIC_KEY = '''
-----BEGIN PUBLIC KEY-----
xxx
-----END PUBLIC KEY-----
'''
```
