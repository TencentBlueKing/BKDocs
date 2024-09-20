# 内置官方插件

内置官方插件是由蓝鲸官方维护的插件，主要是满足监控平台开箱即用的一个需求。

注意： 虽然是内置的官方插件，也会有一定的依赖和功能局限性。因为只测试过已有的版本，尤其是新出现的版本内置的插件不一定能满足。

如果使用描述不清或者错误，或者有需求可以反馈给官方。

> **注意**：其实基于监控平台的插件定义可以非常方便的扩展监控能力，可以不用完全依赖官方的插件。具体查看
       * [制作Script插件(多种插件类型)](script_collect.md)
        * [制作Exporter插件(复用Prometheus插件)](import_exporter.md)
        * [制作BK-Pull插件(拉取Prometheus数据)](howto_bk-pull.md)
        * [制作DataDog插件](import_datadog_online.md)

## Exporter 插件

### Apache 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| apache.net.bytes | bytes | 总计传输的字节数 |
| apache.net.bytes_per_s | bytes/second | 每秒传输字节数 |
| apache.net.hits | requests | 总的请求数 |
| apache.net.request_per_s | requests/second | 每秒请求数 |
| apache.performance.busy_workers | threads | 活动线程数 |
| apache.performance.cpu_load | percent | CPU 负载 |
| apache.performance.idle_workers | threads | 空闲线程数 |
| apache.performance.uptime | seconds | Apache 运行时间 |

### Nginx 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| nginx.connections.accepted | connections | 接受的客户端连接的总数 |
| nginx.connections.active | connections | 当前客户端连接数 |
| nginx.connections.dropped | connections | 删除的客户端连接的总数 |
| nginx.connections.idle | connections | 当前空闲客户端连接数 |
| nginx.generation |  | 配置(configuration)重新加载的总数 |
| nginx.load_timestamp | milliseconds | 上次重新加载配置(configuration)的时间(自 Epoch 以来的时间) |
| nginx.net.conn_dropped_per_s | connections/second | 连接丢失率 |
| nginx.net.conn_opened_per_s | connections/second | 打开连接的速率 |
| nginx.net.connections | connections | 活动连接的总数 |
| nginx.net.reading | connections | 读取客户端请求的连接数 |
| nginx.net.request_per_s | requests/second | 请求的处理速率 |
| nginx.net.waiting | connections | 等待工作的 keep-alive 连接的数量 |
| nginx.net.writing | connections | 等待上行(upstream)响应 和/或 将响应写回客户端的连接数 |
| nginx.pid |  | 处理状态请求的工作进程的 ID |
| nginx.processes.respawned | processes | 异常终止并重新生成的子进程的总数 |
| nginx.requests.current | requests | 当前客户端请求数 |
| nginx.requests.total | requests | 客户端请求的总数 |
| nginx.server_zone.discarded | requests | 未发送响应而完成的请求总数 |
| nginx.server_zone.processing | requests | 当前正在处理的客户端请求数 |
| nginx.server_zone.received | bytes | 从客户端接收的数据总量 |
| nginx.server_zone.requests | requests | 从客户端接收的客户端请求的总数 |
| nginx.server_zone.responses.1xx | responses | 具有 1xx 状态码的响应数 |
| nginx.server_zone.responses.2xx | responses | 具有 2xx 状态码的响应数 |
| nginx.server_zone.responses.3xx | responses | 具有 3xx 状态码的响应数 |
| nginx.server_zone.responses.4xx | responses | 具有 4xx 状态码的响应数 |
| nginx.server_zone.responses.5xx | responses | 具有 5xx 状态码的响应数 |
| nginx.server_zone.responses.total | responses | 发送到客户端的响应总数 |
| nginx.server_zone.sent | bytes | 发送到客户端的数据总量 |
| nginx.ssl.handshakes |  | 成功的 SSL 握手总数 |
| nginx.ssl.handshakes_failed |  | 失败的 SSL 握手总数 |
| nginx.ssl.session_reuses |  | SSL 握手期间的会话重用总数 |
| nginx.timestamp | milliseconds | 自 Epoch 以来的时间 |
| nginx.upstream.keepalive | connections | 当前空闲的 keepalive 连接数 |
| nginx.upstream.peers.active | connections | 当前活动连接数 |
| nginx.upstream.peers.backup |  | 指示服务器是否为备份服务器的布尔值 |
| nginx.upstream.peers.downstart | milliseconds | 服务器变成 “unavail” 或 “unhealthy” 的时间(自 Epoch 开始) |
| nginx.upstream.peers.downtime | milliseconds | 服务器处于 “unavail” 或 “unhealthy” 状态的总时间 |
| nginx.upstream.peers.fails |  | 与服务器通信失败的总次数 |
| nginx.upstream.peers.health_checks.checks |  | health check 请求总数 |
| nginx.upstream.peers.health_checks.fails |  | health check 的失败数 |
| nginx.upstream.peers.health_checks.last_passed |  | 布尔值，指示上次运行状况检查请求是否成功并通过了测试 |
| nginx.upstream.peers.health_checks.unhealthy |  | 服务器变得不健康 (state “unhealthy”) 的次数 |
| nginx.upstream.peers.id |  | 服务器的 ID |
| nginx.upstream.peers.received | bytes | 从此服务器接收的总数据量 |
| nginx.upstream.peers.requests | requests | 转发到此服务器的客户端请求总数 |
| nginx.upstream.peers.responses.1xx | responses | 具有 1xx 状态码的响应数 |
| nginx.upstream.peers.responses.2xx | responses | 具有 2xx 状态码的响应数 |
| nginx.upstream.peers.responses.3xx | responses | 具有 3xx 状态码的响应数 |
| nginx.upstream.peers.responses.4xx | responses | 具有 4xx 状态码的响应数 |
| nginx.upstream.peers.responses.5xx | responses | 具有 5xx 状态码的响应数 |
| nginx.upstream.peers.responses.total | responses | 从此服务器获取的响应总数 |
| nginx.upstream.peers.selected | milliseconds | 上次选择服务器以处理请求(1.7.5)的时间(自 Epoch 开始) |
| nginx.upstream.peers.sent | bytes | 发送到此服务器的数据总量 |
| nginx.upstream.peers.unavail |  | 由于失败尝试次数达到 max_fails 阈值，服务器对客户端请求不可用 (state “unavail”) 的次数 |
| nginx.upstream.peers.weight |  | Weight of the server |
| nginx.version |  | nginx 的版本 |

### MySQL 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| mysql.galera.wsrep_cluster_size | nodes | 在 Galera 集群中的节点数. |
| mysql.innodb.buffer_pool_free | pages | InnoDB 缓冲池空闲页面数 |
| mysql.innodb.buffer_pool_total | pages | InnoDB 缓冲池的总页数 |
| mysql.innodb.buffer_pool_used | pages | InnoDB 缓冲池中已使用的页数 |
| mysql.innodb.buffer_pool_utilization | fractions | InnoDB 的缓冲池的利用率 |
| mysql.innodb.current_row_locks | locks | The number of current row locks. |
| mysql.innodb.data_reads | reads/second | 数据的读取速率 (读的次数/s) |
| mysql.innodb.data_writes | writes/second | 数据的写速率 (写的次数/s) |
| mysql.innodb.mutex_os_waits | events/second | The rate of mutex OS waits. |
| mysql.innodb.mutex_spin_rounds | events/second | The rate of mutex spin rounds. |
| mysql.innodb.mutex_spin_waits | events/second | The rate of mutex spin waits. |
| mysql.innodb.os_log_fsyncs | writes/second | fsync 写入日志文件的速率(写的次数/s) |
| mysql.innodb.row_lock_time | fractions | 花费在 acquring 行锁上的时间(millisecond/s) |
| mysql.innodb.row_lock_waits | events/second | 行锁每秒要等待的次数(event/s) |
| mysql.net.connections | connections/second | 连接到服务器的速率(连接数量/s) |
| mysql.net.max_connections | connections | 服务器启动同时使用的最大数目连接数 |
| mysql.performance.com_delete | queries/second | 删除语句的速率(次数/s) |
| mysql.performance.com_delete_multi | queries/second | 删除多语句的速率(次数/s) |
| mysql.performance.com_insert | queries/second | 插入语句的速率(次数/s) |
| mysql.performance.com_insert_select | queries/second | 插入 SELECT 语句的速率(次数/s) |
| mysql.performance.com_replace_select | queries/second | 代替 SELECT 语句的速度(次数/s) |
| mysql.performance.com_select | queries/second | SELECT 语句的速度(次数/s) |
| mysql.performance.com_update | queries/second | 更新语句的速度(次数/s) |
| mysql.performance.com_update_multi | queries/second | 更新多语句的速度(次数/s) |
| mysql.performance.created_tmp_disk_tables | tables/second | 执行语句时每秒创建的服务器内部磁盘上的临时表的数量 (表数量/s) |
| mysql.performance.created_tmp_files | files/second | 每秒创建临时文件的数量 (文件数/s) |
| mysql.performance.created_tmp_tables | tables/second | 每秒执行语句时创建的服务器内部临时表的数量(表数量/s) |
| mysql.performance.kernel_time | percent | MySQL 在内核空间中花费的 CPU 时间占比 |
| mysql.performance.key_cache_utilization | fractions | 键缓存利用率 (百分比) |
| mysql.performance.open_files | files | 打开的文件数 |
| mysql.performance.open_tables | tables | 打开的表数量 |
| mysql.performance.qcache_hits | hits/second | 查询缓存命中率 |
| mysql.performance.queries | queries/second | 查询的速率 (次数/s) |
| mysql.performance.questions | queries/second | 服务器执行的语句的速率(次数/s) |
| mysql.performance.slow_queries | queries/second | 慢查询的速率(次数/s) |
| mysql.performance.table_locks_waited |  | 由于表锁定请求无法处理需要等待的总次数 |
| mysql.performance.threads_connected | connections | 当前打开的连接的数量 |
| mysql.performance.threads_running | threads | 正在运行的线程数 |
| mysql.performance.user_time | percent | MySQL 在用户空间中花费的 CPU 时间占比 |
| mysql.replication.seconds_behind_master | seconds | 主服务器(master)和从服务器(slave)之间的滞后时间 |
| mysql.replication.slave_running |  | 一个布尔值，判断该服务器是否为连接到主服务器(master)的从服务器(slave) |

