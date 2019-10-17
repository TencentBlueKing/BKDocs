# 作业平台错误码

## 关联系统错误码

|错误码 |源 |目标| 描述 |
|--|--|--|--|
|1210001|JOB|GSE|GSE TaskServer 不可用|
|1210101|JOB|GSE|当前证书服务不可用，请检查 license_server！|
|1250001|JOB|Redis|Redis 服务不可：IP 不对或者配置错误|
|1250002|JOB|Redis|Redis 服务内存满或者其他问题：内存不足|
|1259001|JOB|NFS|NFS 存储不可用|
|1252001|JOB|MYSQL|数据库异常|
|1255001|JOB|MQ|Rabbit MQ 不可用或者连接不上|
|1211001|JOB|CMDB|CMDB 服务状态不可达：地址配置错误|
|1211002|JOB|CMDB|CMDB 接口返回数据结构异常。一般是被网关防火墙重定向返回非 JSON 协议内容|
|1211121|JOB|CMDB|蓝鲸业务下的 Git 模块没有 IP（包管理）|
|1213001|JOB|PAAS|PAAS 服务不可达 - 地址配置错误或者地址无法正确解析|
|1213002|JOB|PAAS|PaaS 接口返回数据结构异常。一般是被网关防火墙重定向返回非 JSON 协议内容 |

## 旧版 API 错误码

