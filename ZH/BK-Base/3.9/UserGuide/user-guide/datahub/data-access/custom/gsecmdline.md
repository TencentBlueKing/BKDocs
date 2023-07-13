# gsecmdline 使用方式

gsecmdline 通过 gseAgent 上报数据



## 主要参数说明

* -d dataid
* -l 上报数据, 自动追加额外信息
* -J 上报 json 格式数据, 自动追加额外信息
* -s 原始数据上报模式
* -D 调试模式

## 上报数据+额外信息

> gsecmdline -d 0 -l data

```json
{"_bizid_":0,"_cloudid_":0,"_server_":"127.0.0.1","_time_":"2019-05-14 21:37:55","_utctime_":"2019-05-14 13:37:55","_value_":["data"]}
```

## 上报 json 数据+额外信息

> gsecmdline -d 0 -J '{"k":0}'

```json
{"_company_id_":0,"_plat_id_":0,"_server_":"127.0.0.1","_time_":"2019-05-14 21:38:46","_utctime_":"2019-05-14 13:38:46","k":0}
```

## 上报原始数据

> gsecmdline -d 0 -s data

```json
data
```



