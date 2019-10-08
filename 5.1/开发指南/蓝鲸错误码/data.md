# 数据平台错误码


| 错误码 | 错误码名称         | 含义                               |
| ----- | ------------- | -------------------------------- |
| 07000 | COMMON_INFO | 000-099 的错误码为提示信息，用于 info 日志，非错误标识  |     
| 07100 | PARAM_ERR                        | 100-199 的错误码为输入参数相关问题             |      
| 07101 | PARAM_MISSING_ERR                | 必填参数缺失             |      
| 07102 | PARAM_FORMAT_ERR                 | 参数格式错误             |      
| 07103 | PARAM_JSON_ERR                   | Json 参数解析失败            |      
| 07104 | PARAM_BLANK_ERR                  | 关键参数（不限于输入参数）为空导致逻辑不能正常执行 |      
| 07200 | COMPONENT_ERR                    | 200-299 的错误码为 DB 操作相关的问题            |      
| 07201 | MYSQL_ERR                        | Mysql 相关问题                        |      
| 07202 | MYSQL_CONN_ERR                   | Mysql 连接失败                        |      
| 07203 | MYSQL_EXEC_ERR                   | Mysql 执行 sql 失败                        |      
| 07204 | MYSQL_QUERY_ERR                  | Mysql 查询失败                       |      
| 07205 | MYSQL_SAVE_ERR                   | Mysql 保存失败                        |      
| 07231 | CRATE_ERR                        | Crate 相关问题                        |      
| 07232 | CRATE_CONN_ERR                   | Crate 连接失败                        |      
| 07233 | CRATE_EXEC_ERR                   | Crate 执行失败                        |      
| 07234 | CRATE_QUERY_ERR                  | Crate 查询失败                       |      
| 07235 | CRATE_SAVE_ERR                   | Crate 保存失败                        |      
| 07241 | ES_ERR                           | ES 相关问题                        |      
| 07242 | ES_CONN_ERR                      | ES 连接失败                        |      
| 07243 | ES_EXEC_ERR                      | ES 执行失败                        |      
| 07244 | ES_QUERY_ERR                     | ES 查询失败                       |      
| 07245 | ES_SAVE_ERR                      | ES 保存失败                        |      
| 07250 | INFLUX_ERR                       | 250-259 的错误码为 InfluxDB 操作相关的问题      |      
| 07251 | INFLUX_CONN_ERR                  | InfluxDB 连接失败                     |      
| 07252 | INFLUX_QUERY_ERR                 | InfluxDB 查询失败                     |      
| 07260 | KAFKA_ERR                        | 260-269 为 Kafka 相关问题                     |      
| 07261 | KAFKA_CONN_ERR                   | Kafka 连接失败                     |      
| 07262 | KAFKA_READ_ERR                   | Kafka 读取记录失败                   |      
| 07263 | KAFKA_WRITE_ERR                  |  Kafka 写入记录失败                    |      
| 07264 | KAFKA_FORMAT_ERR                 |  Kafka 记录格式解析出错  |      
| 07265 | KAFKA_META_ERR                   |  查询 Kafka 元信息失败  |      
| 07270 | REDIS_ERR                        | 270-279 为 Redis 相关问题                     |      
| 07271 | REDIS_CONN_ERR                   | Redis 连接失败                     |      
| 07272 | REDIS_QUERY_ERR                  | Redis 读取记录失败                   |      
| 07273 | REDIS_SAVE_ERR                   |  Redis 写入记录失败                    |      
| 07300 | HTTP_ERR                         | 300-399 的错误码为 HTTP 调用相关问题，常用于调用其他接口 |  
| 07301 | HTTP_REQUEST_ERR                 | 请求 HTTP 接口异常                       |      
| 07302 | HTTP_GET_ERR                     | 以 GET 方式请求 HTTP 接口异常                 |      
| 07303 | HTTP_POST_ERR                    | 以 POST 方式请求 HTTP 接口异常                |      
| 07304 | HTTP_STATUS_ERR                  | HTTP 返回状态码非 200                   |      
| 07350 | ESB_ERR                          | ESB 组件相关异常  |      
| 07351 | ESB_CALL_ERR                     | ESB 组件调用失败  |      
| 07400 | LOGIC_ERR                        | 400-899 的错误码为逻辑异常                 |      
| 07410 | LOGIC_SAVE_ERR                   | 保存 DB 相关业务逻辑问题                     |      
| 07411 | LOGIC_SAVE_ALERT_ERR             | 保存告警信息异常                         |      
| 07510 | LOGIC_EXEC_ERR                   | 500-599 执行类业务逻辑问题                     |      
| 07511 | LOGIC_SEND_ALERT_ERR             | 发送告警异常                           |      
| 07512 | LOGIC_ALERT_ACTION_ERR           | 执行告警处理动作异常                       |      
| 07513 | LOGIC_SEND_EMAIL_ERR             | 邮件发送失败  |      
| 07600 | LOGIC_QUERY_ERR                  | 600-699 查询类逻辑错误                          |      
| 07611 | LOGIC_QUERY_USE_RESULT_ERR       | 使用查询结果异常                         |      
| 07612 | LOGIC_QUERY_WALK_RESULT_ERR      | 遍历查询结果异常                         |      
| 07613 | LOGIC_QUERY_NO_RESULT_ERR        | 查询记录不存在                        |      
| 07614 | LOGIC_QUERY_FAIL_ERR             | 查询记录失败，未成功查询到所需结果  |      
| 07615 | LOGIC_QUERY_FORMAT_ERR           | 查询到记录，反序列化时异常，如 json 解析失败  |      
| 07700 | CODE_ERR                         | 700-799 代码逻辑异常                        |      
| 07701 | CODE_MISSING_ERR                 | 缺失代码文件                        |      
| 07702 | CODE_IMPORT_ERR                  | 动态加载模块/类失败    |      
| 07800 | ENV_ERR                          | 800-899 为环境与脚本执行问题          |      
| 07801 | ENV_SHELL_ERR                    | Shell 命令执行异常     |      
| 07900 | OTHER_ERR                        | 900-999 的错误码段收集了常用分类以外的特异性错误      |     

