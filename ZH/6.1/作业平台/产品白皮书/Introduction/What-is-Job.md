# 产品简介

## 产品概述

作业平台（Job）是一套基于蓝鲸智云管控平台 Agent 管道之上，提供基础操作的原子平台；具备上万台并发处理能力，除了支持脚本执行、文件拉取 / 分发、定时任务等一系列基础运维场景以外，还支持通过流程调度能力将零碎的单个任务组装成一个自动化作业流程；而每个任务都可做为一个原子节点，提供给上层或周边系统/平台使用，实现调度自动化。

## 功能特性

<table><tbody>
<tr style="font-weight:bold;"><td width="15%" >	一级导航</td><td width="15%" >	二级导航</td><td width="15%">	三级导航</td><td width="55%">	功能说明</td></tr>
<tr><td rowspan="13" style="vertical-align:middle;">	作业管理</td><td>	业务概览</td><td>	-	</td><td>	通过对业务配置异常分析给出提醒和明细列表，提供便捷的收藏作业、以及近期执行的操作入口。	</td></tr>
<tr><td rowspan="2" style="vertical-align:middle;">	快速执行	</td><td>	脚本执行	</td><td>	可通过手动编写、本地上传，或引用业务/公共脚本的方式进行批量脚本执行。	</td></tr>
<tr><td style="vertical-align:middle;">	文件分发	</td><td>	支持本地上传或从服务器上选择源文件两种方式，满足"一对多"、"多对多"、"多对一"等多种分发文件场景，且能自由控制上传/下载的速率和超时。	</td></tr>
<tr><td rowspan="4" style="vertical-align:middle;">	任务编排	</td><td style="vertical-align:middle;">	作业	</td><td>	提供作业编排功能，支持用户将多个脚本执行、文件分发或人工确认步骤组装成作业模板，并按使用场景衍生多个对应的执行方案；提供调试功能来满足作业调试场景，支持使用标签对作业进行分类管理。	</td></tr>
<tr><td style="vertical-align:middle;">执行方案</td><td> 汇总展示所有作业的执行方案列表 </td></tr>
<tr><td style="vertical-align:middle;">定时</td><td> 支持将作业执行方案设置成单次或周期执行的定时任务。 </td></tr>
<tr><td style="vertical-align:middle;">执行历史</td><td> 记录所有通过作业平台页面或 API 调用的方式发起的脚本执行、文件分发、作业和定时任务操作信息，提供任务重做和日志回溯的能力。 </td></tr>
<tr><td rowspan="2" style="vertical-align:middle;">	资源</td><td style="vertical-align:middle;">脚本</td><td> 提供脚本的版本管理功能，包括版本增删改查、版本日志、版本对比、版本状态变更（上线/下线/禁用）等。 </td></tr>
<tr><td>	账号	</td><td>	提供在执行脚本或分发文件时所需的服务器账户的管理和维护功能。	</td></tr>
<tr><td rowspan="2" style="vertical-align:middle;">	文件源</td><td style="vertical-align:middle;">文件源</td><td><i style="color:grey;">	未开放，请关注后续版本更新计划</i></td></tr>
<tr><td>	凭证</td><td><i style="color:grey;">	未开放，请关注后续版本更新计划</i></td></tr>
<tr><td rowspan="2" style="vertical-align:middle;">	管理</td><td style="vertical-align:middle;">	标签	</td><td>	提供以标签为维度对作业和脚本进行分类管理的能力</td></tr>
<tr><td style="vertical-align:middle;">	消息通知	</td><td>	支持用户根据执行任务的状态发送消息通知，包括脚本执行/文件分发/作业执行的成功或失败状态，帮助用户及时得知任务的执行情况。	</td></tr>
<tr><td rowspan="2" style="vertical-align:middle;">	运营分析</td><td style="vertical-align:middle;">	运营视图	</td><td style="vertical-align:middle;">	运营视图</td><td style="vertical-align:middle;">	功能与业务的脚本管理相同，但公共脚本面向的是整个作业平台所有业务，满足提供公共需求的脚本使用场景。</td></tr>
<tr><td style="vertical-align:middle;">	审计记录	</td><td style="vertical-align:middle;">	审计记录</td><td style="vertical-align:middle;"><i style="color:grey;">	未开放，请关注后续版本更新计划</i></td></tr>
<tr><td rowspan="1" style="vertical-align:middle;">	个性化</td><td style="vertical-align:middle;">	脚本模板</td><td style="vertical-align:middle;">	脚本模板</td><td style="vertical-align:middle;">	提供用户个人维度的默认脚本内容定制化配置能力，满足不同用户在脚本格式规范、通用函数方法等个性化定义能力。</td></tr>
<tr><td rowspan="6" style="vertical-align:middle;">	平台管理</td><td rowspan="1" style="vertical-align:middle;">	资源</td><td style="vertical-align:middle;">	公共脚本</td><td>	功能与业务的脚本管理相同，但公共脚本面向的是整个作业平台所有业务，满足提供公共需求的脚本使用场景。	</td></tr>
<tr><td rowspan="2" style="vertical-align:middle;">	设置</td><td style="vertical-align:middle;">	IP 白名单</td><td>	用于满足跨业务传输文件或执行脚本的场景（未来将下架，通过配置平台的「业务集」模式来满足） </td></tr>
<tr><td style="vertical-align:middle;">	全局设置</td><td>	作业平台管理员功能，支持配置消息通知渠道、通讯黑名单、历史数据存储策略、账号命名规则和高危语句规则设置。</td></tr>
<tr><td rowspan="2" style="vertical-align:middle;">	安全</td><td style="vertical-align:middle;">	高危语句规则</td><td>	配置高危语句的检测规则（支持正则表达式），并提供“扫描”和“拦截”两个不同级别的应对方法；“扫描”功能是为避免检测规则有误，从而导致直接影响线上业务执行而设计的；即，符合检测规则的仅会记录日志，并不会真正拦截！而“拦截”模式则顾名思义就是直接阻拦用户的脚本执行操作。</td></tr>
<tr><td style="vertical-align:middle;">	检测记录</td><td>	提供高危语句的检测记录查看功能，为安全职能团队治理运营安全问题提供举证。</td></tr>
<tr><td rowspan="1" style="vertical-align:middle;">	视图</td><td style="vertical-align:middle;">	服务状态</td><td>	显示作业平台后台所有微服务模块的相关信息，包括名称、版本号和状态等信息，提供平台管理员排查服务运行情况能力。</td></tr>
</tbody></table>