### Redis 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| redis.aof.buffer_length | bytes | AOF 缓冲区大小 |
| redis.aof.last_rewrite_time | seconds | 上次 AOF 重写(rewrite)的持续时间 |
| redis.aof.rewrite |  | AOF 重写(rewrite)的次数 |
| redis.aof.size | bytes | AOF 当前文件大小(aof_current_size) |
| redis.clients.biggest_input_buf |  | 当前客户端连接的最大输入缓存 |
| redis.clients.blocked | connections | 等待阻塞调用的连接数 |
| redis.clients.longest_output_list |  | 当前客户端连接的最长输出列表 |
| redis.cpu.sys | seconds | Redis 服务器消耗的系统 CPU |
| redis.cpu.sys_children | seconds | 后台进程消耗的系统 CPU |
| redis.cpu.user | seconds | Redis 服务器消耗的用户 CPU |
| redis.cpu.user_children | seconds | 后台进程消耗的用户 CPU |
| redis.expires | keys | 已过期的 key 数量 |
| redis.expires.percent | percent | 已过期的 key 百分比 |
| redis.info.latency_ms | milliseconds | Redis info 命令的延迟 |
| redis.key.length |  | 给定 key 中元素的数量 |
| redis.keys | keys | Key 的总数量 |
| redis.keys.evicted | keys | 由于最大内存限制被驱逐(evict)的 key 的总数量 |
| redis.keys.expired | keys | 数据库中过期的 key 的总数量 |
| redis.mem.fragmentation_ratio | fractions | used_memory_rss 和 used_memory 的比率 |
| redis.mem.lua | bytes | Lua 引擎使用的内存量 |
| redis.mem.peak | bytes | Redis 使用的内存的峰值 |
| redis.mem.rss | bytes | 系统给 Redis 分配的内存 |
| redis.mem.used | bytes | 已经被 Redis 分配的内存量 |
| redis.net.clients | connections | 连接的客户端数 (不包括 slaves) |
| redis.net.commands | commands | 服务器运行的命令数 |
| redis.net.rejected | connections | 被拒绝的连接数 |
| redis.net.slaves | connections | 连接的 slave 数 |
| redis.perf.latest_fork_usec | microseconds | 最新 fork 的持续时间 |
| redis.persist | keys | 持久化的 key 数(redis.keys - redis.expires) |
| redis.persist.percent | percent | 持久化的 key 的百分比 |
| redis.pubsub.channels |  | 活跃的发布/订阅的频道数量 |
| redis.pubsub.patterns |  | 活跃的发布/订阅的模式数量 |
| redis.rdb.bgsave |  | 一个标志值，记录了服务器是否正在创建 RDB 文件，正在进行中是 1，否则是 0 |
| redis.rdb.changes_since_last |  | 上次后台保存后，RDB 的改动 |
| redis.rdb.last_bgsave_time | seconds | 最近一次 bg_save 操作的持续时间 |
| redis.replication.backlog_histlen | bytes | 积压在同步缓冲区的数据量 |
| redis.replication.delay | offsets | 复制延迟的偏移 |
| redis.replication.last_io_seconds_ago | seconds | 距离最近一次与主服务器行通信已经过去了多少秒钟 |
| redis.replication.master_link_down_since_seconds | seconds | 主从服务器连接断开了多少秒 |
| redis.replication.master_repl_offset | offsets | 从 master 报告的复制偏移量 |
| redis.replication.slave_repl_offset | offsets | 从 slave 报告的复制偏移量 |
| redis.replication.sync |  | 一个标志值，如果同步正在进行，则为 1，否则为 0 |
| redis.replication.sync_left_bytes | bytes | 距离同步完成还剩多少数据量 |
| redis.slowlog.micros.95percentile | microseconds | 在慢日志中，查询报告的持续时间的第 95 百分位值 |
| redis.slowlog.micros.avg | microseconds | 在慢日志中，查询报告的持续时间平均值 |
| redis.slowlog.micros.count | queries/second | 在慢日志中，报告的查询速率 |
| redis.slowlog.micros.max | microseconds | 在慢日志中，查询报告的持续时间最大值 |
| redis.slowlog.micros.median | microseconds | 在慢日志中，查询报告的持续时间中位值 |
| redis.stats.keyspace_hits | keys | 在数据库中查找 key 成功的次数 |
| redis.stats.keyspace_misses | keys | 在数据库中查找 key 失败的次数 |

### Oracle 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| oracle.RWParse.oracledb_Executions |  | SQL 执行速率 |
| oracle.RWParse.oracledb_HardParse |  | SQL 硬解析率 |
| oracle.RWParse.oracledb_LogicalReads |  | 逻辑块读速率 |
| oracle.RWParse.oracledb_PhysicalReads |  | 物理块读速率 |
| oracle.RWParse.oracledb_PhysicalWrites |  | 物理块写速率 |
| oracle.RWParse.oracledb_TotalParse |  | SQL 解析速率 |
| oracle.RWParse.oracledb_Transaction |  | 每秒事务数 |
| oracle.RWParse.oracledb_insstatus |  | 实例状态(1 代表 ONLINE，0 代表 OFFLINE) |
| oracle.RWParse.oracledb_runhealthtime | s | 数据库健康运行时长 |
| oracle.MemoryInfo.oracledb_PGAFreeSize | MB | PGA 空闲大小 |
| oracle.MemoryInfo.oracledb_PGATotalSize | MB | PGA 分配大小 |
| oracle.MemoryInfo.oracledb_PGAUsedRate | % | PGA 使用率 |
| oracle.MemoryInfo.oracledb_PGAlUsedSize | MB | PGA 使用大小 |
| oracle.MemoryInfo.oracledb_SGAFreeSize | MB | SGA 空闲大小 |
| oracle.MemoryInfo.oracledb_SGATotalSize | MB | SGA 分配大小 |
| oracle.MemoryInfo.oracledb_SGAUsedRate | % | SGA 使用率 |
| oracle.MemoryInfo.oracledb_SGAUsedSize | MB | SGA 使用大小 |
| oracle.MemoryInfo.oracledb_SharePoolFreeSize | MB | SharePool 空闲大小 |
| oracle.MemoryInfo.oracledb_SharePoolTotalSize | MB | SharePool 分配大小 |
| oracle.MemoryInfo.oracledb_SharePoolUsedRate | % | SharePool 使用率 |
| oracle.MemoryInfo.oracledb_SharePoolUsedSize | MB | SharePool 使用大小 |
| oracle.Table_space.oracledb_TablespaceFree | MB | 表空间空闲大小 |
| oracle.Table_space.oracledb_TablespaceRate | % | 表空间使用率 |
| oracle.Table_space.oracledb_TablespaceStatus |  | 表空间状态(1 代表 ONLINE，0 代表 OFFLINE) |
| oracle.Table_space.oracledb_TablespaceTotal | MB | 表空间分配大小 |
| oracle.Table_space.oracledb_TablespaceUsed | MB | 表空间使用大小 |
| oracle.sys_param.oracledb_ActiveSession |  | 活跃用户会话数 |
| oracle.sys_param.oracledb_InactiveSession |  | 非活跃用户会话数 |
| oracle.sys_param.oracledb_SessionMax |  | 会话分配数 |
| oracle.sys_param.oracledb_SessionTotal |  | 用户会话数 |
| oracle.sys_param.oracledb_BlockNum |  | 当前阻塞数量 |
| oracle.sys_param.oracledb_BufferCacheHit | % | 缓冲区命中率 |
| oracle.sys_param.oracledb_BufferCacheSize | MB | 缓冲区大小 |
| oracle.sys_param.oracledb_DeadLockNum |  | 死锁数量 |
| oracle.sys_param.oracledb_ProcessMax |  | 进程分配数 |
| oracle.sys_param.oracledb_ProcessTotal |  | 进程总数 |
| oracle.sys_param.oracledb_RedoNum |  | Redo 日志文件组数 |
| oracle.sys_param.oracledb_RedoSize | MB | Redo 日志文件总大小 |
| oracle.sys_param.oracledb_SortMemory | % | 内存排序率 |
| oracle.sys_param.oracledb_sharepoolhit | % | 共享池命中率 |
| oracle.ASMInfo.oracledb_ASMDisk_total | MB | ASM 总磁盘大小 |
| oracle.ASMInfo.oracledb_ASMDisk_free | MB | ASM 空闲磁盘大小 |
| oracle.ASMInfo.oracledb_ASMDisk_state |  | ASM 磁盘状态(1 代表 MOUNT，0 代表其他非正常状态) |
| oracle.scanIpInfo.oracledb_ScanIPStatus |  | scanIP 监听状态(1 代表端口连通，0 代表端口不通) |
| oracle.InsIpInfo.oracledb_InsIpStatus |  | 实例 IP 监听状态(1 代表端口连通，0 代表端口不通) |
| oracle.VIPInfo.oracledb_VIPStatus |  | VIP 监听状态(1 代表端口连通，0 代表端口不通) |