------

| 错误码 | 错误码名称  | 含义               |  
| ----- | ------ | ---------------- |
| 70001 |DATAID_NOT_FOUND        |未找到 dataid|      
| 70002 |INVALID_API_ARGS        |参数错误|      
| 70003 |ASYNC_TIMEOUT           |轮训异步操作结果超时|      
| 70004 |EXTERNAL_API_FAILED     |调用接口失败|      
| 70005 |UNFORMATTED_STRUCTURE   |数据结构非法|      
| 70006 |INERNAL_ERROR           |内部错误|      
| 70007 |ADD_CONNECTOR_FAILED    |添加总线任务失败|      
| 70008 |MISSING_FIELD           |缺失字段|      
| 70009 |DICT_NOT_FOUND          |未找到字典表内元素|      
| 70010 |RT_NOT_FOUND            |未找到 RT|      
| 70011 |CONFIG_NOT_FOUND        |未找到配置|      


---------------

| 错误码 | 错误码名称  | 含义               |  
| ----- | ------ | ---------------- |
| 72000 | ILLEGAL_ARGUMENT_EX  | 非法参数         |      
| 72101 | NO_INPUT_DATA_EX  | 无输入数据         |      
| 72111 | NO_OUTPUT_DATA_EX  | 无结果数据         |      
| 72401 | SELECT_EX | 查询操作时出现异常，导致请求失败，一般为 DB 操作 |      
| 72402 | INSERT_EX | 插入操作时出现异常，导致请求失败，一般为 DB 操作 |      
| 72403 | UPDATE_EX | 更新操作时出现异常，导致请求失败，一般为 DB 操作 |      
| 72404 | DELETE_EX | 删除操作时出现异常，导致请求失败，一般为 DB 操作 |      
| 72500 | INNER_SERVER_EX  | 请求的服务不可用         |      
| 72501 | OUTTER_SERVER_EX  | 请求的服务不可用         |      
| 71999 | ARGS_EX  | 请求参数错误        |      
| 71301~71304 | START_DEBUG_EX  | 启动调试异常         |      
| 71305~71307 | GET_DEBUG_INFO_EX  | 获取调试信息异常        |      
| 71308~71309 | STOP_DEBUG_EX  | 停止调试异常        |      
| 71401~71403 | STOP_JOB_EX  | 停止作业异常        |      
| 71405~71407 | SUBMIT_JOB_EX  | 提交 storm 作业异常        |      
| 71408~71409 | RELEASE_VERSION_EX  | 获取工程版本异常        |      
| 71412 | SYNC_STATUS_EX  | 同步任务状态异常        |      
| 71416~71425 | REGISTER_JOB_EX  | 注册任务异常        |      
| 71506~71507 | SET_SQL_EX  | 保存 sql 异常       |      
| 71426 | CREATE_JOB_EX  | 创建任务异常        |      
| 71427 | UPDATE_JOB_EX  | 更新任务异常        |      
| 71428 | START_JOB_EX  | 启动任务异常        |      
| 71429 | STOP_FLOW_EX  | 启动 flow 任务异常（官网）        |      
| 71430 | RESTART_JOB_EX  | 重启任务异常        |      
| 71431 | KILL_JOB_EX  | 通过 http 请求 kill 任务异常        |      
| 71404 | UNLOCK_EX  | 解锁任务异常        |      
| 71410 | LOCL_EX  | 锁定任务异常        |      
| 71501 | DELETE_RT_EX  | 删除 rt 异常        |      
| 71502 | SET_RT_EX  | 保存 rt 异常        |      


