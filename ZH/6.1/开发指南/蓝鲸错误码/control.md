# 管控平台错误码

|错误码	|	错误名称	|	注解	|
|--|---|--|
|	1000101	|	GSE_SYSTEMERROR	|	系统错误，如进程创建失败、线程创建失败、服务启动失败等	|
|	1000102	|	GSE_NOVALIDMEM	|	申请内存错误，一般在 new 一个对象或分配内存时发生	|
|	1000103	|	GSE_CREATEWORKERFAIL	|	创建工作进程失败	|
|	1000104	|	GSE_FILEINVALID	|	文件错误，如配置文件打开失败	|
|	1000105	|	GSE_ADDRINVALID	|	地址错误，如数组未初始化导致的数组访问失败	|
|	1000106	|	GSE_ARGSINVALID	|	参数不合法	|
|	1000107	|	GSE_NET_BROKEN	|	网络中断	|
|	1000108	|	GSE_MD5_INVALID	|	MD5 校验错误	|
|	1000109	|	GSE_HTTP_ERROR	|	HTTP 错误，在 Post 或 Get 时发生	|
|	1000110	|	GSE_FTP_ERROR	|	FTP 错误	|
|	1000111	|	GSE_FWRITE_ERROR	|	写文件错误，如配置文件更新时写入失败	|
|	1000112	|	GSE_JSON_INVALID	|	JSON 不合法，一般在解析 JSON 时发生	|
|	1000113	|	GSE_FILE_ISLOCKED	|	文件已加锁，发生在 MASTER 进程创建 PID 文件时	|
|	1000114	|	GSE_FREAD_ERROR	|	读文件错误	|
|	1000115	|	GSE_WAITFOR_HANDLE	|	等待处理，表示任务处于正在处理状态，需等待执行完成	|
|	1000116	|	GSE_ADD_NOTIFY_ERR	|	对文件添加监控失败	|
|	1000117	|	GSE_NO_SUCH_CONN	|	连接错误，Task Server 找不到对应 ip 的 agent	|
|	1000118	|	GSE_CREATE_MSG_ERR	|	CmdDispatcher 创建 Msg 出错	|
|	1000119	|	GSE_FILE_TOOLARGE	|	文件大小超出规定范围	|
|	1000120	|	GSE_TIMEOUT	|	任务超时	|
|	1000121	|	GSE_BEYOND_LIMIT	|	超出限制，分段数据的数量最大限制为 10	|
|	1000122	|	GSE_INVALID_USERPWD	|	用户名密码不合法，发生在用户名密码校验时	|
|	1000123	|	GSE_EMPTY_FILE	|	文件为空	|
|	1000124	|	GSE_LIBEVENT_FAILED	|	libevent 错误	|
|	1000125	|	GSE_SPACE_LIMIT	|	磁盘空间不足	|
|	1000126	|	GSE_STOP_TASK	|	强制终止任务失败	|
|	1000130	|	GSE_ZK_CONNECT_ERR	|	ZK 连接错误，发生在 ZK 初始化时	|
|	1000131	|	GSE_ZK_NOTCONNECTED	|	ZK 未连接，发生在创建和删除 ZK 节点时	|
|	1000132	|	GSE_ZK_CREATEFAIL	|	ZK 节点创建失败	|
|	1000133	|	GSE_ZK_DELETEFAIL	|	ZK 节点删除失败	|
|	1000134	|	GSE_ZK_GETFAIL	|	ZK 节点获取失败	|
|	1000135	|	GSE_ZK_SETFAIL	|	ZK 节点设置失败	|
|	1000136	|	GSE_ZK_NODE_EXIST	|	ZK 节点已存在，发生在 ZK 节点创建时	|
|	1000137	|	GSE_ZK_NODE_NOTEXIST	|	ZK 节点不存在	|
|	1000138	|	GSE_ZK_NODE_LOCKED	|	ZK 节点已上锁	|
|	1000139	|	GSE_ZK_CONNECT_TIMEOUT	|	ZK 连接超时	|
|	1000160	|	GSE_MYSQL_INIT_FAIL	|	MYSQL 初始化错误	|
|	1000161	|	GSE_MYSQL_CONN_FAIL	|	MYSQL 连接失败	|
|	1000162	|	GSE_MYSQL_QUERY_FAIL	|	mysqlNoResultQuery 命令执行失败	|
|	1000163	|	GSE_MYSQL_INSERT_FAIL	|	MYSQL 插入失败，如插入的表名或插入的值有误	|
|	1000164	|	GSE_MYSQL_SELECT_FAIL	|	MYSQL 的 SELECT 语句执行失败	|
|	1000165	|	GSE_MYSQL_UPDATE_FAIL	|	MYSQL 的 UPDATE 语句执行失败	|
|	1000166	|	GSE_MYSQL_DELETE_FAIL	|	MYSQL 的 DELETE 语句执行失败	|
|	1000167	|	GSE_MYSQL_LINK_FAIL	|	MYSQL 连接失败	|
|	1000168	|	GSE_MYSQL_CREATETABLE_FAIL	|	MYSQL 创建表失败	|
|	1000169	|	GSE_MYSQL_SELECTDB_FAIL	|MYSQL 选择 DB 失败	|
|	1000170	|	GSE_MYSQL_SERVER_LOST	|	MYSQL 服务器丢失连接	|
|	1000180	|	GSE_REDIS_LINK_FAIL	|REDIS 连接失败	|
|	1000181	|	GSE_REDIS_AUTH_FAIL	|REDIS 密码错误，授权失败	|
|	1000182	|	GSE_REDIS_CMD_FAIL	|REDIS 命令执行失败，由连接失败或相应失败造成	|
|	1000183	|	GSE_REDIS_RPY_EMPTY	|REDIS 的响应为空	|
|	1000184	|	GSE_REDIS_RPY_NULL	|REDIS 响应失败，由 key 或 value 值为 NULL 造成	|
|	1000185	|	GSE_REDIS_RPY_INVALID	|	REDIS 响应不合法，由 key 或 value 类型不是 STRING 造成	|
|	1000301	|	GSE_TASKISNULL	|	任务为空	|
|	1000302	|	GSE_TASK_CMDNULL	|	任务命令为空	|
|	1000303	|	GSE_TASK_FAIL_CONNECTOTHERSVR	|	连接 taskserver 失败	|
|	1000304	|	GSE_TASK_FAIL_SYNTASKOTHERSVR	|	消息同步转发给其他 taskserver 失败	|
|	1000305	|	GSE_TASK_NO_OTHERSERVER	|	没有其他 taskserver	|
|	1000401	|	GSE_NOSUCHDATAID	|	无此 dataId，发生在 StateServer 通过 dataId 传递消息时	|
|	1000402	|	GSE_NOSUCHSERVERID	|	无此 serverId，REDIS 或 KAFKA 服务器找不到相应的 serverId	|
|	1000403	|	GSE_SERVERNOTSETUP	|	REDIS 或 KAFKA 的服务未启动，如指向 REDIS 的 writer 或 KAFKA 的 producer 的指针为空	|
|	1000404	|	GSE_DS_FD_INVALID	|	数据管道 fd 非法	|
|	1000405	|	GSE_DS_IOCTL_ERROR	|	数据管道读写失败	|
|	1000406	|	GSE_DS_CONFIG_FILE_LOST	|	数据管道配置文件不存在	|
|	1000407	|	GSE_DS_CONFIG_INVALID	|	数据管道配置文件非法	|
|	1000408	|	GSE_DS_PLUGIN_CONFIG_INVALID	|	插件配置文件非法	|
|	1000409	|	GSE_DS_SET_INOTIFY_FAILED	|	数据管道设置 inotify 失败	|
|	1000601	|	GSE_CONFIG_PUSH_PARAMERR	|	配置分发参数错误	|
|	1000602	|	GSE_CONFIG_MD5_CHECKFAIL	|	配置文件 MD5 校验失败	|
|	1000603	|	GSE_CONFIG_CC_RSPERR	|	CC 响应失败	|
|	1000604	|	GSE_CONFIG_CC_UPDATING	|	CC 数据更新中	|
|	1000701	|	GSE_FILE_BT_HASH_ERROR	|	哈希失败，由 libtorrent::set_piece_hashes()产生	|
|	1000702	|	GSE_FILE_BT_LISTEN_ERROR	|会话监听失败	|
|	1000703	|	GSE_FILE_BT_ADDTORRENT_ERROR	|	会话添加 torrent 时产生的错误	|
|	1000704	|	GSE_FILE_BT_NOSUCH_MODE	|	无此 BT 数据模式，BT 数据模式既非 source 又非 client 时报此错	|
|	1000705	|	GSE_FILE_BT_NOSUCH_DIR	|	目录不存在	|
|	1000706	|	GSE_FILE_BT_NOSUCH_FILE	|	文件不存在	|
|	1000707	|	GSE_FILE_BT_CANNOT_OPEN_DIR	|	打开目录失败	|
|	1000708	|	GSE_FILE_BT_EMPTYDIR	|	目录为空，无文件	|
|	1000709	|	GSE_FILE_BT_REGEX_NOMATCH	|	正则匹配失败，没有匹配到任何文件	|
|	1000710	|	GSE_FILE_COMPRESS_ERROR	|	文件压缩失败	|
|	1000711	|	GSE_FILE_FORCE_STOP	|	文件任务强制中止失败	|
|	1000712	|	GSE_FILE_BT_COMMON_ERROR	|	文件管道一般错误	|
|	1000801	|	GSE_PROC_NO_PROCCFG	|	无此进程相关配置，进程配置获取失败	|
|	1000802	|	GSE_PROC_LOCKED	|	业务被其他用户上锁	|
|	1000803	|	GSE_PROC_CREATE_TASK_FAIELD	|	ProcServer 创建任务失败	|
|	1000804	|	GSE_PROC_CMD_EXECUTING	|	ProcServer 的任务处于执行状态	|
|	1000805	|	GSE_PROC_CMD_DONE_FAILED	|ProcServer 的任务结束，但部分命令执行超时，失败	|
|	1000806	|	GSE_PROC_NO_TASK	|	ProcServer 任务列表为空	|
|	1000807	|	GSE_PROC_MATCH_FAILED	|	进程匹配失败，无法通过配置或 procId 匹配到对应的进程	|
|	1000808	|	GSE_PROC_TASKSVR_FAILED	|	TaskServer 返回的错误，如 ProcServer 发送命令到 TaskServer 时失败	|
|	1000809	|	GSE_PROC_EVENT_FAILED	|	ProcServer 的事件失败，如创建定时器失败和发送任务事件失败	|
|	1000810	|	GSE_PROC_SWITCH	|	进程配置变更，发生在 ProcCfgManager::setProcCfg()	|
|	1000811	|	GSE_PROC_REQPARAM_ERROR	|	请求的参数不合法，如 appId 或 envId 为空	|
|	1000820	|	GSE_PROC_PARSE_ARG	|	解析配置参数时发生的错误	|
|	1000821	|	GSE_PROC_MATCH_PROCS	|	参数匹配失败	|
|	1000822	|	GSE_PROC_TIMEOUT	|	ProcServer 的任务执行超时或丢弃	|
|	1000823	|	GSE_PROC_NOAPP	|	用户无此业务使用权限	|
|	1000824	|	GSE_PROC_NOFUNCINFO	|	匹配不到进程	|
|	1000825	|	GSE_PROC_CONNECTTASK_FAIL	|ProcServer 连接 TaskServer 失败	|
|	1000826	|	GSE_PROC_TASKBECANCEL	|	任务被取消	|
|	1000827	|	GSE_PROC_DONOTSUPPORTCMD	|	不支持的命令	|
|	1000828	|	GSE_PROC_RUNNING	|	进程运行中	|
|	1000829	|	GSE_PROC_NOTRUNNING	|	进程已停止	|
|	1000830	|	GSE_PROC_TASKLOCKED	|	任务被锁	|
|	1000831	|	GSE_PROC_INVALID_SESSIONID	|	非法 session id	|
|	1000832	|	GSE_PROC_UNKOWN_OPTYPE	|	非法操作类型	|
|	1000833	|	GSE_PROC_MODEL_MODIFIED	|	业务进程模型已改变	|