### SQL Server 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| mssql.instance_Lock.mssqldb_LockWaits_sec |  | 每秒锁等待次数 |
| mssql.db_status.mssqldb_database_status |  | 数据库状态 0 代表 offline 1 代表 online|
| mssql.db_status.mssqldb_used_data_size | MB | 数据库数据大小 |
| mssql.db_status.mssqldb_max_data_size | MB | 数据库数据最大值 |
| mssql.db_status.mssqldb_log_size | MB | 日志大小 |
| mssql.db_status.mssqldb_LogGrowths | MB | 日志增长量 |
| mssql.db_status.mssqldb_io_stall_total_ms | s | 用户等待 IO 总时间 |
| mssql.db_status.mssqldb_io_stall_read_ms | s | 用户等待读取总时间 |
| mssql.db_status.mssqldb_io_stall_write_ms | s | 用户等待写入总时间 |
| mssql.db_status.mssqldb_connections |  | 数据库连接数 |
| mssql.db_status.mssqldb_log_space_used | % | 日志空间使用率 |
| mssql.db_perform.mssqldb_up |  | 实例状态 0 代表 offline 1 代表 online|
| mssql.db_perform.mssqldb_PageSplits_sec |  | 每秒产生的页拆分数/周期，周期指设置的数据采集周期 |
| mssql.db_perform.mssqldb_ProcessesBlocked |  | 当前堵塞进程数 |
| mssql.db_perform.mssqldb_SqlCompilations_sec |  | SQL 每秒编译次数/周期，周期指设置的数据采集周期 |
| mssql.db_perform.mssqldb_SqlReCompilations_sec |  | SQL 每秒重编译次数/周期，周期指设置的数据采集周期 |
| mssql.db_perform.mssqldb_UserConnections |  | 用户连接数 |
| mssql.db_perform.mssqldb_deadlocks_sec |  | 导致死锁的每秒锁定请求数 |
| mssql.db_perform.mssqldb_kill_conn_errors_sec |  | 连接错误数 |
| mssql.db_perform.mssqldb_local_time | s | 实例运行时间 |
| mssql.db_perform.mssqldb_memory_utilization_percentage | % | 内存使用率 |
| mssql.db_perform.mssqldb_batch_requests_sec |  | 每秒查询数/周期，周期指设置的数据采集周期 |
| mssql.db_perform.mssqldb_page_life_expectancy | s | 数据页在内存中的驻留时间 |
| mssql.db_perform.mssqldb_page_fault_count |  | 数据页错误数量/周期，周期指设置的数据采集周期 |
| mssql.db_perform.mssqldb_total_page_file_kb | MB | 总页面文件 |
| mssql.db_perform.mssqldb_available_page_file_kb | MB | 可用页面文件 |
| mssql.db_perform.mssqldb_total_physical_memory_kb | MB | 总物理内存 |
| mssql.db_perform.mssqldb_available_physical_memory_kb | MB | 可用物理内存 |
| mssql.db_perform.mssqldb_hit_radio | % | 实例缓冲区命中率 |
| mssql.db_perform.mssqldb_total_pages |  | 实例缓冲区总页数 |
| mssql.db_perform.mssqldb_used_rate | % | 实例缓冲区使用率 |
| mssql.db_perform.mssqldb_used_pages |  | 实例缓冲区使用页数 |
| mssql.db_perform.mssqldb_free_pages |  | 实例缓冲区空闲页数 |
| mssql.db_perform.mssqldb_tps |  | 每秒事务数/周期，周期指设置的数据采集周期 |
| mssql.db_perform.mssqldb_full_scan |  | 每秒全表扫描数/周期，周期指设置的数据采集周期 |
| mssql.db_perform.mssqldb_sessions |  | 用户会话数 |
| mssql.db_perform.mssqldb_active_sessions |  | 活跃用户会话数 |
| mssql.db_perform.mssqldb_inactive_sessions |  | 非活跃用户会话数 |
| mssql.cip.mssqldb_ha_ip_status |  | ip 监听状态 0 代表监听端口不通 1 代表监听端口通畅|

### HAProxy 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| haproxy_backend_bytes_in_total | B | 后端主机传入字节速率/分 |
| haproxy_backend_bytes_out_total | B | 后端主机发送字节速率/分 |
| haproxy_backend_connection_errors_total |  | 连接错误数/分 |
| haproxy_backend_current_queue |  | 未分配的后端请求数 |
| haproxy_backend_current_server |  | 后端服务数 |
| haproxy_backend_current_sessions |  | 活跃后端会话数 |
| haproxy_backend_up |  | 后端服务状态 |
| haproxy_backend_http_responses_total |  | 后端 HTTP 响应码 |
| haproxy_frontend_bytes_in_total |  | 前端主机传入字节速率/分 |
| haproxy_frontend_bytes_out_total |  | 前端主机发送字节速率/分 |
| haproxy_frontend_current_session |  | 前端会话数 |
| haproxy_frontend_http_requests_total |  | 前端 HTTP 请求码 |
| haproxy_frontend_http_responses_total |  | 前端 HTTP 响应码 |

### Zookeeper 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| zk_packets_received |  | 接收的数据包数量 |
| zk_packets_sent |  | 发送的数据包数量 |
| zk_avg_latency |  | 响应客户端请求的平均时间 |
| zk_max_latency |  | 响应客户端请求的最大时间 |
| zk_min_latency |  | 响应客户端请求的最小时间 |
| zk_outstanding_requests |  | 排队请求数 |
| zk_pending_syncs |  | 等待同步的 follower 数 |
| zk_synced_followers |  | 同步的 follower 数 |
| zk_num_alive_connections |  | 客户端连接总数 |
| zk_approximate_data_size |  | 数据集近似值 |
| zk_ephemerals_count |  | 短暂节点数 |
| zk_followers |  | followers 数 |
| zk_max_file_descriptor_count |  | 文件句柄上限 |
| zk_open_file_descriptor_count |  | 文件句柄数 |
| zk_watch_count |  | watches 数 |
| zk_znode_count |  | 节点数 |
| zk_up |  | ZooKeeper 存活状态 |
| zk_server_state |  | 服务身份 |

### RabbitMQ 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| rabbitmq_channelsTotal |  | channels 开启总数 |
| rabbitmq_connectionsTotal |  | 连接开启总数 |
| rabbitmq_consumersTotal |  | 消费者数量 |
| rabbitmq_exchangesTotal |  | 使用中的 exchanges 总数 |
| rabbitmq_queue_messages_ready_total |  | 准备发送给客户端的消息数量 |
| rabbitmq_queue_messages_total |  | 集群中的消息总数 |
| rabbitmq_queue_messages_unacknowledged_total |  | 发送后未被确认的消息数 |
| rabbitmq_queuesTotal |  | 使用中的队列数 |
| rabbitmq_up |  | 存活状态 |
| rabbitmq_fd_total |  | 文件句柄数上限 |
| rabbitmq_fd_used |  | 已用文件句柄数 |
| rabbitmq_node_mem_used | MB | 内存使用量 |
| rabbitmq_partitions |  | 此节点可见的网络分区数量 |
| rabbitmq_running |  | 运行 nodes 数 |