-----------------

| 错误码 | 错误码名称  | 含义        |  
| ----- | ------ | ---------------- |
| 72000 | ILLEGAL_ARGUMENT_EX  | 非法参数         |      
| 72101 | NO_INPUT_DATA_EX  | 无输入数据         |      
| 72111 | NO_OUTPUT_DATA_EX  | 无结果数据         |      
| 72401 | SELECT_EX | 查询操作时出现异常，导致请求失败，一般为 DB 操作 |      
| 72402 | INSERT_EX | 插入操作时出现异常，导致请求失败，一般为 DB 操作 |      
| 72403 | UPDATE_EX | 更新操作时出现异常，导致请求失败，一般为 DB 操作 |      
| 72404 | DELETE_EX | 删除操作时出现异常，导致请求失败，一般为 DB 操作 |      
| 72500 | INNER_SERVER_EX  | 请求的服务不可用         |      
| 72501 | OUTTER_SERVER_EX  | 请求的服务不可用         |      
| 71999 | ARGS_EX  | 请求参数错误        |      
| 71301~71304 | START_DEBUG_EX  | 启动调试异常         |      
| 71305~71307 | GET_DEBUG_INFO_EX  | 获取调试信息异常        |      
| 71308~71309 | STOP_DEBUG_EX  | 停止调试异常        |      
| 71401~71403 | STOP_JOB_EX  | 停止作业异常        |      
| 71405~71407 | SUBMIT_JOB_EX  | 提交 storm 作业异常        |      
| 71408~71409 | RELEASE_VERSION_EX  | 获取工程版本异常        |      
| 71412 | SYNC_STATUS_EX  | 同步任务状态异常        |      
| 71416~71425 | REGISTER_JOB_EX  | 注册任务异常        |      
| 71506~71507 | SET_SQL_EX  | 保存 sql 异常       |      
| 71426 | CREATE_JOB_EX  | 创建任务异常        |      
| 71427 | UPDATE_JOB_EX  | 更新任务异常        |      
| 71428 | START_JOB_EX  | 启动任务异常        |      
| 71429 | STOP_FLOW_EX  | 启动 flow 任务异常（官网）        |      
| 71430 | RESTART_JOB_EX  | 重启任务异常        |      
| 71431 | KILL_JOB_EX  | 通过 http 请求 kill 任务异常        |      
| 71404 | UNLOCK_EX  | 解锁任务异常        |      
| 71410 | LOCL_EX  | 锁定任务异常        |      
| 71501 | DELETE_RT_EX  | 删除 rt 异常        |      
| 71502 | SET_RT_EX  | 保存 rt 异常        |      

