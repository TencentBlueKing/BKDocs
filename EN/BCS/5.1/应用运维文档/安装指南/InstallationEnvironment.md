# 安装方案
## 容器服务 SaaS

蓝鲸智云 -\> 开发者中心 -\> S-mart 应用 -\> 上传部署新应用

## 容器服务 WebConsole

<table>
    <tr>
        <th>序号</th>
        <th>用户需求</th>
        <th>部署模块</th>
        <th>机器数量</th>
        <th>推荐部署方案</th>
    </tr>
    <tr>
        <td rowspan="5">方案</td>
        <td rowspan="5">安装基础环境和 Web-Console</td>
        <td rowspan="5">基础模块<br>Mysql<br>Redis<br>Web-console</td>
    </tr>
    <tr>
        <td rowspan="2">2 - x</td>
        <td>基础模块(包含 k8s 等)</td>
    </tr>
    <tr>
        <td>Mysql,Redis</td>
    </tr>
    <tr>
        <td rowspan="2">2</td>
        <td></td>
    </tr>
    <tr>
        <td>Web-console</td>
    </tr>
</table>

## 容器监控中心 SaaS

蓝鲸智云 -\> 开发者中心 -\> S-mart 应用 -\> 上传部署新应用

## 容器监控中心后台

<table>
    <tr>
        <th>序号</th>
        <th>用户需求</th>
        <th>部署模块</th>
        <th>机器数量</th>
        <th>推荐部署方案</th>
    </tr>
    <tr>
        <td rowspan="5">方案</td>
        <td rowspan="5">安装基础环境和监控后台</td>
        <td rowspan="5">基础模块<br>Mysql<br>Redis<br>Grafana<br>Monitor</td>
    </tr>
    <tr>
        <td rowspan="2">2 - x</td>
        <td>基础模块(包含 k8s 等)</td>
    </tr>
    <tr>
        <td>Mysql,Redis</td>
    </tr>
    <tr>
        <td rowspan="2">2</td>
        <td>grafana</td>
    </tr>
    <tr>
        <td>monitor</td>
    </tr>
</table>

## 配置中心

Supervisor 托管 BCS CC 服务，详细参见[安装步骤](./MaintenanceInstructions.md#配置中心)。
