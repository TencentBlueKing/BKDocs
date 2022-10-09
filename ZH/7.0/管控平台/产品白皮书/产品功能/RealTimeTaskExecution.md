# 实时任务执行

蓝鲸管控平台采用分布式多层级任务控制机制，实现海量多层级联网络的主机管控。

## 支持的任务类型

<table><tbody>
<tr><th width="30%">支持任务类型</th><th width="75%">详情</th></tr>
<tr><td><b>命令类型</b></td><td>linux 支持 Bash 命令、Windows 支持 cmd 命令、AIX 支持 ksh 命令，支持各种自定义可执行文件格式程序的启动，支持各种解释性语言程序的执行。</td></tr>
<tr><td><b>脚本类型</b></td><td>linux 支持 Shell 脚本、Windows 支持 Bat 脚本(安装有 cygwin 的额外支持 Shell 脚本)、AIX 支持 ksh 脚本，以及各种系统支持的解释性脚本程序(Python, Powershell, Perl)。</td></tr>
</tbody></table>

## 任务控制方式

<table><tbody>
<tr><th width="30%">任务控制方式</th><th width="75%">详情</th></tr>
<tr><td><b>指定用户执行</b></td><td>Linux 及其他类 Linux 系统支持按指定用户执行任务，例如用户设定以 user00 用户执行 ps，则只能看到该用户权限范围内的结果；<br>因为 Windows 操作系统的限制，只有开启校验机器密码功能的用户才能指定用户执行任务，否则都以 SYSTEM 用户执行任务。</td></tr>
<tr><td><b>继承用户环境</b></td><td>Linux 及其他类 Linux 系统支持指定用户后继承该用户设定的环境变量，<br>Windows 无此功能。</td></tr>
<tr><td><b>校验机器密码</b></td><td>用户可以选择是否校验机器密码，<br>如果选择不校验，则 Window Agent 不支持按指定用户执行任务的功能。</td></tr>
<tr><td><b>有害操作告警</b></td><td>蓝鲸管控平台能够对高危操作进行预警，高危操作的定义由系统自动设定。</td></tr>
<tr><td><b>有害操作防护</b></td><td>蓝鲸管控平台能够对高危操作进行预警并干预，高危操作的定义及干预措施提供选项供用户配置。</td></tr>
</tbody></table>