### Memcached 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| memcached_commands_total |  | 请求状态/分 |
| memcached_connections_total |  | 连接速率/分 |
| memcached_current_bytes | MB | 当前存储 item 的大小 |
| memcached_current_connections |  | 当前服务器打开的连接数 |
| memcached_current_items |  | 实例当前 item 数 |
| memcached_items_evicted_total |  | 从缓存中给新 item 的速率/分 |
| memcached_items_total |  | 服务启动后存储 item 总数 |
| memcached_limit_bytes | MB | 内存使用上限 |
| memcached_malloced_bytes | MB | 分配 slab page 内存量 |
| memcached_max_connections |  | 连接数上限 |
| memcached_read_bytes_total | bytes | 服务器从网络读取字节的速率/分 |
| memcached_written_bytes_total | bytes | 服务器向网络发送字节的速率/分 |
| memcached_uptime_seconds | s | 服务运行时长 |
| memcached_up |  | 存活状态 |

### ElasticSearch 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| elasticsearch_docs_deleted |  | 集群中所有分片的删除的文档 |
| elasticsearch_indexing_delete_total |  | 从 index 中删除的文档数量 |
| elasticsearch_thread_pool_generic_queue |  | generic 线程池排队线程数 |
| elasticsearch_thread_pool_management_active |  | mgt 线程池活跃线程数 |
| elasticsearch_thread_pool_refresh_active |  | refresh 线程池活跃线程数 |
| elasticsearch_indexing_index_current |  | index 中被索引的文档数量 |
| elasticsearch_indexing_delete_time | s | 从 index 中删除文档花费时间 |
| elasticsearch_indexing_index_time | s | 从 index 索引文档花费时间 |
| elasticsearch_process_open_fd |  | 打开和当前进程相关的文件数据 |
| elasticsearch_indexing_delete_current |  | 从 index 中删除的文档数量 |
| elasticsearch_thread_pool_flush_queue |  | bulk 线程池排队线程数 |
| elasticsearch_thread_pool_force_merge_queue |  | merge 线程池活跃线程数 |
| elasticsearch_get_total |  | 文档存在时 get 请求次数 |
| elasticsearch_thread_pool_refresh_queue |  | refresh 线程池排队线程数 |
| elasticsearch_thread_pool_index_queue |  | index 线程池排队线程数 |
| elasticsearch_thread_pool_search_threads |  | search 线程池线程总数 |
| elasticsearch_transport_tx_size | MB | 集群通信中发送的数据大小 |
| elasticsearch_indexing_index_total |  | index 中被索引的文档数量 |
| elasticsearch_search_fetch_open_contexts |  | 活跃查询次数 |
| elasticsearch_docs_count |  | 集群中所有分片的文档 |
| elasticsearch_thread_pool_management_queue |  | mgt 线程池排队的线程数 |
| elasticsearch_thread_pool_bulk_active |  | bulk 线程池活跃线程数 |
| elasticsearch_thread_pool_search_queue |  | search 线程池排队线程数 |
| elasticsearch_get_time | s | get 请求上的总时间 |
| elasticsearch_merges_current |  | 当前的活跃段合并数量 |
| elasticsearch_thread_pool_flush_threads |  | bulk 线程池线程总数 |
| elasticsearch_merges_current_size | MB | 当前被合并的段的大小 |
| elasticsearch_thread_pool_snapshot_active |  | snap 线程池活跃线程数 |
| elasticsearch_search_fetch_current |  | 当前运行的查询取回操作的数量 |
| elasticsearch_flush_total |  | index 刷新到磁盘次数 |
| elasticsearch_flush_total_time | s | index 刷新到磁盘花费时间 |
| elasticsearch_thread_pool_generic_threads |  | generic 线程池线程总数 |
| elasticsearch_store_size | MB | 总的存储大小 |
| elasticsearch_transport_tx_count |  | 在集群通信中发送的包的总数量 |
| elasticsearch_merges_total |  | 所有段的合并数量 |
| elasticsearch_thread_pool_snapshot_queue |  | snap 线程池排队线程数 |
| elasticsearch_search_fetch_time | s | 查询取回操作的总时间 |
| elasticsearch_thread_pool_search_active |  | search 线程池活跃线程数 |
| elasticsearch_thread_pool_get_queue |  | get 线程池排队线程数 |
| elasticsearch_fielddata_evictions |  | field 缓存被驱逐的数据量 |
| elasticsearch_thread_pool_index_threads |  | index 线程池线程总数 |
| elasticsearch_thread_pool_flush_active |  | flush 队列中活跃线程数 |
| elasticsearch_search_query_time | s | 查询操作的总时间 |
| elasticsearch_get_exists_time | s | 文档存在时 get 请求时间 |
| elasticsearch_get_missing_total |  | 文档丢失时 get 请求次数 |
| elasticsearch_transport_rx_count |  | 集群通信接受包的总数量 |
| elasticsearch_thread_pool_bulk_threads |  | bulk 线程池线程总数 |
| elasticsearch_transport_rx_size | MB | 集群通信接受的数据大小 |
| elasticsearch_thread_pool_force_merge_threads |  | merge 线程池线程总数 |
| elasticsearch_refresh_total |  | 总的 index 刷新次数 |
| elasticsearch_thread_pool_snapshot_threads |  | snap 线程池线程总数 |
| elasticsearch_fielddata_size | MB | field 缓存区大小 |
| elasticsearch_transport_server_open |  | 为集群通信打开的连接数 |
| elasticsearch_search_query_total |  | 查询操作的数量 |
| elasticsearch_thread_pool_bulk_queue |  | bulk 线程池排队的线程数 |
| elasticsearch_thread_pool_get_threads |  | get 线程池的线程总数 |
| elasticsearch_get_current |  | 正在运行的 get 请求数 |
| elasticsearch_http_current_open |  | 当前打开的 http 连接数 |
| elasticsearch_get_missing_time | s | 文档丢失花费 get 请求时间 |
| elasticsearch_thread_pool_index_active |  | index 线程池活跃线程数 |
| elasticsearch_refresh_total_time | s | index 刷新花费总时间 |
| elasticsearch_http_total_opened |  | 打开 http 的总连接数 |
| elasticsearch_thread_pool_generic_active |  | generic 线程池活跃线程数 |
| elasticsearch_thread_pool_force_merge_active |  | merge 线程池活跃线程数 |
| elasticsearch_thread_pool_refresh_threads |  | refresh 线程池线程总数 |
| elasticsearch_search_fetch_total |  | 查询取回操作的数量 |
| elasticsearch_get_exists_total |  | 文档存在时 get 请求数 |
| elasticsearch_merges_total_size | MB | 所有合并段的大小 |
| elasticsearch_merges_current_docs |  | 当前跨段合并的文档数量 |
| elasticsearch_merges_total_docs |  | 跨所有合并段的文档数量 |
| elasticsearch_thread_pool_get_active |  | get 线程池活跃线程数 |
| elasticsearch_search_query_current |  | 当前运行查询操作的数量 |
| elasticsearch_thread_pool_management_threads |  | mgt 线程池线程总数 |
| elasticsearch_merges_total_time | s | 花在合并段上的时间 |
| elasticsearch_active_primary_shards |  | 集群中活跃的主分片数量 |
| elasticsearch_pending_tasks_total |  | 总的未完成的 task 数量 |
| elasticsearch_unassigned_shards |  | 未分配节点的分片数量 |
| elasticsearch_pending_tasks_priority_urgent |  | 紧急优先未完成的 task 数量 |
| elasticsearch_pending_tasks_priority_high |  | 高优先级的未完成的 task 数量 |
| elasticsearch_cluster_status |  | 集群健康数字红=0 黄=1 绿=2 |
| elasticsearch_relocating_shards |  | 节点搬到另一个节点的分片数量 |
| elasticsearch_number_of_data_nodes |  | 集群中 node 数据总数 |
| elasticsearch_number_of_nodes |  | 集群中 node 总数 |
| elasticsearch_active_shards |  | 集群中活跃分片数量 |
| elasticsearch_initializing_shards |  | 当前初始化碎片数量 |

### Kafka 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| kafka_replication_leader_elections_rate |  | leader 选举频率 |
| kafka_replication_isr_shrinks_rate | nodes/s | 副本离开 ISR 池的速率 |
| kafka_request_handler_avg_idle_pct_rate |  | 处理请求线程时间百分比 |
| kafka_net_bytes_out_rate | bytes/s | 传出字节速率 |
| kafka_net_bytes_rejected_rate | bytes/s | 被拒绝的字节速率 |
| kafka_messages_in_rate |  | 传入消息速率 |
| kafka_net_bytes_in_rate | bytes/s | 传入字节速率 |
| kafka_request_fetch_failed_rate |  | 客户端请求失败次数 |
| kafka_replication_unclean_leader_elections_rate |  | unleader 选举频率 |
| kafka_replication_isr_expands_rate | nodes/s | 副本加入 ISR 池的速率 |
| kafka_request_produce_failed_rate |  | 失败的 produce 请求数 |
| kafka_request_produce_time_99percentile | ms | 99%produce 请求时间 |
| kafka_request_metadata_time_99percentile | ms | 99%元数据请求时间 |
| kafka_request_update_metadata_time_99percentile | ms | 更新 99%元数据请求的时间 |
| kafka_request_produce_time_avg | ms | produce 请求数的时间 |
| kafka_request_update_metadata_time_avg | ms | 更新元数据请求的时间  |
| kafka_request_produce_rate |  | produce 请求数 |
| kafka_request_metadata_time_avg | ms | 元数据平均请求时间 |