| 错误码 | 错误码名称  | 含义               |  
| ----- | ------ | ---------------- |
| 75202 |MYSQL_CONN_ERR        |Mysql 连接失败|      
| 75203 |MYSQL_EXEC_ERR        |Mysql 执行 sql 失败|      
| 75204 |MYSQL_QUERY_ERR        |Mysql 查询异常|      
| 75246 |ES_DEL_INDEX_ERR        |ES 删除索引异常|      
| 75247 |ES_CREATE_INDEX_ERR        |ES 创建索引异常|      
| 75248 |ES_IS_INDEX_EXIST_ERR        |ES 判断索引是否存在异常|      
| 75249 |ES_QUERY_ERR        |ES 查询异常|      
| 75242 |ES_CONN_ERR        |连接 ES 异常|      
| 75253 |INFLUX_CREATE_DB_ERR        |TSDB 创建库异常|      
| 75210 |AUTH_APPLY_ERR        |权限申请异常|      
| 75211 |AUTH_CHECK_ERR        |权限检查异常|      
| 75260 |SQL_PARSE_ERR        |SQL 解析异常|      

-------------------

| 错误码 | 错误码名称    | 含义                                       |  
| ----- | -------- | ---------------------------------------- |
|06000|请求参数非法| 缺少必要参数，或者参数值格式不正确，具体错误信息请查看错误描述 message 字段。 |      
|06200|CERT_ERR|证书错误
|06201|LICENSE_SERVER_ERR|链接证书服务器错误
|06100|PARAM_ERR|参数错误
|06101|CONFIG_ERR|配置错误
|06102|JSON_FORMAT_ERR|JSON 格式错误
|06103|BAD_REQUEST_PARAMS|请求参数错误
|06104|HTTP_CONNECTION_FAIL|HTTP 链接错误
|06105|BAD_RESPONSE|错误的相应
|06106|CONNECTOR_FRAMEWORK_ERR|Kafka Connect 框架错误
|06107|BAD_AVRO_DATA|Avro 格式错误
|06108|BAD_ENCODING|编码错误
|06109|BAD_ETL_CONF|清晰配置错误
|06110|KAFKA_CONNECT_FAIL|Kafka Connect 致命异常
|06111|INTERRUPTED|中断异常
|06120|MYSQL_ERR|Mysql 异常
|06121|MYSQL_CONNECTION_BROKEN|Mysql 链接断开
|06122|MYSQL_DATA_TOO_LONG|Mysql 数据过长
|06121|CRATEDB_ERR|CrateDB 错误
|06122|TSPIDER_PARTITION_ERR|
|06130|ES_CREATE_MAPPING_FAIL|创建 ES Mapping 失败
|06131|ES_CONNECT_FAIL|ES 链接失败
|06132|ES_UNKNOWN_HOST|ES 主机错误
|06133|ES_BULK_INSERT_FAIL|ES Bulk 插入失败
|06134|ES_UPDATE_INDEX_LIST_FAIL|ES 更新索引列表失败
|06135|ES_CREATE_INDEX_FAIL|ES 创建索引失败
|06136|ES_BAD_CONFIG_FOR_MAPPING|Mapping 配置错误
|06137|ES_BUILD_MAPPING_FAIL|创建 ES Mapping 错误
|06138|ES_GET_INDICES_FAIL|获取 ES 索引失败
|06140|HDFS_ERR|HDFS 错误
|06141|READ_HDFS_WRITE_DB_FAIL|
|06142|MARK_OFFLINE_TASK_FINISH_FAIL|标记离线数据分发状态失败
|06143|CREATE_HDFS_FILE_INSTANCE_FAIL|创建 HDFS 句柄失败
|06144|READ_HDFS_JSON_FAIL|读取 json 占位文件失败
|06145|APPEND_WAL_ERR|追加 WAL 文件失败
|06146|HDFS_ACQUIRE_LEASE_ERR|HDFS 获取文件锁失败
|06147|HDFS_CREATE_WRITER|HDFS 创建 Writer 失败
|06148|HDFS_ACQUIRE_LEASE_TIMEOUT|HDFS 获取文件锁超时
|06149|HDFS_APPLY_WAL_ERR|HDFS 执行 WAL 文件失败
|06150|HDFS_CLOSE_WAL_ERR|HDFS 关闭 WAL 文件失败
|06151|HDFS_BAD_TIME_STRING|HDFS 分发时间格式错误
|06152|HDFS_NO_PARTITION_WRITER|HDFS 分发找不到 writer
|06153|HDFS_CLOSE_PARTITION_WRITER_ERR|HDFS 分发关闭 writer 失败
|06154|HDFS_REACH_TASK_RESTART_LIMIT|HDFS 任务失败重试达到上限
|06155|HDFS_CLOSE_FILE_ERR|HDFS 分发关闭文件错误
|06156|HDFS_INVALID_WAL_STATE|HDFS 分发 WAL 状态错误
|06157|HDFS_WAL_RECOVERY_FAIL|HDFS 分发 WAL 恢复失败
|06158|HDFS_HANDLE_MSG_ERR|HDFS 分发处理 message 错误
|06159|HDFS_DISCARD_TEMP_FILE_FAIL|HDFS 丢弃临时文件失败
|06160|REDIS_ERR|Redis 错误
|06161|REDIS_SENTINEL_POOL_ERR|Redis sentinel 池失败
|06162|REDIS_POOL_ERR|Redis 连接池错误
|06163|REDIS_CONNECTION_BROKEN|Redis 链接中断
|06170|TSDB_ERR|TSDB 错误