|错误码	|源	|目标	|描述	|
|--|--|--|--|
|	1209801	|	JOB	|	JOB	|	该 IP 没有申请权限，请与管理员联系申请访问接口权限	|
|	1209802	|	JOB	|	JOB	|	该用户没有访问权限	|
|	1209803	|	JOB	|	JOB	|	执行队列已满	|
|	1209804	|	JOB	|	JOB	|	启动失败	|
|	1209443	|	JOB	|	JOB	|	访问方式不正确，API接口请通过 ESB 组件以 HTTPS 方式访问	|
|	1209995	|	JOB	|	JOB	|	不支持的接口	|
|	1209996	|	JOB	|	JOB	|	没有操作权限	|
|	1209999	|	JOB	|	JOB	|	系统内部异常	|
|	1201000	|	JOB	|	JOB	|	任务正在运行	|
|	1209701	|	JOB	|	JOB	|	操作失败!任务 {0} 当前状态: {1}	|
|	1207101	|	JOB	|	JOB	|	参数【appId】值不合法	||
|	1207102	|	JOB	|	JOB	|	参数【status】值状态：1.启动、2.暂停	|
|	1207103	|	JOB	|	JOB	|	参数 ipList 包含非法的IP信息 {0}	|
|	1207104	|	JOB	|	JOB	|	IP{0} 不属于该业务	|
|	1207105	|	JOB	|	JOB	|	存在非法的 stepId{0}	|
|	1207106	|	JOB	|	JOB	|	存在重复的 stepId{0}	|
|	1207107	|	JOB	|	JOB	|	scriptContent 格式非法	|
|	1207108	|	JOB	|	JOB	|	非法的 ipList 参数	|
|	1207109	|	JOB	|	JOB	|	非法 IP{0}	|
|	1207110	|	JOB	|	JOB	|	非法的全局变量:id【{0}】	|
|	1207111	|	JOB	|	JOB	|	全局变量未包含 IP 信息， id【{0}】	|
|	1207112	|	JOB	|	JOB	|	全局变量包含非法的 IP 信息， ip【{0}】	|
|	1207113	|	JOB	|	JOB	|	全局变量获取的 IP 数为 0， id【{0}】	|
|	1207114	|	JOB	|	JOB	|	fileSource 参数 ipList 包含非法的 IP 信息{0}	|
|	1207115	|	JOB	|	JOB	|	参数【operType】非法	|
|	1207116	|	JOB	|	JOB	|	请求参数格式非法【gseAgentInstallTime】或【gseAgentUpdateTime】	|
|	1207117	|	JOB	|	JOB	|	定时任务的频次不能快于每 1 分钟一次	|
|	1207118	|	JOB	|	JOB	|	名称 {0} 已被使用，请修改名称后保存！	|
|	1207119	|	JOB	|	JOB	|	content 格式非法	|
|	1207120	|	JOB	|	JOB	|	文件生成失败！	|
|	1207121	|	JOB	|	JOB	|	参数【scriptParams】值不合法，需要 base64	|
|	1207122	|	JOB	|	JOB	|	脚本【{0}】不属于当前业务	|
|	1207123	|	JOB	|	JOB	|	定时规则不合法	|
|	1207124	|	JOB	|	JOB	|	步骤【{0}】的服务器帐户为空	|
|	1207125	|	JOB	|	JOB	|	步骤【{0}】的脚本内容为空	|
|	1207126	|	JOB	|	JOB	|	步骤【{0}】的 DB 执行帐户为空	|
|	1207127	|	JOB	|	JOB	|	步骤【{0}】的文件传输源为空	|
|	1207128	|	JOB	|	JOB	|	步骤【{0}】的 IP 未注册:{1}	|
|	1207129	|	JOB	|	JOB	|	步骤【{0}】的文件源文件路径为空	|
|	1207130	|	JOB	|	JOB	|	步骤【{0}】的文件源件路径不合法	|
|	1207131	|	JOB	|	JOB	|	步骤【{0}】的文件目标路径不合法	|
|	1207132	|	JOB	|	JOB	|	步骤【{0}】的类型不合法:{1}	|
|	1207133	|	JOB	|	JOB	|	步骤【{0}】的 IP 列表为空	|
|	1207134	|	JOB	|	JOB	|	参数【{0}】值不合法，需要正整数	|
|	1207135	|	JOB	|	JOB	|	文件路径不合法，不能有空格，路径中不能有重复的路径分隔符或者文件分隔符错误，需要绝对路径	|
|	1207136	|	JOB	|	JOB	|	当脚本内容不为空时，需要指定正确的 scriptType 脚本类型！	|
|	1208100	|	JOB	|	JOB	|	缺少参数【{0}】	|
|	1208101	|	JOB	|	JOB	|	缺少参数【ip】	|
|	1208102	|	JOB	|	JOB	|	缺少参数【source】	|
|	1208103	|	JOB	|	JOB	|	缺少参数【ipList】	|
|	1208104	|	JOB	|	JOB	|	缺少参数【crontabTaskId】	|
|	1208105	|	JOB	|	JOB	|	缺少参数【operator】	|
|	1208106	|	JOB	|	JOB	|	缺少参数【status】	|
|	1208107	|	JOB	|	JOB	|	缺少参数【parms】	|
|	1208108	|	JOB	|	JOB	|	缺少参数【srcAppId】	|
|	1208109	|	JOB	|	JOB	|	缺少参数【destAppId】	|
|	1208110	|	JOB	|	JOB	|	缺少参数【starter】	|
|	1208111	|	JOB	|	JOB	|	缺少参数【applicationId】	|
|	1208112	|	JOB	|	JOB	|	缺少参数【taskInstanceId】	|
|	1208113	|	JOB	|	JOB	|	缺少参数【stepInstanceId】	|
|	1208114	|	JOB	|	JOB	|	缺少参数【operationCode】	|
|	1208115	|	JOB	|	JOB	|	缺少参数【destIp】	|
|	1208116	|	JOB	|	JOB	|	缺少参数【content】或者【scripId】	|
|	1208117	|	JOB	|	JOB	|	缺少参数【file】或者【files】	|
|	1208118	|	JOB	|	JOB	|	缺少参数【account】	|
|	1208119	|	JOB	|	JOB	|	缺少参数【targetAppId】	|
|	1208120	|	JOB	|	JOB	|	缺少参数【ipList】或【groupIds】或【ccServerSetId】	|
|	1208121	|	JOB	|	JOB	|	缺少参数【dbAccountId】	|
|	1208122	|	JOB	|	JOB	|	缺少参数【fileSource】	|
|	1208123	|	JOB	|	JOB	|	缺少参数【fileTargetPath】	|
|	1208124	|	JOB	|	JOB	|	缺少参数【contact】	|
|	1208125	|	JOB	|	JOB	|	缺少参数【gseTaskId】	|
|	1208126	|	JOB	|	JOB	|	缺少参数【userName】	|
|	1208127	|	JOB	|	JOB	|	缺少参数【procName】	|
|	1208128	|	JOB	|	JOB	|	缺少参数【processInfos】	|
|	1208129	|	JOB	|	JOB	|	缺少参数【uin】	|
|	1208130	|	JOB	|	JOB	|	缺少参数【ownerUin】	|
|	1208131	|	JOB	|	JOB	|	缺少参数【userList】	|
|	1208132	|	JOB	|	JOB	|	缺少参数【appId】	|
|	1208133	|	JOB	|	JOB	|	缺少参数【taskId】	|
|	1208134	|	JOB	|	JOB	|	缺少参数【agentInfo】	|
|	1208135	|	JOB	|	JOB	|	缺少参数【name】	|
|	1208136	|	JOB	|	JOB	|	缺少参数【cronExpression】	|
|	1208140	|	JOB	|	JOB	|	fileSource 参数缺少 account 字段	|
|	1208141	|	JOB	|	JOB	|	fileSource 参数缺少 ipList 或者 serverSetId 字段	|
|	1208142	|	JOB	|	JOB	|	缺少参数【fileList】	|
|	1208143	|	JOB	|	JOB	|	缺少参数【fileName】	|
|	1208144	|	JOB	|	JOB	|	缺少参数【content】	|
|	1208145	|	JOB	|	JOB	|	缺少参数【targetPath】	|
|	1208146	|	JOB	|	JOB	|	缺少参数【processInfos】	|
|	1208147	|	JOB	|	JOB	|	缺少参数【{0}】或【{1}】	|
|	1203101	|	JOB	|	JOB	|	业务 {0} 不存在	|
|	1203102	|	JOB	|	JOB	|	定时作业 {0} 不存在	|
|	1203103	|	JOB	|	JOB	|	任务实例 {0} 不存在	|
|	1203104	|	JOB	|	JOB	|	步骤实例 {0} 不存在	|
|	1203105	|	JOB	|	JOB	|	该业务 {0} 下没有 IP	|
|	1203106	|	JOB	|	JOB	|	作业 {0} 不存在	|
|	1203107	|	JOB	|	JOB	|	作业 {0} 没有任何步骤	|
|	1203108	|	JOB	|	JOB	|	原业务 {0} 不存在	|
|	1203109	|	JOB	|	JOB	|	目标业务 {0} 不存在	|
|	1203110	|	JOB	|	JOB	|	脚本 {0} 不存在	|
|	1203111	|	JOB	|	JOB	|	数据库执行帐户 {0} 不存在	|
|	1203112	|	JOB	|	JOB	|	业务 {0} 不存在于任何业务集下	|
|	1203113	|	JOB	|	JOB	|	作业 {0} 的步骤脚本不存在	|
|	1203001	|	JOB	|	JOB	|	定时作业设置失败，作业步骤的 IP/ 文件信息不完整，请检查作业!	|
|	1209101	|	JOB	|	JOB	|	帐户【{0}】没有该业务的操作权限	|
|	1209102	|	JOB	|	JOB	|	没有该脚本的操作权限	|
|	1209103	|	JOB	|	JOB	|	没有访问该作业【{0}】的权限	|
|	1209104	|	JOB	|	JOB	|	没有操作该作业【{0}】的权限	|
|	1209105	|	JOB	|	JOB	|	【{0}】用户没有使用帐号【{1}】的权限，请联系作业平台管理员在帐户管理进行授权	|
|	1209106	|	JOB	|	JOB	|	【{0}】用户没有使用DB帐号【{1}】的权限，请联系作业平台管理员在帐户管理进行授权	|