### Mongodb 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| mongodb_replset_health |  | 副本集状态 |
| mongodb_metrics_repl_network_readerscreated |  | oplog 查询进程创建的个数 |
| mongodb_opcounters_insert |  | 插入操作的次数 |
| mongodb_metrics_repl_network_getmores_totalmillis | ms/s | getmore 操作收集数据时间 |
| mongodb_metrics_repl_buffer_count |  | oplog 缓存中的操作数 |
| mongodb_metrics_getlasterror_wtime_totalmillis | ms/s | 执行获取最后错误操作的时间 |
| mongodb_metrics_repl_network_getmores_num |  | getmore 操作的个数 |
| mongodb_connections_available |  | 未使用的可用连接数 |
| mongodb_opcountersrepl_delete |  | 副本集删除操作的次数 |
| mongodb_asserts_regular |  | 常规断言数 |
| mongodb_metrics_queryexecutor_scanned |  | 被扫描的索引个数 |
| mongodb_asserts_msg |  | 消息断言数 |
| mongodb_mem_mapped | MB | 数据库映射的内存总数 |
| mongodb_metrics_repl_network_bytes | MB | 从服务器同步源读取的数据总量 |
| mongodb_metrics_record_moves |  | 文档在磁盘上移动的次数 |
| mongodb_opcounters_query |  | 查询操作的次数 |
| mongodb_uptime | s | mongo 进程启动时长 |
| mongodb_opcounters_delete |  | 删除操作的次数 |
| mongodb_metrics_getlasterror_wtime_num |  | 写操作获取最后错误操作的次数 |
| mongodb_metrics_operation_fastmod |  | 不导致更新操作的次数 |
| mongodb_metrics_document_updated |  | 文档更新数 |
| mongodb_mem_resident | MB | 数据库进程在使用的内存总数 |
| mongodb_mem_virtual | MB | 数据库进程使用的虚拟内存总数 |
| mongodb_asserts_user |  | 用户断言数 |
| mongodb_metrics_repl_apply_batches_totalmillis | ms/s | 执行来自 oplog 的操作的时间 |
| mongodb_metrics_document_inserted |  | 文档增加数 |
| mongodb_globallock_currentqueue_writers |  | 当前在队列中等待写锁的操作数 |
| mongodb_opcountersrepl_query |  | 副本集查询操作的次数 |
| mongodb_metrics_operation_scanandorder |  | 返回不能索引排序数字请求次数 |
| mongodb_connections_totalcreated |  | 所有连接数 |
| mongodb_metrics_operation_idhack |  | 包含_id 字段的请求次数 |
| mongodb_metrics_repl_buffer_sizebytes | MB | oplog 缓存的大小 |
| mongodb_opcountersrepl_command |  | 命令的总数 |
| mongodb_metrics_repl_buffer_maxsizebytes | MB | 缓存的最大值 |
| mongodb_metrics_document_returned |  | 文档被请求返回数 |
| mongodb_metrics_ttl_deleteddocuments |  | 有 ttl 索引删除的文档数 |
| mongodb_metrics_repl_network_ops |  | 读取操作的个数 |
| mongodb_metrics_document_deleted |  | 文档删除数 |
| mongodb_metrics_repl_apply_batches_num |  | 批处理的个数 |
| mongodb_asserts_rollovers |  | 计数器 rollover 次数 |
| mongodb_opcounters_command |  | 传给数据库的命令的总数 |
| mongodb_globallock_totaltime | μs | 全局锁启动时长 |
| mongodb_opcountersrepl_insert |  | 副本集插入操作的次数 |
| mongodb_opcountersrepl_getmore |  | 副本集 getmore 操作的次数 |
| mongodb_opcountersrepl_update |  | 副本集更新操作的次数 |
| mongodb_opcounters_update |  | 更新操作的次数 |
| mongodb_asserts_warning |  | 警告断言数 |
| mongodb_opcounters_getmore |  | getmore 操作的次数 |
| mongodb_globallock_currentqueue_total |  | 当前在队列中等待锁的操作数 |
| mongodb_metrics_repl_apply_ops |  | 执行的 oplog 操作的个数 |
| mongodb_metrics_ttl_passes |  | 删除文档次数 |
| mongodb_connections_current |  | 从客户端到数据库服务端的连接数 |
| mongodb_metrics_getlasterror_wtimeouts |  | 超时导致操作数 |
| mongodb_globallock_currentqueue_readers |  | 当前在队列中等待读锁的操作数 |
| mongodb_stats_indexsize |  | 库中所有创建的索引总数 |
| mongodb_stats_objects |  | 库中所有的文档数 |
| mongodb_stats_indexes |  | 库中总索引数 |
| mongodb_stats_storagesize | MB | collections 存储空间 |
| mongodb_stats_datasize | MB | 库中的数据量 |

### Ceph 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| ceph_num_in_osds |  | 参与存储守护进程的数量 |
| ceph_aggregate_pct_used | % | 总体容量使用量 |
| ceph_num_up_osds |  | 在线存储守护进程的数量 |
| ceph_num_mons |  | 监视器守护进程的数量 |
| ceph_num_pools |  | 存储池的数量 |
| ceph_pgstate_active_clean |  | 活动归置组数量 |
| ceph_num_pgs |  | 可用归置组的数量 |
| ceph_num_near_full_osds |  | 几乎完整的 osd 数量 |
| ceph_num_full_osds |  | 完整 osd 数量 |
| ceph_total_objects |  | 对象总数 |
| ceph_num_osds |  | 已知存储守护进程的数量 |
| ceph_read_op_per_sec | MB/s | 存储池每秒读字节数 |
| ceph_num_objects |  | 对象个数 |
| ceph_write_op_per_sec | MB/s | 存储池每秒写字节数 |
| ceph_write_bytes_sec | MB/s | ceph 每秒写字节数 |
| ceph_read_bytes_sec | MB/s | ceph 每秒读字节数 |
| ceph_pct_used | % | 使用量 |
| ceph_op_per_sec |  | 池每秒 IO 操作 |
| ceph_apply_latency_ms | s | 磁盘更新所需时间 |
| ceph_commit_latency_ms | s | 日志操作所需时间 |

## JMX 插件

### JMX 组件

#### 指标说明

| 指标                              | 单位     | 具体含义                   |
| ------------------------------- | ------ | ---------------------- |
| jvm_buffer_pool_used_bytes      | MB   | 已使用缓冲池的大小             |
| jvm_buffer_pool_capacity_bytes  | MB   | 缓冲池的字节容量               |
| jvm_buffer_pool_used_buffers    |       | 已经使用的缓冲数量              |
| jmx_config_reload_success_total |       | 已成功重新加载配置的次数           |
| jvm_threads_current             |       | 当前线程数                  |
| jvm_threads_daemon              |       | 当前后台线程数                |
| jvm_threads_peak                |      | 当前峰值线程数                |
| jvm_threads_started_total       |       | 已经启动的线程计数              |
| jvm_threads_deadlocked          |       | 等待获取对象监视器或自己的同步器的死锁线程数 |
| jvm_threads_deadlocked_monitor  |       | 等待获取对象监视器的死锁线程数        |
| jmx_scrape_duration_seconds     | 秒 | scrape 的时间              |
| jmx_scrape_error                |       | scrape 失败次数             |
| jvm_classes_loaded              |       | 当前加载的类数量               |
| jvm_classes_loaded_total        |       | 从 JVM 开始执行以来已经加载的类的总数    |
| jvm_classes_unloaded_total      |       | 从 JVM 开始执行以来未加载的类的总数     |
| jvm_info                        |        | JVM 版本信息                |
| jvm_memory_bytes_used           | MB   | 已经使用的内存                |
| jvm_memory_bytes_committed      | MB   | 已经提交的内存                |
| jvm_memory_bytes_max            | MB   | 最大内存                   |
| jvm_memory_bytes_init           | MB   | 初始化内存                  |
| jvm_memory_pool_bytes_used      | MB   | 内存池中已经使用的内存            |
| jvm_memory_pool_bytes_committed | MB   | 内存池中已经提交的内存            |
| jvm_memory_pool_bytes_max       | MB   | 内存池中最大内存               |
| jvm_memory_pool_bytes_init      | MB   | 内存池中初始化内存              |
| jmx_config_reload_failure_total |       | 配置 reload 失败的次数          |
| jvm_gc_collection_seconds_count | 秒 | gc 时间                   |

