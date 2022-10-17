# 系统外部接口

<table>
    <tr>
        <th rowspan="2">系统接口</th>
        <th colspan="2">通信协议</th>
        <th rowspan="2">通信频率(次/分)</th>
        <th rowspan="2">备注</th>
    </tr>
    <tr>
        <th>TCP/UDP/其他</th>
        <th>标准/自定义</th>
    </tr>
    <tr>
        <td>PAAS</td>
        <td>TCP</td>
        <td>标准(http)</td>
        <td></td>
        <td>/login/?app_id=%s&c_url=%s</td>
    </tr>
    <tr>
        <td>PAAS</td>
        <td>TCP</td>
        <td>标准(http)</td>
        <td></td>
        <td>/login/accounts/get_user/?bk_token=</td>
    </tr>
    <tr>
        <td>PAAS</td>
        <td>TCP</td>
        <td>标准(http)</td>
        <td></td>
        <td>/login/accounts/get_all_user/?bk_token=%s</td>
    </tr>
    <tr>
        <td>PAAS</td>
        <td>TCP</td>
        <td>标准(http)</td>
        <td></td>
        <td>/console/?app=bk_agent_setup</td>
    </tr>
</table>
