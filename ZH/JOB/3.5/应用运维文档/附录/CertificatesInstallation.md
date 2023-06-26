# 证书安装

假设当前证书存储位置为 **/data/enterprise/certs,** 将 ssl_certificates.tar.gz 解压文件清单
```bash
job_server.key          job API 服务器证书与密钥文件
job_server.crt          job API 服务器证书文件
job_ca.key              job API 服务器根证书密钥文件
job_ca.crt              job API 服务器根证书文件
gseca.crt               GSE 的服务器根证书文件
gse_job_api_client.p12  GSE 提供给 JOB 的 p12 格式证书文件
pass.txt                保存各证书密码的文件用来提供给运营脚本初始化配置文件
```

## 连接 GSE 的证书安装
### 生成 keystore 文件

```bash
keytool -importkeystore -v -srckeystore gse_job_api_client.p12 -srcstoretype pkcs12 -destkeystore gse_job_api_client.keystore -deststoretype jks -srcstorepass keystore密码-deststorepass keystore密码 -noprompt
```

**说明：**

**gse_job_api_client.keystore**： 提供给 JOB 连接 GSE API 客户端证书和密钥的存储文件

**keystore 密码**： 从 pass.txt 文件中获取，gse_job_api_client.p12 的密码


### 生成 truestore 文件
```bash
keytool -keystore gse_job_api_client.truststore -alias ca -import -trustcacerts -file gseca.crt -storepass truststore密码 -noprompt
```
说明：

**gse_job_api_client.truestore**：提供给 JOB 连接 GSE API 信任服务器证书存储文件

**truststore 密码**：作为生成的 truststore 文件密码，建议与 keystore 文件密码一致，方案管理

## JOB API Server 证书安装

此证书用于对连接 JOB API 接口的客户端（例如 ESB）的安全认证

### 生成 JOB API keystore 文件
```bash
keytool -importkeystore -v -srckeystore job_server.p12 -srcstoretype pkcs12 -destkeystore job_server.keystore -deststoretype jks -srcstorepass keystore密码 -deststorepass keystore密码-noprompt
```

**说明**：

**job_server.keystore**：JOB API 服务器证书和密钥的存储文件

**keystore 密码**：从 pass.txt 文件中获取 job_server.key 密码，作为生成的 keystore 文件密码

### 生成 JOB API truestore 文件

```bash
keytool -keystore job_server.truststore -alias ca -import -trustcacerts -file job_ca.crt -storepass truststore密码 -noprompt
```

**说明：**

**job_server.truststore**：JOB 根服务器信任证书存储文件

**truststore 密码**：作为生成的 truststore 文件密码，建议与 keystore 文件密码一致，方案管理。