### Tomcat 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| tomcat.bytes_rcvd | bytes/second | 每秒接收的字节数 |
| tomcat.bytes_sent | bytes/second | 每秒发送的字节数 |
| tomcat.cache.access_count | gets/second | 每秒访问缓存的次数 |
| tomcat.cache.hits_count | hits/second | 每秒缓冲命中的次数 |
| tomcat.error_count | errors/second | 发生错误的请求数 |
| tomcat.jsp.count | pages/second | web 模块中加载的 JSP 数量 |
| tomcat.jsp.reload_count | pages/second | web 模块中重新加载的 JSP 数量 |
| tomcat.max_time | milliseconds | 最长的请求处理时间 (milliseconds) |
| tomcat.processing_time |  | 每秒所有请求的处理时间之和 |
| tomcat.request_count | requests/second | 每秒总请求数 |
| tomcat.servlet.error_count | errors/second | servlet 接收的错误请求数 /s |
| tomcat.servlet.processing_time |  | 每秒经过 servlet 的所有请求的处理时间之和 |
| tomcat.servlet.request_count | requests/second | 每秒经过 servlet 的总请求数 |
| tomcat.threads.busy | threads | 正在使用的线程数 |
| tomcat.threads.count | threads | 当前线程池的线程数 |
| tomcat.threads.max | threads | 线程池最大可以产生的线程数 |

## DataDog 插件

## BK-Pull 插件

### Weblogic 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| weblogic.config.webapp_config_deployment_state |  | 部署状态，当前应用的部署状态，如正在部署、部署失败、部署成功等 |
| weblogic.config.webapp_config_jsppage_check_secs |  | 检查 JSP 文件是否发生更改并需要重新编译的频率 |
| weblogic.config.webapp_config_open_sessions_current_count |  | 应用程序当前会话数 |
| weblogic.config.webapp_config_open_sessions_high_count |  | 应用程序最高会话数 |
| weblogic.config.webapp_config_servlet_reload_check_secs |  | 检查 servlet 是否已被修改的频率 |
| weblogic.config.webapp_config_session_cookie_max_age_secs | s | 会话缓存保留时长 |
| weblogic.config.webapp_config_session_idlength |  | 会话 id 长度(数字位数) |
| weblogic.config.webapp_config_session_invalidation_interval_secs | s | 将超时和无效会话释放前等待的时间 |
| weblogic.config.webapp_config_session_timeout_secs | s | 会话超时设置 |
| weblogic.config.webapp_config_sessions_opened_total_count |  | 应用程序会话打开数/周期，周期指设置的数据采集周期 |
| weblogic.wls_servlet.weblogic_servlet_execution_time_average | s | 执行各个 servlet 调用的平均时长 |
| weblogic.wls_servlet.weblogic_servlet_execution_time_high | s | 执行最长 servlet 调用的时长 |
| weblogic.wls_servlet.weblogic_servlet_execution_time_low | s | 执行最短 servlet 调用的时长 |
| weblogic.wls_servlet.weblogic_servlet_execution_time_total | s | 执行完所有 servlet 调用的时长 |
| weblogic.wls_servlet.weblogic_servlet_invocation_total_count |  | servlet 调用总次数/周期，周期指设置的数据采集周期 |
| weblogic.wls_servlet.weblogic_servlet_pool_max_capacity |  | servlet 池的线程最大容量 |
| weblogic.wls_servlet.weblogic_servlet_reload_total_count |  | servlet 重载的次数/周期，周期指设置的数据采集周期 |
| weblogic.workmanager.workmanager_completed_daemon_requests |  | 已处理的守护请求数/周期，周期指设置的数据采集周期 |
| weblogic.workmanager.workmanager_completed_requests |  | 已处理的请求数/周期，周期指设置的数据采集周期 |
| weblogic.workmanager.workmanager_pending_daemon_requests |  | 挂起的守护请求数/周期，周期指设置的数据采集周期 |
| weblogic.workmanager.workmanager_pending_requests |  | 挂起的请求数/周期，周期指设置的数据采集周期 |
| weblogic.workmanager.workmanager_stuck_thread_count |  | 假死的线程数 |
| weblogic.jvm.jvm_heap_free_current | MB | 堆内存空闲量 |
| weblogic.jvm.jvm_heap_free_percent | % | 堆内存使用百分比 |
| weblogic.jvm.jvm_heap_size_current | MB | 堆内存使用量 |
| weblogic.jvm.jvm_heap_size_max | MB | 堆内存最大允许值 |
| weblogic.jvm.jvm_process_cpu_load |  | jvm 的 cpu 负载 |
| weblogic.jvm.jvm_uptime | s | jvm 运行时长 |

### Consul 插件

#### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| consul_net_node_latency_max | ms | 从该节点到其他节点的最大延迟 |
| consul_net_node_latency_p25 | ms | 从该节点到其他节点的 p25 延迟 |
| consul_net_node_latency_p95 | ms | 从该节点到其他节点的 p95 延迟 |
| consul_net_node_latency_p90 | ms | 从该节点到其他节点的 p90 延迟 |
| consul_net_node_latency_p99 | ms | 从该节点到其他节点的 p99 延迟 |
| consul_net_node_latency_min | ms | 从该节点到其他节点的最小延迟 |
| consul_net_node_latency_p75 | ms | 从该节点到其他节点的 p75 延迟 |
| consul_net_node_latency_median | ms | 从该节点到其他节点的中等延迟 |
| consul_peers |  | 对等体的数量 |
| consul_catalog_nodes_warning |  | 警告节点数量 |
| consul_catalog_nodes_passing |  | 传递节点数量 |
| consul_catalog_nodes_up |  | 节点数 |
| consul_catalog_nodes_critical |  | 关键节点数量 |
| consul_catalog_services_critical |  | 关键服务总数 |
| consul_catalog_services_passing |  | 传递服务总量 |
| consul_catalog_services_up |  | 服务总量 |
| consul_catalog_services_warning |  | 警告服务总数 |

## IIS 插件

### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| iis_httpd_request_method_options |  | options 方法请求数 |
| iis_httpd_request_method_head |  | head 方法请求数 |
| iis_httpd_request_method_del |  | del 方法请求数 |
| iis_requests_cgi |  | cgi 请求执行数 |
| iis_requests_isapi |  | isapi 请求执行数 |
| iis_errors_not_found |  | 文档未找到导致错误的速数 |
| iis_net_files_rcvd |  | 每秒接收的文件数 |
| iis_httpd_request_method_put |  | put 方法请求数 |
| iis_httpd_request_method_trace |  | trace 方法请求数 |
| iis_net_connection_attempts |  | 每秒尝试连接数 |
| iis_users_nonanon |  | 每秒非匿名用户的请求数 |
| iis_net_bytes_total |  | 每秒传输的字节总数 |
| iis_net_bytes_rcvd |  | 每秒接收的字节数 |
| iis_net_bytes_sent |  | 每秒发送的字节数 |
| iis_net_num_connections |  | 活跃连接数 |
| iis_errors_locked |  | 文档锁定导致的错误数 |
| iis_users_anon |  | 每秒匿名用户的请求数 |
| iis_net_files_sent |  | 每秒发送的文件数 |
| iis_httpd_request_method_post |  | post 方法请求数 |
| iis_httpd_request_method_get |  | get 方法请求数 |
| iis_uptime |  | iis 服务器运行时间 |

## Active_Directory 插件

### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| active_directory_dra_outbound_values_dns_persec |  | 发到复制伙伴 DN 属性值数量/s |
| active_directory_dra_outbound_bytes_total |  | 发送到复制伙伴的总字节数 |
| active_directory_ldap_searches_persec |  | LDAP 客户端执行搜索操作速率 |
| active_directory_dra_inbound_values_dns_persec |  | 从复制伙伴接收 DN 属性值数/s |
| active_directory_dra_inbound_bytes_total |  | 从复制伙伴接收的总字节数 |
| active_directory_dra_outbound_values_total_persec |  | 发送到复制伙伴对象属性值数/s |
| active_directory_dra_inbound_objects_remaining |  | 未完成同步的对象数量 |
| active_directory_dra_inbound_properties_filtered_p |  | 不需要进行更新的对象数量 |
| active_directory_dra_outbound_objects_persec |  | 发送到复制伙伴的对象数量/s |
| active_directory_ds_threads_in_use |  | 目录服务当前使用的线程数 |
| active_directory_dra_inbound_properties_total_pers |  | 从复制伙伴接收的对象属性总数 |
| active_directory_dra_inbound_objects_applied_perse |  | 从复制伙伴接收更新的应用速率 |
| active_directory_dra_outbound_properties_persec |  | 发送到复制伙伴的属性值数量/s |
| active_directory_dra_inbound_objects_remaining_in |  | 未应用于本地服务器的对象更新数 |
| active_directory_dra_inbound_bytes_after_compressi | Byte | 从其他站点(每秒)的目录系统代理(DSA)入站的压缩复制数据的压缩大小(以字节为单位) |
| active_directory_dra_inbound_properties_applied_pe |  | 入站复制应用对象属性更改数/s |
| active_directory_dra_inbound_values_total_persec |  | 从复制伙伴接收对象属性值数/s |
| active_directory_ldap_successful_binds_persec |  | 成功发生的 LDAP 绑定数/s |
| active_directory_dra_outbound_bytes_after_compress | Byte | 压缩复制数据的压缩大小(以字节为单位)，其出站到其他站点中的 DSA(每秒) |
| active_directory_dra_replication_pending_synchroni |  | 等待此服务器未处理目录同步数 |
| active_directory_dra_outbound_objects_filtered_per |  | 出站复制伙伴确认的对象数/s |
| active_directory_dra_outbound_bytes_before_compres | Byte | 出站到其他站点的 DSA 数据/s |
| active_directory_dra_inbound_objects_persec |  | 复制伙伴入站复制接收对象数/s |
| active_directory_dra_inbound_bytes_not_compressed | KB | 同一站点其他 DSA 入站数据/s |
| active_directory_dra_sync_requests_made |  | 启动后向复制伙伴发出同步请求数 |
| active_directory_ldap_bind_time | ms | 上次成功 LDAP 绑定所需时间 |
| active_directory_dra_inbound_objects_filtered_pers |  | 从复制伙伴接收的对象数/s |
| active_directory_dra_outbound_bytes_not_compressed | Byte | 向同一站点中 DSA 出站数据大小 |
| active_directory_ldap_client_sessions |  | 已连接 LDAP 客户端的会话数 |
| active_directory_dra_inbound_bytes_before_compress | Byte | 其他站点 DSA 入站数据大小/s |

