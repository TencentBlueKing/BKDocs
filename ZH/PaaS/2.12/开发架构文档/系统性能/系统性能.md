# 主要性能指标

## WEB 指标

| WEB 页   | 路径   | 总请求量 | 并发 | 失败请求数 | QPS(request/s) | 平均响应时间(ms) |
|----------------|-----------------------------|-------|-----|---|--------|----------|
| 登陆页          | /login/                     | 10000 | 100 | 0 | 590.98 | 169.212 |
| 主页            | /platform/                  | 10000 | 100 | 0 | 69.33 | 1442.443 |
| App 列表页      | /app/list/                  | 10000 | 100 | 0 | 81.97 | 1219.889 |
| SaaS 列表页     | /saas/list/                 | 10000 | 100 | 0 | 81.99 | 1219.719 |
| App 查询接口    | /app/query_list/            | 10000 | 100 | 0 | 69.78 | 1433.027 |
| 部署日志查询接口 | /release/get_app_poll_task/ | 10000 | 100 | 0 | 42.67 | 2343.392 |

## ESB 指标

- 压测机型配置：4 核 CPU \@2.66GHz 8G 内存

- 测试指令：

```bash
./apache/bin/ab -n [100] -c [100] 'http://10.137.155.84:8002/c/compapi/heartbeat/detect/?app_code=esb&username=admin&app_secret=43d7d599-7a94-48e5-aa0f-15b77f208569&timestamp=1&sleep_time=0'
```

- 测试条件：

通过设置组件耗时时间，测试组件并发量，worker 数量为 8

当前的部署模式，访问 PaaS 的 DB 连接为当前访问并发的瓶颈，当前服务器 DB 最大连接数为 151。

<table>
    <tr>
        <th colspan="5">组件耗时 sleep_time = 0 测试结果</th>
    </tr>
    <tr>
        <th>并发</th>
        <th>QPS</th>
        <th>平均耗时(ms)</th>
        <th>失败请求个数</th>
        <th>出现异常信息</th>
    </tr>
    <tr>
        <td>700</td>
        <td>168</td>
        <td>5</td>
        <td>13</td>
        <td>DB 连接过多：Too many connections</td>
    </tr>
    <tr>
        <td>600</td>
        <td>66</td>
        <td>15</td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>500</td>
        <td>133</td>
        <td>7</td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>300</td>
        <td>88</td>
        <td>11</td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>200</td>
        <td>65</td>
        <td>15</td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>100</td>
        <td>252</td>
        <td>4</td>
        <td>0</td>
        <td></td>
    </tr>
</table>

<table>
    <tr>
        <th colspan="5">组件耗时 sleep_time = 1 测试结果</th>
    </tr>
    <tr>
        <th>并发</th>
        <th>QPS</th>
        <th>平均耗时(ms)</th>
        <th>失败请求个数</th>
        <th>出现异常信息</th>
    </tr>
    <tr>
        <td>200</td>
        <td>48</td>
        <td>20</td>
        <td>143</td>
        <td>DB 连接过多：Too many connections</td>
    </tr>
    <tr>
        <td>100</td>
        <td>75</td>
        <td>13</td>
        <td>0</td>
        <td></td>
    </tr>
</table>

<table>
    <tr>
        <th colspan="5">组件耗时 sleep_time = 2 测试结果</th>
    </tr>
    <tr>
        <th>并发</th>
        <th>QPS</th>
        <th>平均耗时(ms)</th>
        <th>失败请求个数</th>
        <th>出现异常信息</th>
    </tr>
    <tr>
        <td>200</td>
        <td>54</td>
        <td>18</td>
        <td>116</td>
        <td>DB 连接过多：Too many connections</td>
    </tr>
    <tr>
        <td>100</td>
        <td>29</td>
        <td>33</td>
        <td>0</td>
        <td></td>
    </tr>
</table>

<table>
    <tr>
        <th colspan="5">组件耗时 sleep_time = 3 测试结果</th>
    </tr>
    <tr>
        <th>并发</th>
        <th>QPS</th>
        <th>平均耗时(ms)</th>
        <th>失败请求个数</th>
        <th>出现异常信息</th>
    </tr>
    <tr>
        <td>200</td>
        <td>36</td>
        <td>27</td>
        <td>116</td>
        <td>DB 连接过多：Too many connections</td>
    </tr>
    <tr>
        <td>100</td>
        <td>18</td>
        <td>53</td>
        <td>0</td>
        <td></td>
    </tr>
</table>


## app engine 指标

- 部署接口：`/v1/apps/{app_code}/releases/`

## 压测方案一

<table>
    <tr>
        <th colspan="3">条件</th>
    </tr>
    <tr>
        <th>类别</th>
        <th>指标值</th>
        <th>备注</th>
    </tr>
    <tr>
        <td>任务设置的超时间时间</td>
        <td>180s</td>
        <td></td>
    </tr>
    <tr>
        <td>执行 python virtualenv 环境构建</td>
        <td>是</td>
        <td>(Envs 目录为空)</td>
    </tr>
</table>

<table>
    <tr>
        <th colspan="3">测试数据</th>
    </tr>
    <tr>
        <th>一次性提交任务数</th>
        <th>完成任务个数</th>
        <th>超时任务个数</th>
    </tr>
    <tr>
        <td>10</td>
        <td>10</td>
        <td>0</td>
    </tr>
    <tr>
        <td>15</td>
        <td>0</td>
        <td>15</td>
    </tr>
</table>


观察：多个 Copying env as...同时操作会阻塞，直到超时

## 压测方案二

<table>
    <tr>
        <th colspan="3">条件</th>
    </tr>
    <tr>
        <th>类别</th>
        <th>指标值</th>
        <th>备注</th>
    </tr>
    <tr>
        <td>任务设置的超时间时间</td>
        <td>500s</td>
        <td></td>
    </tr>
    <tr>
        <td>执行 python virtualenv环境构建</td>
        <td>是</td>
        <td>(Envs 目录为空)</td>
    </tr>
</table>

<table>
    <tr>
        <th colspan="3">测试数据</th>
    </tr>
    <tr>
        <th>一次性提交任务数</th>
        <th>完成任务个数</th>
        <th>超时任务个数</th>
    </tr>
    <tr>
        <td>10</td>
        <td>10</td>
        <td>0</td>
    </tr>
    <tr>
        <td>15</td>
        <td>0</td>
        <td>15</td>
    </tr>
</table>

观察：多个 Copying env as...同时操作会阻塞，直到超时
