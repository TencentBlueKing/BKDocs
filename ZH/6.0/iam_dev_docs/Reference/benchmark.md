# 性能测试说明

## 测试环境

- CPU: 8 Core Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz
- Memory: 8G 

## 测试数据

目前仅使用个人常规的策略进行`基准`测试, 不涉及复杂的继承.

#### 1.策略查询 API `/api/v1/policy/query`

- [API 文档](../Reference/API/04-Auth/01-SDK.md)
- 压测命令: `wrk -t8 -c100 -d60s --latency -s post.query.lua http://{IP}:{PORT}/api/v1/policy/query`
- 测试数据

```bash
Running 1m test @ http://{IP}:{PORT}//api/v1/policy/query
  8 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     8.19ms    0.99ms  36.51ms   94.78%
    Req/Sec     1.47k    85.45     4.32k    95.45%
  Latency Distribution
     50%    7.96ms
     75%    8.24ms
     90%    8.96ms
     99%   10.48ms
  704377 requests in 1.00m, 186.75MB read
Requests/sec:  11721.59
Transfer/sec:      3.11MB
```
- 说明
	- 简单策略查询耗时: `<10ms`
    - 复杂策略查询耗时: `<100ms`
- 依赖: 从数据库查询一次后, 放入 redis, 所以如果发现耗时比较多, 可以查看权限中心日志, 确认 sql 执行耗时/redis 执行耗时/请求耗时等, 确认是否是由于 mysql/redis 原因导致请求比较慢;


如果发现鉴权耗时很慢, 那么可能有两个原因:
1. 请求鉴权接口慢.  DNS 解析/网络耗时, 可以通过权限中心的请求日志确认耗时
2. 本地计算慢. 可能是该用户涉及权限策略过多, 查询返回后, 本地计算比较慢. 例如
    - 给一个用户授权了 10000 个实例权限, 策略数据比较大, 计算比较慢.  此时应该给这个用户授权`范围`权限, 而不是 10000 个实例权限.
    - 把一个用户加入 100 个组/用户属于 100 个部门等, 会自动继承部门/组的权限, 导致策略数据比较大. 此时应该减少这个用户加入的组/部门.


#### 2.鉴权计算 API `/api/v1/policy/auth`



- [API 文档](../Reference/API/04-Auth/02-DirectAPI.md)
- 压测命令: `wrk -t8 -c100 -d60s --latency -s post.query.lua http://{IP}:{PORT}/api/v1/policy/auth`
- 测试数据

```bash
Running 1m test @ http://{IP}:{PORT}//api/v1/policy/auth
  8 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     8.04ms    0.98ms  46.68ms   94.05%
    Req/Sec     1.50k   101.82     5.30k    96.82%
  Latency Distribution
     50%    7.82ms
     75%    8.05ms
     90%    8.84ms
     99%   10.66ms
  717322 requests in 1.00m, 150.50MB read
Requests/sec:  11935.97
Transfer/sec:      2.50MB
```

注意: 
- 这个 API 是给非 SDK 接入/无跨系统资源依赖的`小型系统/脚本/后台任务`使用的. 
- 中大型系统/平台类系统不要使用这个接口.
- 该接口耗费服务端资源较大, 后续会进行流控/熔断/服务降级