------------------


| 错误码 | 错误码名称    | 含义                                       |  
| ----- | -------- | ---------------------------------------- |
| 09000 | ILLEGAL_ARGUMENT   | 缺少必要参数，或者参数值格式不正确，具体错误信息请查看错误描述 message 字段。 |      
| 09101 | NO_INPUT_DATA | 无输入数据                      |      
| 09111 | NO_OUTPUT_DATA | 无输出数据                      |      
| 09200 | API_UNAVALIABLE | API不可用                      |      
| 09201 | BATCH_JOB_ERROR | 离线作业异常                      |      
| 09202 | BATCH_SPARK_ERROR | Spark异常                     |      
| 09203 | BATCH_SPARK_UNCATCH_ERROR | 没有正常捕获处理的Spark异常                     |      
| 09321 | NULL_VALUE | 空值异常                     |      

------------------------

| 错误码| 错误码名称    | 含义                                       |  
| ----- | -------- | ---------------------------------------- |
| 08001 | AGGREGATE_NOT_FOUNDT_EX | 聚合函数未找到                     |      
| 08002 | CHECKPOINT_SAVE_EX | checkpoint存储失败                     |      
| 08003 | FIELD_ANALYTICAL_EX | 字段解析失败                    |      
| 08004 | FIELD_NOT_FOUND_EX | 字段未找到                     |      
| 08005 | FIELD_CAST_EX | 字段函数转换异常                     |      
| 08006 | FILTER_CREATE_EX | 过滤创建异常                    |      
| 08007 | TRANSFORM_CREATE_EX | transform函数创建异常                    |      
| 08011 | KAFKA_SAVE_EX | 保存至消息队列异常                     |      
| 08022 | TRANSFORM_EXECUTE_EX | transform函数执行异常                     |      