## Exchange 插件

### 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| exchange_database_io_reads_avg_latency | ms | 数据库读取操作的平均时间 |
| exchange_database_io_db_reads_attached_persec |  | 附加数据库每秒数据库读取操作数 |
| exchange_netlogon_semaphore_waiters |  | 正在等待获取信号的线程数量 |
| exchange_adaccess_processes_ldap_search | ms | 发送 LDAP 搜索请求响应的时间 |
| exchange_netlogon_semaphore_hold_time | s | 在上个示例中信号停留的平均时间 |
| exchange_network_outbound_errors |  | 因错误而无法传输的出站数据包数 |
| exchange_adaccess_domain_controllers_ldap_search | ms | 将 LDAP 读请求发送至域控制器接收响应的时间 |
| exchange_database_io_db_writes_attached_persec |  | 显示每个附加数据库实例的每秒数据库写入操作数量 |
| exchange_netlogon_semaphore_acquires |  | 在安全通道连接的整个生命周期或自系统为 _Total 启动以来，获取信号的总次数 |
| exchange_ws_current_connections_default_website |  | 显示对默认网站建立的当前连接数，此数目对应于命中前端 CAS 服务器角色的连接数 |
| exchange_netlogon_semaphore_timeouts |  | 线程在安全通道连接的整个生命周期或自系统为 _Total 启动以来等待信号期间，线程超时的总次数 |
| exchange_adaccess_processes_ldap_read |  | 显示将 LDAP 读请求接收响应的时间 |
| exchange_database_io_log_writes_avg_latency |  | 显示每个数据库实例每秒写入的日志数量。 |
| exchange_database_io_db_writes_recovery_avg_latenc | ms | 显示每个被动数据库写入操作的平均时间长度(毫秒) |
| exchange_adaccess_domain_controllers_ldap_read | ms | 显示将 LDAP 读请求发送至指定域控制器并接收响应的时间 |
| exchange_database_io_log_writes_persec |  | 显示每个数据库实例每秒写入的日志数量 |
| exchange_netlogon_semaphore_holders |  | 存放信号的线程数量 |
| exchange_database_io_db_reads_recovery_avg_latency | ms | 显示每个被动数据库读取操作的平均时间长度 |
| exchange_database_io_writes_avg_latency | ms | 显示每个数据库写入操作的平均时间长度(毫秒) |
| exchange_is_store_rpc_latency | ms | RPC Latency average (msec) 是每个数据库的 RPC 请求的平均延迟(毫秒) |
| exchange_is_clienttype_rpc_latency | ms | 显示针对某个特定客户端协议，过去 1024 个数据包的平均服务器 RPC 延迟(毫秒) |
| exchange_is_clienttype_rpc_ops_persec | ms | 显示每个客户端类型连接每秒的 RPC 操作数 |
| exchange_is_store_rpc_requests | ms | 指示当前在信息存储进程中执行的全部 RPC 请求 |
| exchange_is_store_rpc_ops_persec | ms | 显示每个数据库实例每秒的 RPC 操作数 |
| exchange_activemanager_database_mounted |  | 服务器上活动数据库副本的数量。 |
| exchange_ws_requests_persec |  | 显示服务器上活动数据库副本的数量 |
| exchange_network_tcpv6_connection_failures |  | 显示当前状态为 ESTABLISHED 或 CLOSE-WAIT 的 TCP 连接的数目 |
| exchange_memory_available | MB | 显示可立即分配给进程或供系统使用的物理内存量 (MB) |
| exchange_ws_current_connections_total |  | 当前与 Web 服务建立连接的数量 |
| exchange_rpc_ops_persec |  | 显示 RPC 操作发生的速率(每秒) |
| exchange_autodiscover_requests_persec |  | 每秒处理自动发现服务请求数 |
| exchange_memory_committed | % | 显示 Memory\Committed Bytes 与 Memory\Commit Limit 的比率 |
| exchange_rpc_conn_count |  | 显示所维护的客户端连接总数。 |
| exchange_rpc_requests |  | 显示 RPC 客户端访问服务当前正处理的客户端请求数 |
| exchange_rpc_averaged_latency |  | 显示过去 1024 个数据包的平均延迟(毫秒) |
| exchange_processor_queue_length |  | 表示每个处理器所服务的线程数 |
| exchange_network_tcpv4_conns_reset |  | 显示 TCP 连接直接从 ESTABLISHED 状态或 CLOSE-WAIT 状态转换为 CLOSED 状态的次数 |
| exchange_activesync_sync_persec |  | 显示每秒处理的同步命令数 |
| exchange_activesync_ping_pending |  | 显示队列中当前挂起的 ping 命令数 |
| exchange_ws_other_attempts |  | 显示没有使用 OPTIONS、GET、HEAD、POST、PUT、DELETE、TRACE、MOVE、COPY、MKCOL、PROPFIND、PROPPATCH、SEARCH、LOCK 或 UNLOCK 方法发出 HTTP 请求的速率 |
| exchange_ws_connection_attempts |  | 显示尝试连接到 Web 服务的速率 |
| exchange_processor_cpu_time |  | 显示处理器执行应用程序或操作系统进程的时间的百分比 |
| exchange_activesync_requests_persec |  | 显示每秒通过 ASP.NET 从客户端接收到的 HTTP 请求数 |
| exchange_rpc_active_user_count |  | 显示最近 2 分钟之内进行过某些活动的唯一用户数 |
| exchange_processor_cpu_privileged |  | 显示花在特权模式上的处理器时间的百分比 |
| exchange_owa_unique_users |  | 显示当前登录到 Outlook Web App 的唯一用户数 |
| exchange_owa_requests_persec |  | 显示每秒由 Outlook Web App 处理的请求数 |
| exchange_network_tcpv6_conns_reset |  | TCP 连接直接从 ESTABLISHED 状态或 CLOSE-WAIT 状态转换为 CLOSED 状态的次数 |
| exchange_processor_cpu_user | % | 在用户模式上处理器时间的百分比 |
| exchange_rpc_user_count |  | 显示连接到服务的用户数 |
| exchange_ab_nspi_rpc_browse_requests_avg_latency | ms | 采样完成浏览请求平均时间 |
| exchange_ab_nspi_rpc_requests_avg_latency | ms | 采样完成 NSPI 请求平均时间 |
| exchange_ab_referral_rpc_requests_avg_latency | ms | 采样完成引用请求平均时间 |
| exchange_ab_nspi_connections_current |  | 当前连接服务器 NSPI 客户端数 |
| exchange_ab_nspi_connections_per |  | 每秒连接服务器 NSPI 客户端数 |
| exchange_ab_nspi_rpc_requests_per |  | NSPI 请求发生的速率/s |
| exchange_ab_referral_rpc_requests_per |  | 引用请求发生的速率/s |
| exchange_is_store_rpc_client_backoff_per |  | 指示发生客户端回退的速率 |
| exchange_availability_service_avg_time_to_Process | s | 处理忙/闲请求的平均时间 |
| exchange_panel_asp_net_request_failures_per |  | 控制面板中的 ASP.NET 每秒所检测到的失败数 |
| exchange_panel_sign_on_inbound_proxy_requests_per |  | 显示从主客户端访问服务器每秒接收到的显式登录请求数 |
| exchange_panel_sign_on_inbound_proxy_sessions_per |  | 显示在 Exchange 控制面板中每秒加载的显式登录入站代理会话数 |
| exchange_panel_sign_on_outbound_proxy_requests_per |  | 显示向辅助客户端访问服务器每秒发送的显式登录请求数。 |
| exchange_panel_inbound_proxy_requests_per |  | 显示从主客户端访问服务器每秒接收到的请求数。 |
| exchange_panel_inbound_proxy_sessions_per |  | 显示在 Exchange 控制面板中每秒加载的入站代理会话数 |
| exchange_panel_outbound_proxy_requests_avg_time |  | 显示采样期间完成发送给辅助客户端访问服务器的请求所花费的平均时间(毫秒)。 |
| exchange_panel_outbound_proxy_requests_per |  | 显示向辅助客户端访问服务器每秒发送的请求数。 |
| exchange_panel_outbound_proxy_sessions_per |  | 显示在 Exchange 控制面板中每秒加载的出站代理会话数 |
| exchange_panel_powershell_runspace_activations_per |  | 显示在 Windows 控制面板中每秒激活的 Exchange PowerShell 运行空间数 |
| exchange_panel_powershell_runspace_avg_active_time |  | 显示采样期间在 Exchange 控制面板中执行 cmdlet 时，Windows PowerShell 运行空间处于活动状态的平均时间(秒) |
| exchange_panel_powershell_runspaces_per |  | 显示在 Exchange 控制面板中每秒创建的 Windows PowerShell 运行空间数 |
| exchange_panel_rbac_sessions_per |  | 显示在 Exchange 控制面板中每秒加载的 RBAC 会话数 |
| exchange_panel_requests_activations_per |  | 显示在 Exchange 控制面板中每秒激活的请求数。 |
| exchange_panel_requests_avg_response_time |  | 期间 Exchange 控制面板响应请求所花费的平均时间(毫秒)。

