# 系统功能

|进程名称|部署服务器|功能|
|--|--|--|
|cmdb_webserver|后端服务器|处理 web 和前端文件请求|
|cmdb_apiserver|后端服务器|api 网。分发请求至其他进程处理|
|cmdb_adminserver|后端服务器|处理配置平台初始化任务|
|cmdb_eventserver|后端服务器|提供事件订阅和推送服务|
|cmdb_hostserver|后端服务器|提供主机相关服务|
|cmdb_procserver|后端服务器|提供进程相关服务|
|cmdb_toposerver|后端服务器|提供拓扑相关服务|
|cmdb_datacollection|后端服务器|收集主机实时数据|
|cmdb_auditcontroller|后端服务器|提供审计相关服务|
|cmdb_hostcontroller|后端服务器|提供主机相关原子服务|
|cmdb_objectcontroller|后端服务器|提供对象相关原子服务|
|cmdb_proccontroller|后端服务器|提供进程相关原子服务|