## 新版 API 错误码

|错误码	|源	|目标	|描述	|
|--|--|--|--|
| 1239801	|	JOB	|	JOB	|	该 IP 没有申请权限，请与管理员联系申请访问接口权限 |
| 1239802	|	JOB	|	JOB	|	该用户没有访问权限 |
| 1239803	|	JOB	|	JOB	|	执行队列已满 |
| 1239804	|	JOB	|	JOB	|	启动失败 |
| 1239443	|	JOB	|	JOB	|	访问方式不正确，API 接口请通 ESB 组件以 HTTPS 方式访问 |
| 1239995	|	JOB	|	JOB	|	不支持的接口 |
| 1239996	|	JOB	|	JOB	|	用户【{0}】没有操作权限 |
| 1239999	|	JOB	|	JOB	|	系统内部异常 |
| 1231000	|	JOB	|	JOB	|	任务正在运行 |
| 1239701	|	JOB	|	JOB	|	操作失败!任务{0}当前状态:{1} |
| 1237101	|	JOB	|	JOB	|	参数【bk_biz_id】值不合法 |
| 1237102	|	JOB	|	JOB	|	参数【status】值状态：1.启动、2.暂停 |
| 1237103	|	JOB	|	JOB	|	参数 ip_list 包含非法的 IP 信息{0} |
| 1237104	|	JOB	|	JOB	|	IP{0} 不属于该业务 |
| 1237105	|	JOB	|	JOB	|	存在非法的 step_id {0} |
| 1237106	|	JOB	|	JOB	|	存在重复的 step_id {0} |
| 1237107	|	JOB	|	JOB	|	script_content 格式非法 |
| 1237108	|	JOB	|	JOB	|	非法的 ip_list 参数 |
| 1237109	|	JOB	|	JOB	|	非法 IP{0} |
| 1237110	|	JOB	|	JOB	|	非法的全局变量:id【{0}】 |
| 1237111	|	JOB	|	JOB	|	全局变量未包含 IP 信息， id【{0}】 |
| 1237112	|	JOB	|	JOB	|	全局变量包含非法的 IP 信息， ip【{0}】 |
| 1237113	|	JOB	|	JOB	|	全局变量获取的 IP 数为 0， id【{0}】 |
| 1237114	|	JOB	|	JOB	|	file_source 参数 ip_list 包含非法的 IP 信息{0} |
| 1237115	|	JOB	|	JOB	|	参数【oper_type】非法 |
| 1237116	|	JOB	|	JOB	|	请求参数格式非法【gseAgentInstallTime】或【gseAgentUpdateTime】|
| 1237117	|	JOB	|	JOB	|	定时任务的频次不能快于每 1 分钟一次 |
| 1237118	|	JOB	|	JOB	|	名称{0}已被使用，请修改名称后保存！
| 1237119	|	JOB	|	JOB	|	content 格式非法 |
| 1237120	|	JOB	|	JOB	|	文件生成失败！
| 1237121	|	JOB	|	JOB	|	参数【script_params】值不合法,需要 base64 |
| 1237122	|	JOB	|	JOB	|	脚本【{0}】不属于当前业务 |
| 1237123	|	JOB	|	JOB	|	定时规则不合法 |
| 1237124	|	JOB	|	JOB	|	步骤【{0}】的服务器帐户为空 |
| 1237125	|	JOB	|	JOB	|	步骤【{0}】的脚本内容为空 |
| 1237126	|	JOB	|	JOB	|	步骤【{0}】的 DB 执行帐户为空 |
| 1237127	|	JOB	|	JOB	|	步骤【{0}】的文件传输源为空 |
| 1237128	|	JOB	|	JOB	|	步骤【{0}】的 IP 未注册或者不在白名单中:{1} |
| 1237129	|	JOB	|	JOB	|	步骤【{0}】的文件源文件路径为空 |
| 1237130	|	JOB	|	JOB	|	步骤【{0}】的文件源件路径不合法 |
| 1237131	|	JOB	|	JOB	|	步骤【{0}】的文件目标路径不合法 |
| 1237132	|	JOB	|	JOB	|	步骤【{0}】的类型不合法:{1} |
| 1237133	|	JOB	|	JOB	|	步骤【{0}】的 IP 列表为空 |
| 1237134	|	JOB	|	JOB	|	参数【{0}】值不合法,需要正整数 |
| 1237135	|	JOB	|	JOB	|	文件路径不合法,不能有空格,路径中不能有重复的路径分隔符或者文件分隔符错误,需要绝对路径 |
| 1237136	|	JOB	|	JOB	|	当脚本内容不为空时，需要指定正确的 scriptType 脚本类型！
| 1238100	|	JOB	|	JOB	|	缺少参数【{0}】|
| 1238101	|	JOB	|	JOB	|	缺少参数【ip】|
| 1238102	|	JOB	|	JOB	|	缺少参数【source】|
| 1238103	|	JOB	|	JOB	|	缺少参数【ip_list】|
| 1238104	|	JOB	|	JOB	|	缺少参数【cron_id】|
| 1238105	|	JOB	|	JOB	|	缺少参数【operator】|
| 1238106	|	JOB	|	JOB	|	缺少参数【status】|
| 1238107	|	JOB	|	JOB	|	缺少参数【parms】|
| 1238108	|	JOB	|	JOB	|	缺少参数【source_bk_biz_id】|
| 1238109	|	JOB	|	JOB	|	缺少参数【target_bk_biz_id】|
| 1238110	|	JOB	|	JOB	|	缺少参数【starter】|
| 1238111	|	JOB	|	JOB	|	缺少参数【bk_biz_id】|
| 1238112	|	JOB	|	JOB	|	缺少参数【task_instance_id】|
| 1238113	|	JOB	|	JOB	|	缺少参数【step_instance_id】|
| 1238114	|	JOB	|	JOB	|	缺少参数【operation_code】|
| 1238115	|	JOB	|	JOB	|	缺少参数【dest_ip】|
| 1238116	|	JOB	|	JOB	|	缺少参数【content】或者【scrip_id】|
| 1238117	|	JOB	|	JOB	|	缺少参数【files】|
| 1238118	|	JOB	|	JOB	|	缺少参数【account】|
| 1238119	|	JOB	|	JOB	|	缺少参数【target_bk_biz_id】|
| 1238120	|	JOB	|	JOB	|	缺少参数【ip_list】或【group_ids】或【server_set_id】|
| 1238121	|	JOB	|	JOB	|	缺少参数【db_account_id】|
| 1238122	|	JOB	|	JOB	|	缺少参数【file_source】|
| 1238123	|	JOB	|	JOB	|	缺少参数【file_target_path】|
| 1238124	|	JOB	|	JOB	|	缺少参数【contact】|
| 1238125	|	JOB	|	JOB	|	缺少参数【gse_task_id】|
| 1238126	|	JOB	|	JOB	|	缺少参数【account】|
| 1238127	|	JOB	|	JOB	|	缺少参数【proc_name】|
| 1238128	|	JOB	|	JOB	|	缺少参数【process_infos】|
| 1238129	|	JOB	|	JOB	|	缺少参数【uin】|
| 1238130	|	JOB	|	JOB	|	缺少参数【owner_uin】|
| 1238131	|	JOB	|	JOB	|	缺少参数【user_list】|
| 1238132	|	JOB	|	JOB	|	缺少参数【bk_biz_id】|
| 1238133	|	JOB	|	JOB	|	缺少参数【bk_job_id】|
| 1238134	|	JOB	|	JOB	|	缺少参数【agent_info】|
| 1238135	|	JOB	|	JOB	|	缺少参数【name】|
| 1238136	|	JOB	|	JOB	|	缺少参数【cron_expression】|
| 1238140	|	JOB	|	JOB	|	file_source 参数缺少 account 字段 |
| 1238141	|	JOB	|	JOB	|	file_source 参数缺少 ip_list 或者 group_ids 字段 |
| 1238142	|	JOB	|	JOB	|	缺少参数【file_list】|
| 1238143	|	JOB	|	JOB	|	缺少参数【file_name】|
| 1238144	|	JOB	|	JOB	|	缺少参数【content】|
| 1238145	|	JOB	|	JOB	|	缺少参数【file_target_path】|
| 1238146	|	JOB	|	JOB	|	缺少参数【{0}】或【{1}】
| 1233101	|	JOB	|	JOB	|	业务 {0} 不存在 |
| 1233102	|	JOB	|	JOB	|	定时作业 {0} 不存在 |
| 1233103	|	JOB	|	JOB	|	任务实例 {0} 不存在 |
| 1233104	|	JOB	|	JOB	|	步骤实例 {0} 不存在 |
| 1233105	|	JOB	|	JOB	|	该业务 {0} 下没有 IP |
| 1233106	|	JOB	|	JOB	|	作业 {0} 不存在 |
| 1233107	|	JOB	|	JOB	|	作业 {0} 没有任何步骤 |
| 1233108	|	JOB	|	JOB	|	原业务 {0} 不存在 |
| 1233109	|	JOB	|	JOB	|	目标业务 {0} 不存在 |
| 1233110	|	JOB	|	JOB	|	脚本 {0} 不存在 |
| 1233111	|	JOB	|	JOB	|	数据库执行帐户 {0} 不存在 |
| 1233112	|	JOB	|	JOB	|	业务 {0} 不存在于任何业务集下 |
| 1233113	|	JOB	|	JOB	|	作业 {0} 的步骤脚本不存在 |
| 1233001	|	JOB	|	JOB	|	定时作业设置失败,作业步骤的 IP/ 文件信息不完整,请检查作业!
| 1239101	|	JOB	|	JOB	|	帐户【{0}】没有该业务的操作权限 |
| 1239102	|	JOB	|	JOB	|	没有该脚本的操作权限 |
| 1239103	|	JOB	|	JOB	|	没有访问该作业【{0}】的权限 |
| 1239104	|	JOB	|	JOB	|	没有操作该作业【{0}】的权限 |
| 1239105	|	JOB	|	JOB	|	【{0}】用户没有使用帐号【{1}】的权限,请联系作业平台管理员在帐户管理进行授权 |
| 1239106	|	JOB	|	JOB	|	【{0}】用户没有使用DB帐号【{1}】的权限,请联系作业平台管理员在帐户管理进行授权 |
| 1239300	|	JOB	|	JOB	|	缺少请求报文或报文不合法 |
| 1239301	|	JOB	|	JOB	|	缺少参数 action |
| 1239302	|	JOB	|	JOB	|	缺少参数 request_id |
| 1239303	|	JOB	|	JOB	|	缺少参数 version |
| 1239304	|	JOB	|	JOB	|	缺少参数 token |
| 1239305	|	JOB	|	JOB	|	缺少参数 sign |
| 1239306	|	JOB	|	JOB	|	异步调用的方法超时了 |
| 1239307	|	JOB	|	JOB	|	调用方法出错了 |
| 1239308	|	JOB	|	JOB	|	API 接口已经过期废弃 |
| 1239309	|	JOB	|	JOB	|	API 服务过载，拒绝服务请求 |
| 1239310	|	JOB	|	JOB	|	API 回调其他接口失败 |