### Exchange 2013 指标说明

| 指标 | 单位 | 具体含义 |
| --- | --- | --- |
| exchange_database_io_reads_avg_latency | ms | 数据库读取操作的平均时间 |
| exchange_database_io_db_reads_attached_persec |  | 附加数据库每秒数据库读取操作数 |
| exchange_netlogon_semaphore_waiters |  | 正在等待获取信号的线程数量 |
| exchange_adaccess_processes_ldap_search | ms | 发送 LDAP 搜索请求响应的时间 |
| exchange_netlogon_semaphore_hold_time | s | 在上个示例中信号停留的平均时间 |
| exchange_network_outbound_errors |  | 因错误而无法传输的出站数据包数 |
| exchange_adaccess_domain_controllers_ldap_search | ms | 将 LDAP 读请求发送至域控制器接收响应的时间 |
| exchange_database_io_db_writes_attached_persec |  | 显示每个附加数据库实例的每秒数据库写入操作数量 |
| exchange_netlogon_semaphore_acquires |  | 在安全通道连接的整个生命周期或自系统为 _Total 启动以来，获取信号的总次数 |
| exchange_ws_current_connections_default_website |  | 显示对默认网站建立的当前连接数，此数目对应于命中前端 CAS 服务器角色的连接数 |
| exchange_netlogon_semaphore_timeouts |  | 线程在安全通道连接的整个生命周期或自系统为 _Total 启动以来等待信号期间，线程超时的总次数 |
| exchange_adaccess_processes_ldap_read |  | 显示将 LDAP 读请求接收响应的时间 |
| exchange_database_io_log_writes_avg_latency |  | 显示每个数据库实例每秒写入的日志数量。 |
| exchange_database_io_db_writes_recovery_avg_latenc | ms | 显示每个被动数据库写入操作的平均时间长度(毫秒) |
| exchange_adaccess_domain_controllers_ldap_read | ms | 显示将 LDAP 读请求发送至指定域控制器并接收响应的时间 |
| exchange_database_io_log_writes_persec |  | 显示每个数据库实例每秒写入的日志数量 |
| exchange_netlogon_semaphore_holders |  | 存放信号的线程数量 |
| exchange_database_io_db_reads_recovery_avg_latency | ms | 显示每个被动数据库读取操作的平均时间长度 |
| exchange_database_io_writes_avg_latency | ms | 显示每个数据库写入操作的平均时间长度(毫秒) |
| exchange_httpproxy_server_locator_latency | ms | 显示 MailboxServerLocator Web 服务调用的平均延迟(毫秒) |
| exchange_httpproxy_clientaccess_processing_latency | ms | 显示最近 200 个请求中 CAS 处理时间(不包括代理所花费时间)的平均延迟(毫秒) |
| exchange_httpproxy_proxy_requests_persec | ms | 显示每秒处理的代理请求数 |
| exchange_httpproxy_requests_persec | ms | 显示每秒处理的请求数 |
| exchange_httpproxy_mailbox_proxy_failure_rate | ms | 显示最近 200 个示例中涉及此客户端访问服务器和 MBX 服务器之间失败的连接百分比 |
| exchange_httpproxy_avg_auth_latency | ms | 显示最近 200 个示例中对 CAS 请求进行身份验证所花费的平均时间 |
| exchange_httpproxy_outstanding_requests | ms | 显示并发未处理代理请求的数量 |
| exchange_is_store_rpc_latency | ms | RPC Latency average (msec) 是每个数据库的 RPC 请求的平均延迟(毫秒) |
| exchange_is_clienttype_rpc_latency | ms | 显示针对某个特定客户端协议，过去 1024 个数据包的平均服务器 RPC 延迟(毫秒) |
| exchange_is_clienttype_rpc_ops_persec | ms | 显示每个客户端类型连接每秒的 RPC 操作数 |
| exchange_is_store_rpc_requests | ms | 指示当前在信息存储进程中执行的全部 RPC 请求 |
| exchange_is_store_rpc_ops_persec | ms | 显示每个数据库实例每秒的 RPC 操作数 |
| exchange_workload_management_completed_tasks | ms | 显示当前正在排队等待处理的工作负载管理任务数 |
| exchange_workload_management_queued_tasks | ms | 显示已经完成的工作负载管理任务数 |
| exchange_workload_management_active_tasks | ms | 显示当前工作负载管理在后台运行的活动任务数 |
| exchange_activemanager_database_mounted |  | 服务器上活动数据库副本的数量。 |
| exchange_ws_requests_persec |  | 显示服务器上活动数据库副本的数量 |
| exchange_network_tcpv6_connection_failures |  | 显示当前状态为 ESTABLISHED 或 CLOSE-WAIT 的 TCP 连接的数目 |
| exchange_memory_available | MB | 显示可立即分配给进程或供系统使用的物理内存量 (MB) |
| exchange_ws_current_connections_total |  | 当前与 Web 服务建立连接的数量 |
| exchange_rpc_ops_persec |  | 显示 RPC 操作发生的速率(每秒) |
| exchange_autodiscover_requests_persec |  | 每秒处理自动发现服务请求数 |
| exchange_memory_committed | % | 显示 Memory\Committed Bytes 与 Memory\Commit Limit 的比率 |
| exchange_rpc_conn_count |  | 显示所维护的客户端连接总数。 |
| exchange_rpc_requests |  | 显示 RPC 客户端访问服务当前正处理的客户端请求数 |
| exchange_rpc_averaged_latency |  | 显示过去 1024 个数据包的平均延迟(毫秒) |
| exchange_processor_queue_length |  | 表示每个处理器所服务的线程数 |
| exchange_network_tcpv4_conns_reset |  | 显示 TCP 连接直接从 ESTABLISHED 状态或 CLOSE-WAIT 状态转换为 CLOSED 状态的次数 |
| exchange_activesync_sync_persec |  | 显示每秒处理的同步命令数 |
| exchange_activesync_ping_pending |  | 显示队列中当前挂起的 ping 命令数 |
| exchange_ws_other_attempts |  | 显示没有使用 OPTIONS、GET、HEAD、POST、PUT、DELETE、TRACE、MOVE、COPY、MKCOL、PROPFIND、PROPPATCH、SEARCH、LOCK 或 UNLOCK 方法发出 HTTP 请求的速率 |
| exchange_ws_connection_attempts |  | 显示尝试连接到 Web 服务的速率 |
| exchange_processor_cpu_time |  | 显示处理器执行应用程序或操作系统进程的时间的百分比 |
| exchange_activesync_requests_persec |  | 显示每秒通过 ASP.NET 从客户端接收到的 HTTP 请求数 |
| exchange_rpc_active_user_count |  | 显示最近 2 分钟之内进行过某些活动的唯一用户数 |
| exchange_processor_cpu_privileged |  | 显示花在特权模式上的处理器时间的百分比 |
| exchange_owa_unique_users |  | 显示当前登录到 Outlook Web App 的唯一用户数 |
| exchange_owa_requests_persec |  | 显示每秒由 Outlook Web App 处理的请求数 |
| exchange_network_tcpv6_conns_reset |  | TCP 连接直接从 ESTABLISHED 状态或 CLOSE-WAIT 状态转换为 CLOSED 状态的次数 |
| exchange_processor_cpu_user | % | 在用户模式上处理器时间的百分比 |
| exchange_rpc_user_count |  | 显示连接到服务的用户数 |


