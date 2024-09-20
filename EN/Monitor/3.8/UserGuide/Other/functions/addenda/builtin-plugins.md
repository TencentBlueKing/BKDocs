# Built-in official plug-in

The built-in official plug-in is a plug-in officially maintained by BlueKing, which mainly meets the out-of-box requirements of the monitoring platform. Although it is a built-in official plug-in, it will have certain dependencies and functional limitations.

If the usage description is unclear or wrong, or if you have any needs, please give feedback to the official.

> **Note**: In fact, the plug-in definition based on the monitoring platform can very conveniently expand monitoring capabilities, and you do not need to rely entirely on official plug-ins. Check specifically
> * [How to use open source Exporter](../../guide/import_exporter.md)
> * [How to use open source DataDog](../../guide/import_datadog.md)

## Exporter plugin

### Apache plugin

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| apache.net.bytes | bytes | Total number of bytes transferred |
| apache.net.bytes_per_s | bytes/second | Bytes transferred per second |
| apache.net.hits | requests | Total number of requests |
| apache.net.request_per_s | requests/second | requests per second |
| apache.performance.busy_workers | threads | Number of active threads |
| apache.performance.cpu_load | percent | CPU load |
| apache.performance.idle_workers | threads | Number of idle threads |
| apache.performance.uptime | seconds | Apache runtime |

### Nginx plugin

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| nginx.connections.accepted | connections | Total number of accepted client connections |
| nginx.connections.active | connections | Current number of client connections |
| nginx.connections.dropped | connections | Total number of dropped client connections |
| nginx.connections.idle | connections | Current number of idle client connections |
| nginx.generation | | Total number of configuration reloads |
| nginx.load_timestamp | milliseconds | The time the configuration was last reloaded (time since Epoch) |
| nginx.net.conn_dropped_per_s | connections/second | Connection loss rate |
| nginx.net.conn_opened_per_s | connections/second | The rate at which connections are opened |
| nginx.net.connections | connections | Total number of active connections |
| nginx.net.reading | connections | Read the number of connections requested by the client |
| nginx.net.request_per_s | requests/second | Request processing rate |
| nginx.net.waiting | connections | Number of keep-alive connections waiting for work |
| nginx.net.writing | connections | The number of connections to wait for upstream responses and/or write responses back to the client |
| nginx.pid | | ID of the worker process that handles status requests |
| nginx.processes.respawned | processes | The total number of child processes that were abnormally terminated and respawned |
| nginx.requests.current | requests | Current number of client requests |
| nginx.requests.total | requests | Total number of client requests |
| nginx.server_zone.discarded | requests | Total number of requests completed without sending a response |
| nginx.server_zone.processing | requests | Number of client requests currently being processed |
| nginx.server_zone.received | bytes | Total amount of data received from the client |
| nginx.server_zone.requests | requests | The total number of client requests received from the client |
| nginx.server_zone.responses.1xx | responses | Number of responses with 1xx status code |
| nginx.server_zone.responses.2xx | responses | Number of responses with 2xx status code |
| nginx.server_zone.responses.3xx | responses | Number of responses with 3xx status code |
| nginx.server_zone.responses.4xx | responses | Number of responses with 4xx status code |
| nginx.server_zone.responses.5xx | responses | Number of responses with 5xx status code |
| nginx.server_zone.responses.total | responses | Total number of responses sent to the client |
| nginx.server_zone.sent | bytes | Total amount of data sent to the client |
| nginx.ssl.handshakes | | Total number of successful SSL handshakes |
| nginx.ssl.handshakes_failed | | Total number of failed SSL handshakes |
| nginx.ssl.session_reuses | | Total number of session reuses during SSL handshake |
| nginx.timestamp | milliseconds | Time since Epoch |
| nginx.upstream.keepalive | connections | Number of currently idle keepalive connections |
| nginx.upstream.peers.active | connections | Current number of active connections |
| nginx.upstream.peers.backup | | Boolean value indicating whether the server is a backup server |
| nginx.upstream.peers.downstart | milliseconds | The time the server became "unavail" or "unhealthy" (since Epoch) |
| nginx.upstream.peers.downtime | milliseconds | The total time the server has been in the "unavail" or "unhealthy" state |
| nginx.upstream.peers.fails | | Total number of failed communications with the server |
| nginx.upstream.peers.health_checks.checks | | Total number of health check requests |
| nginx.upstream.peers.health_checks.fails | | Number of health check failures |
| nginx.upstream.peers.health_checks.last_passed | | Boolean value indicating whether the last health check request was successful and passed the test |
| nginx.upstream.peers.health_checks.unhealthy | | The number of times the server became unhealthy (state "unhealthy") |
| nginx.upstream.peers.id | | ID of the server |
| nginx.upstream.peers.received | bytes | Total amount of data received from this server |
| nginx.upstream.peers.requests | requests | The total number of client requests forwarded to this server |
| nginx.upstream.peers.responses.1xx | responses | Number of responses with 1xx status code |
| nginx.upstream.peers.responses.2xx | responses | Number of responses with 2xx status code |
| nginx.upstream.peers.responses.3xx | responses | Number of responses with 3xx status code |
| nginx.upstream.peers.responses.4xx | responses | Number of responses with 4xx status code |
| nginx.upstream.peers.responses.5xx | responses | Number of responses with 5xx status code |
| nginx.upstream.peers.responses.total | responses | The total number of responses obtained from this server |
| nginx.upstream.peers.selected | milliseconds | The last time a server was selected to handle a request (1.7.5) (since Epoch) |
| nginx.upstream.peers.sent | bytes | Total amount of data sent to this server |
| nginx.upstream.peers.unavail | | The number of times the server was unavailable (state "unavail") for a client request because the number of failed attempts reached the max_fails threshold |
| nginx.upstream.peers.weight | | Weight of the server |
| nginx.version | | nginx version |

### MySQL plug-in

#### Indicator description
| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| mysql.galera.wsrep_cluster_size | nodes | The number of nodes in the Galera cluster. |
| mysql.innodb.buffer_pool_free | pages | Number of free pages in the InnoDB buffer pool |
| mysql.innodb.buffer_pool_total | pages | The total number of pages in the InnoDB buffer pool |
| mysql.innodb.buffer_pool_used | pages | The number of pages used in the InnoDB buffer pool |
| mysql.innodb.buffer_pool_utilization | fractions | InnoDB buffer pool utilization |
| mysql.innodb.current_row_locks | locks | The number of current row locks. |
| mysql.innodb.data_reads | reads/second | Data reading rate (number of reads/s) |
| mysql.innodb.data_writes | writes/second | Data write rate (number of writes/s) |
| mysql.innodb.mutex_os_waits | events/second | The rate of mutex OS waits. |
| mysql.innodb.mutex_spin_rounds | events/second | The rate of mutex spin rounds. |
| mysql.innodb.mutex_spin_waits | events/second | The rate of mutex spin waits. |
| mysql.innodb.os_log_fsyncs | writes/second | fsync rate of writing log files (number of writes/s) |
| mysql.innodb.row_lock_time | fractions | Time spent acquuring row locks (millisecond/s) |
| mysql.innodb.row_lock_waits | events/second | The number of times the row lock needs to wait per second (event/s) |
| mysql.net.connections | connections/second | The speed of connecting to the server (number of connections/s) |
| mysql.net.max_connections | connections | The maximum number of connections used at the same time when the server starts |
| mysql.performance.com_delete | queries/second | Rate of deletion of statements (number of times/s) |
| mysql.performance.com_delete_multi | queries/second | Rate of deleting multi-statements (number of times/s) |
| mysql.performance.com_insert | queries/second | The rate of insert statements (number of times/s) |
| mysql.performance.com_insert_select | queries/second | The rate of inserting SELECT statements (number of times/s) |
| mysql.performance.com_replace_select | queries/second | Speed of replacing SELECT statements (number of times/s) |
| mysql.performance.com_select | queries/second | SELECT statement speed (number of times/s) |
| mysql.performance.com_update | queries/second | Speed of update statements (number of times/s) |
| mysql.performance.com_update_multi | queries/second | Speed of updating multi-statements (number of times/s) |
| mysql.performance.created_tmp_disk_tables | tables/second | The number of temporary tables on the server's internal disk created per second while executing the statement (number of tables/s) |
| mysql.performance.created_tmp_files | files/second | Number of temporary files created per second (files/s) |
| mysql.performance.created_tmp_tables | tables/second | The number of server-internal temporary tables created when executing statements per second (number of tables/s) |
| mysql.performance.kernel_time | percent | The percentage of CPU time MySQL spends in kernel space |
| mysql.performance.key_cache_utilization | fractions | key cache utilization (percentage) |
| mysql.performance.open_files | files | Number of open files |
| mysql.performance.open_tables | tables | Number of open tables |
| mysql.performance.qcache_hits | hits/second | Query cache hit rate |
| mysql.performance.queries | queries/second | Query rate (number of times/s) |
| mysql.performance.questions | queries/second | The rate of statements executed by the server (number of times/s) |
| mysql.performance.slow_queries | queries/second | The rate of slow queries (number of times/s) |
| mysql.performance.table_locks_waited | | The total number of times to wait because table lock requests could not be processed |
| mysql.performance.threads_connected | connections | The number of currently open connections |
| mysql.performance.threads_running | threads | Number of running threads |
| mysql.performance.user_time | percent | The percentage of CPU time MySQL spends in user space |
| mysql.replication.seconds_behind_master | seconds | The lag time between the master server (master) and the slave server (slave) |
| mysql.replication.slave_running | | A Boolean value to determine whether the server is a slave connected to the master server (master) |

### Redis plugin

#### Indicator description
| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| redis.aof.buffer_length | bytes | AOF buffer size |
| redis.aof.last_rewrite_time | seconds | The duration of the last AOF rewrite (rewrite) |
| redis.aof.rewrite | | The number of AOF rewrites (rewrite) |
| redis.aof.size | bytes | AOF current file size (aof_current_size) |
| redis.clients.biggest_input_buf | | The largest input buffer for the current client connection |
| redis.clients.blocked | connections | Number of connections waiting for blocked calls |
| redis.clients.longest_output_list | | The longest output list of the current client connection |
| redis.cpu.sys | seconds | System CPU consumed by the Redis server |
| redis.cpu.sys_children | seconds | System CPU consumed by the background process |
| redis.cpu.user | seconds | User CPU consumed by the Redis server |
| redis.cpu.user_children | seconds | User CPU consumed by the background process |
| redis.expires | keys | Number of expired keys |
| redis.expires.percent | percent | Percentage of expired keys |
| redis.info.latency_ms | milliseconds | Redis info command latency |
| redis.key.length | | The number of elements in the given key |
| redis.keys | keys | Total number of Keys |
| redis.keys.evicted | keys | The total number of keys that were evicted due to the maximum memory limit |
| redis.keys.expired | keys | The total number of expired keys in the database |
| redis.mem.fragmentation_ratio | fractions | The ratio of used_memory_rss to used_memory |
| redis.mem.lua | bytes | Amount of memory used by the Lua engine |
| redis.mem.peak | bytes | Peak memory usage by Redis |
| redis.mem.rss | bytes | The memory allocated by the system to Redis |
| redis.mem.used | bytes | The amount of memory that has been allocated by Redis |
| redis.net.clients | connections | Number of connected clients (excluding slaves) |
| redis.net.commands | commands | Number of commands run by the server |
| redis.net.rejected | connections | Number of rejected connections |
| redis.net.slaves | connections | Number of connected slaves |
| redis.perf.latest_fork_usec | microseconds | The duration of the latest fork |
| redis.persist | keys | Number of persistent keys (redis.keys - redis.expires) |
| redis.persist.percent | percent | Percentage of persisted keys |
| redis.pubsub.channels | | Number of active publish/subscribe channels |
| redis.pubsub.patterns | | Number of active publish/subscribe patterns |
| redis.rdb.bgsave | | A flag value that records whether the server is creating an RDB file. It is 1 if it is in progress, otherwise it is 0 |
| redis.rdb.changes_since_last | | RDB changes since the last background save |
| redis.rdb.last_bgsave_time | seconds | The duration of the last bg_save operation |
| redis.replication.backlog_histlen | bytes | The amount of data accumulated in the synchronization buffer |
| redis.replication.delay | offsets | Replication delay offsets |
| redis.replication.last_io_seconds_ago | seconds | How many seconds have passed since the last communication with the primary server |
| redis.replication.master_link_down_since_seconds | seconds | How many seconds has the master-slave server connection been disconnected |
| redis.replication.master_repl_offset | offsets | Replication offsets reported from master |
| redis.replication.slave_repl_offset | offsets | Replication offsets reported from slave |
| redis.replication.sync | | A flag value that is 1 if synchronization is in progress, 0 otherwise |
| redis.replication.sync_left_bytes | bytes | How much data is left before synchronization is completed |
| redis.slowlog.micros.95percentile | microseconds | In the slow log, the 95th percentile value of the duration reported by the query |
| redis.slowlog.micros.avg | microseconds | In the slow log, query the reported duration average |
| redis.slowlog.micros.count | queries/second | In the slow log, the reported query rate |
| redis.slowlog.micros.max | microseconds | In the slow log, the maximum duration reported by the query |
| redis.slowlog.micros.median | microseconds | In the slow log, the median duration reported by the query |
| redis.stats.keyspace_hits | keys | The number of successful searches for key in the database |
| redis.stats.keyspace_misses | keys | The number of failed attempts to find key in the database |

### Oracle plug-in

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| oracle.RWParse.oracledb_Executions | | SQL execution rate |
| oracle.RWParse.oracledb_HardParse | | SQL hard parse rate |
| oracle.RWParse.oracledb_LogicalReads | | Logical block read rate |
| oracle.RWParse.oracledb_PhysicalReads | | Physical block read rate |
| oracle.RWParse.oracledb_PhysicalWrites | | Physical block write rate |
| oracle.RWParse.oracledb_TotalParse | | SQL parsing rate |
| oracle.RWParse.oracledb_Transaction | | Transactions per second |
| oracle.RWParse.oracledb_insstatus | | Instance status (1 represents ONLINE, 0 represents OFFLINE) |
| oracle.RWParse.oracledb_runhealthtime | s | Database health runtime |
| oracle.MemoryInfo.oracledb_PGAFreeSize | MB | PGA free size |
| oracle.MemoryInfo.oracledb_PGATotalSize | MB | PGA allocation size |
| oracle.MemoryInfo.oracledb_PGAUsedRate | % | PGA usage rate |
| oracle.MemoryInfo.oracledb_PGAlUsedSize | MB | PGA usage size |
| oracle.MemoryInfo.oracledb_SGAFreeSize | MB | SGA free size |
| oracle.MemoryInfo.oracledb_SGATotalSize | MB | SGA allocation size |
| oracle.MemoryInfo.oracledb_SGAUsedRate | % | SGA usage rate |
| oracle.MemoryInfo.oracledb_SGAUsedSize | MB | SGA usage size |
| oracle.MemoryInfo.oracledb_SharePoolFreeSize | MB | SharePool free size |
| oracle.MemoryInfo.oracledb_SharePoolTotalSize | MB | SharePool allocation size |
| oracle.MemoryInfo.oracledb_SharePoolUsedRate | % | SharePool usage rate |
| oracle.MemoryInfo.oracledb_SharePoolUsedSize | MB | SharePool usage size |
| oracle.Table_space.oracledb_TablespaceFree | MB | Table space free size |
| oracle.Table_space.oracledb_TablespaceRate | % | Table space usage rate |
| oracle.Table_space.oracledb_TablespaceStatus | | Table space status (1 represents ONLINE, 0 represents OFFLINE) |
| oracle.Table_space.oracledb_TablespaceTotal | MB | Table space allocation size |
| oracle.Table_space.oracledb_TablespaceUsed | MB | Table space usage size |
| oracle.sys_param.oracledb_ActiveSession | | Number of active user sessions |
| oracle.sys_param.oracledb_InactiveSession | | Number of inactive user sessions |
| oracle.sys_param.oracledb_SessionMax | | Number of session allocations |
| oracle.sys_param.oracledb_SessionTotal | | Number of user sessions |
| oracle.sys_param.oracledb_BlockNum | | Current block number |
| oracle.sys_param.oracledb_BufferCacheHit | % | Buffer hit rate |
| oracle.sys_param.oracledb_BufferCacheSize | MB | Buffer size |
| oracle.sys_param.oracledb_DeadLockNum | | Number of deadlocks |
| oracle.sys_param.oracledb_ProcessMax | | Number of process allocations |
| oracle.sys_param.oracledb_ProcessTotal | | Total number of processes |
| oracle.sys_param.oracledb_RedoNum | | Redo log file group number |
| oracle.sys_param.oracledb_RedoSize | MB | Total Redo log file size |
| oracle.sys_param.oracledb_SortMemory | % | Memory sorting rate |
| oracle.sys_param.oracledb_sharepoolhit | % | Shared pool hit rate |
| oracle.ASMInfo.oracledb_ASMDisk_total | MB | ASM total disk size |
| oracle.ASMInfo.oracledb_ASMDisk_free | MB | ASM free disk size |
| oracle.ASMInfo.oracledb_ASMDisk_state | | ASM disk status (1 represents MOUNT, 0 represents other abnormal states) |
| oracle.scanIpInfo.oracledb_ScanIPStatus | | scanIP listening status (1 means the port is connected, 0 means the port is unreachable) |
| oracle.InsIpInfo.oracledb_InsIpStatus | | Instance IP listening status (1 means the port is connected, 0 means the port is unreachable) |
| oracle.VIPInfo.oracledb_VIPStatus | | VIP listening status (1 means the port is connected, 0 means the port is unreachable) |

### SQL Server Plug-in

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| mssql.instance_Lock.mssqldb_LockWaits_sec | | Number of lock waits per second |
| mssql.db_status.mssqldb_database_status | | Database status 0 represents offline 1 represents online|
| mssql.db_status.mssqldb_used_data_size | MB | Database data size |
| mssql.db_status.mssqldb_max_data_size | MB | Maximum database data size |
| mssql.db_status.mssqldb_log_size | MB | Log size |
| mssql.db_status.mssqldb_LogGrowths | MB | Log growth |
| mssql.db_status.mssqldb_io_stall_total_ms | s | Total user wait time for IO |
| mssql.db_status.mssqldb_io_stall_read_ms | s | Total user wait time for reads |
| mssql.db_status.mssqldb_io_stall_write_ms | s | Total time the user waited for writes |
| mssql.db_status.mssqldb_connections | | Number of database connections |
| mssql.db_status.mssqldb_log_space_used | % | Log space usage |
| mssql.db_perform.mssqldb_up | | Instance status 0 represents offline 1 represents online|
| mssql.db_perform.mssqldb_PageSplits_sec | | The number of page splits generated per second/cycle, the cycle refers to the set data collection cycle |
| mssql.db_perform.mssqldb_ProcessesBlocked | | Current number of blocked processes |
| mssql.db_perform.mssqldb_SqlCompilations_sec | | SQL compilation times/cycle per second, the cycle refers to the set data collection cycle |
| mssql.db_perform.mssqldb_SqlReCompilations_sec | | SQL recompilation times/cycle per second, the cycle refers to the set data collection cycle |
| mssql.db_perform.mssqldb_UserConnections | | Number of user connections |
| mssql.db_perform.mssqldb_deadlocks_sec | | Number of lock requests per second that resulted in deadlocks |
| mssql.db_perform.mssqldb_kill_conn_errors_sec | | Number of connection errors |
| mssql.db_perform.mssqldb_local_time | s | Instance running time |
| mssql.db_perform.mssqldb_memory_utilization_percentage | % | Memory usage |
| mssql.db_perform.mssqldb_batch_requests_sec | | Queries per second/cycle, the cycle refers to the set data collection cycle |
| mssql.db_perform.mssqldb_page_life_expectancy | s | The residence time of data pages in memory |
| mssql.db_perform.mssqldb_page_fault_count | | Number of data page errors/cycle, the cycle refers to the set data collection cycle |
| mssql.db_perform.mssqldb_total_page_file_kb | MB | Total page file |
| mssql.db_perform.mssqldb_available_page_file_kb | MB | Available page file |
| mssql.db_perform.mssqldb_total_physical_memory_kb | MB | Total physical memory |
| mssql.db_perform.mssqldb_available_physical_memory_kb | MB | Available physical memory |
| mssql.db_perform.mssqldb_hit_radio | % | Instance buffer hit rate |
| mssql.db_perform.mssqldb_total_pages | | The total number of pages in the instance buffer |
| mssql.db_perform.mssqldb_used_rate | % | Instance buffer usage rate |
| mssql.db_perform.mssqldb_used_pages | | Number of pages used by the instance buffer |
| mssql.db_perform.mssqldb_free_pages | | Number of free pages in the instance buffer |
| mssql.db_perform.mssqldb_tps | | Transactions per second/cycle, the cycle refers to the set data collection cycle |
| mssql.db_perform.mssqldb_full_scan | | The number of full table scans per second/cycle, the cycle refers to the set data collection cycle |
| mssql.db_perform.mssqldb_sessions | | Number of user sessions |
| mssql.db_perform.mssqldb_active_sessions | | Number of active user sessions |
| mssql.db_perform.mssqldb_inactive_sessions | | Number of inactive user sessions |
| mssql.cip.mssqldb_ha_ip_status | | ip listening status 0 means the listening port is unavailable 1 means the listening port is open|
### HAProxy plug-in

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| haproxy_backend_bytes_in_total | B | Backend host incoming byte rate/min |
| haproxy_backend_bytes_out_total | B | The backend host sends bytes rate/minute |
| haproxy_backend_connection_errors_total | | Number of connection errors/minutes |
| haproxy_backend_current_queue | | Number of unallocated backend requests |
| haproxy_backend_current_server | | Number of backend services |
| haproxy_backend_current_sessions | | Number of active backend sessions |
| haproxy_backend_up | | Backend service status |
| haproxy_backend_http_responses_total | | Backend HTTP response code |
| haproxy_frontend_bytes_in_total | | Front-end host incoming byte rate/min |
| haproxy_frontend_bytes_out_total | | The front-end host sends bytes rate/minute |
| haproxy_frontend_current_session | | Number of front-end sessions |
| haproxy_frontend_http_requests_total | | Front-end HTTP request code |
| haproxy_frontend_http_responses_total | | Frontend HTTP response code |

### Zookeeper plugin

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| zk_packets_received | | Number of packets received |
| zk_packets_sent | | Number of packets sent |
| zk_avg_latency | | Average time to respond to client requests |
| zk_max_latency | | Maximum time to respond to client requests |
| zk_min_latency | | Minimum time to respond to client requests |
| zk_outstanding_requests | | Number of queued requests |
| zk_pending_syncs | | Number of followers waiting for synchronization |
| zk_synced_followers | | Number of synchronized followers |
| zk_num_alive_connections | | Total number of client connections |
| zk_approximate_data_size | | Approximate value of data set |
| zk_ephemerals_count | | Number of ephemeral nodes |
| zk_followers | | number of followers |
| zk_max_file_descriptor_count | | File handle limit |
| zk_open_file_descriptor_count | | Number of file handles |
| zk_watch_count | | watches count |
| zk_znode_count | | Number of nodes |
| zk_up | | ZooKeeper survival status |
| zk_server_state | | service identity |

### RabbitMQ plugin

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| rabbitmq_channelsTotal | | Total number of channels opened |
| rabbitmq_connectionsTotal | | Total number of connections opened |
| rabbitmq_consumersTotal | | Number of consumers |
| rabbitmq_exchangesTotal | | Total number of exchanges in use |
| rabbitmq_queue_messages_ready_total | | The number of messages ready to be sent to the client |
| rabbitmq_queue_messages_total | | Total number of messages in the cluster |
| rabbitmq_queue_messages_unacknowledged_total | | Number of unacknowledged messages after sending |
| rabbitmq_queuesTotal | | Number of queues in use |
| rabbitmq_up | | survival status |
| rabbitmq_fd_total | | Maximum number of file handles |
| rabbitmq_fd_used | | Number of file handles used |
| rabbitmq_node_mem_used | MB | Memory usage |
| rabbitmq_partitions | | Number of network partitions visible to this node |
| rabbitmq_running | | Number of running nodes |

### Memcached plugin

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| memcached_commands_total | | Request status/minutes |
| memcached_connections_total | | Connection rate/minute |
| memcached_current_bytes | MB | The size of the currently stored item |
| memcached_current_connections | | Number of connections currently opened by the server |
| memcached_current_items | | The current number of items in the instance |
| memcached_items_evicted_total | | Rate/min of new items from cache |
| memcached_items_total | | The total number of items stored after the service is started |
| memcached_limit_bytes | MB | Memory usage limit |
| memcached_malloced_bytes | MB | allocated slab page memory |
| memcached_max_connections | | Maximum number of connections |
| memcached_read_bytes_total | bytes | The rate at which the server reads bytes from the network/minute |
| memcached_written_bytes_total | bytes | The rate at which the server sends bytes to the network/minute |
| memcached_uptime_seconds | s | Service running time |
| memcached_up | | survival status |

### ElasticSearch plugin

#### Indicator description
| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| elasticsearch_docs_deleted | | Deleted documents for all shards in the cluster |
| elasticsearch_indexing_delete_total | | The number of documents deleted from the index |
| elasticsearch_thread_pool_generic_queue | | number of generic thread pool queue threads |
| elasticsearch_thread_pool_management_active | | mgt Number of active threads in the thread pool |
| elasticsearch_thread_pool_refresh_active | | refresh number of active threads in the thread pool |
| elasticsearch_indexing_index_current | | Number of indexed documents in index |
| elasticsearch_indexing_delete_time | s | The time it takes to delete a document from the index |
| elasticsearch_indexing_index_time | s | Time spent indexing documents from index |
| elasticsearch_process_open_fd | | Open file data related to the current process |
| elasticsearch_indexing_delete_current | | Number of documents deleted from index |
| elasticsearch_thread_pool_flush_queue | | Number of bulk thread pool queued threads |
| elasticsearch_thread_pool_force_merge_queue | | Number of active threads in merge thread pool |
| elasticsearch_get_total | | Number of get requests when the document exists |
| elasticsearch_thread_pool_refresh_queue | | Number of refresh thread pool queue threads |
| elasticsearch_thread_pool_index_queue | | index thread pool queue number of threads |
| elasticsearch_thread_pool_search_threads | | search total number of thread pool threads |
| elasticsearch_transport_tx_size | MB | Size of data sent in cluster communication |
| elasticsearch_indexing_index_total | | Number of indexed documents in index |
| elasticsearch_search_fetch_open_contexts | | Number of active queries |
| elasticsearch_docs_count | | Documents for all shards in the cluster |
| elasticsearch_thread_pool_management_queue | | mgt Number of threads queued in the thread pool |
| elasticsearch_thread_pool_bulk_active | | Number of active threads in bulk thread pool |
| elasticsearch_thread_pool_search_queue | | search thread pool queue number of threads |
| elasticsearch_get_time | s | Total time on get request |
| elasticsearch_merges_current | | The current number of active segment merges |
| elasticsearch_thread_pool_flush_threads | | Total number of bulk thread pool threads |
| elasticsearch_merges_current_size | MB | The size of the segments currently being merged |
| elasticsearch_thread_pool_snapshot_active | | Number of active threads in snap thread pool |
| elasticsearch_search_fetch_current | | Number of currently running query fetch operations |
| elasticsearch_flush_total | | index flush to disk times |
| elasticsearch_flush_total_time | s | The time it takes to flush index to disk |
| elasticsearch_thread_pool_generic_threads | | generic total number of thread pool threads |
| elasticsearch_store_size | MB | Total storage size |
| elasticsearch_transport_tx_count | | Total number of packets sent in cluster communication |
| elasticsearch_merges_total | | Number of merges across all segments |
| elasticsearch_thread_pool_snapshot_queue | | Number of snap thread pool queue threads |
| elasticsearch_search_fetch_time | s | Total time of query fetch operation |
| elasticsearch_thread_pool_search_active | | search Number of active threads in the thread pool |
| elasticsearch_thread_pool_get_queue | | get the number of queued threads in the thread pool |
| elasticsearch_fielddata_evictions | | field cache eviction amount of data |
| elasticsearch_thread_pool_index_threads | | Total number of index thread pool threads |
| elasticsearch_thread_pool_flush_active | | Number of active threads in the flush queue |
| elasticsearch_search_query_time | s | Total time of query operation |
| elasticsearch_get_exists_time | s | get request time when the document exists |
| elasticsearch_get_missing_total | | Number of get requests when a document is missing |
| elasticsearch_transport_rx_count | | Total number of cluster communication packets received |
| elasticsearch_thread_pool_bulk_threads | | Total number of bulk thread pool threads |
| elasticsearch_transport_rx_size | MB | Data size accepted by cluster communication |
| elasticsearch_thread_pool_force_merge_threads | | merge thread pool total number of threads |
| elasticsearch_refresh_total | | Total index refresh times |
| elasticsearch_thread_pool_snapshot_threads | | Total number of snap thread pool threads |
| elasticsearch_fielddata_size | MB | field cache size |
| elasticsearch_transport_server_open | | Number of connections opened for cluster communication |
| elasticsearch_search_query_total | | Number of query operations |
| elasticsearch_thread_pool_bulk_queue | | The number of threads queued in the bulk thread pool |
| elasticsearch_thread_pool_get_threads | | get the total number of threads in the thread pool |
| elasticsearch_get_current | | Number of running get requests |
| elasticsearch_http_current_open | | Number of currently open http connections |
| elasticsearch_get_missing_time | s | Document missing costs get request time |
| elasticsearch_thread_pool_index_active | | Number of active threads in index thread pool |
| elasticsearch_refresh_total_time | s | Total time spent on index refresh |
| elasticsearch_http_total_opened | | The total number of open http connections |
| elasticsearch_thread_pool_generic_active | | generic number of active threads in the thread pool |
| elasticsearch_thread_pool_force_merge_active | | Number of active threads in merge thread pool |
| elasticsearch_thread_pool_refresh_threads | | refresh total number of thread pool threads |
| elasticsearch_search_fetch_total | | Query the number of fetch operations |
| elasticsearch_get_exists_total | | Number of get requests when the document exists |
| elasticsearch_merges_total_size | MB | Size of all merged segments |
| elasticsearch_merges_current_docs | | The number of documents currently merged across segments |
| elasticsearch_merges_total_docs | | Number of documents across all merged segments |
| elasticsearch_thread_pool_get_active | | get the number of active threads in the thread pool |
| elasticsearch_search_query_current | | The number of currently running query operations |
| elasticsearch_thread_pool_management_threads | | mgt total number of thread pool threads |
| elasticsearch_merges_total_time | s | Time spent merging segments |
| elasticsearch_active_primary_shards | | Number of active primary shards in the cluster |
| elasticsearch_pending_tasks_total | | Total number of unfinished tasks |
| elasticsearch_unassigned_shards | | Number of shards for unassigned nodes |
| elasticsearch_pending_tasks_priority_urgent | | Number of unfinished tasks in emergency priority |
| elasticsearch_pending_tasks_priority_high | | Number of high-priority unfinished tasks |
| elasticsearch_cluster_status | | Cluster health numbers red=0 yellow=1 green=2 |
| elasticsearch_relocating_shards | | The number of shards that the node moved to another node |
| elasticsearch_number_of_data_nodes | | Total number of node data in the cluster |
| elasticsearch_number_of_nodes | | Total number of nodes in the cluster |
| elasticsearch_active_shards | | Number of active shards in the cluster |
| elasticsearch_initializing_shards | | Current number of initialized shards |

### Kafka plugin

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| kafka_replication_leader_elections_rate | | leader election frequency |
| kafka_replication_isr_shrinks_rate | nodes/s | The rate at which replicas leave the ISR pool |
| kafka_request_handler_avg_idle_pct_rate | | Processing request thread time percentage |
| kafka_net_bytes_out_rate | bytes/s | Outgoing byte rate |
| kafka_net_bytes_rejected_rate | bytes/s | Rejected byte rate |
| kafka_messages_in_rate | | Incoming message rate |
| kafka_net_bytes_in_rate | bytes/s | Incoming byte rate |
| kafka_request_fetch_failed_rate | | Number of failed client requests |
| kafka_replication_unclean_leader_elections_rate | | unleader election frequency |
| kafka_replication_isr_expands_rate | nodes/s | The rate at which replicas are added to the ISR pool |
| kafka_request_produce_failed_rate | | Number of failed produce requests |
| kafka_request_produce_time_99percentile | ms | 99%produce request time |
| kafka_request_metadata_time_99percentile | ms | 99% metadata request time |
| kafka_request_update_metadata_time_99percentile | ms | Time to update 99% metadata request |
| kafka_request_produce_time_avg | ms | The time to produce the number of requests |
| kafka_request_update_metadata_time_avg | ms | Time to update metadata request |
| kafka_request_produce_rate | | number of produce requests |
| kafka_request_metadata_time_avg | ms | Metadata average request time |

### Mongodb plugin

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| mongodb_replset_health | | Replica set status |
| mongodb_metrics_repl_network_readerscreated | | oplog queries the number of process creations |
| mongodb_opcounters_insert | | Number of insert operations |
| mongodb_metrics_repl_network_getmores_totalmillis | ms/s | getmore operation collection data time |
| mongodb_metrics_repl_buffer_count | | Number of operations in oplog cache |
| mongodb_metrics_getlasterror_wtime_totalmillis | ms/s | Time to perform the get last error operation |
| mongodb_metrics_repl_network_getmores_num | | Number of getmore operations |
| mongodb_connections_available | | Number of available unused connections |
| mongodb_opcountersrepl_delete | | Number of replica set deletion operations |
| mongodb_asserts_regular | | Number of regular assertions |
| mongodb_metrics_queryexecutor_scanned | | Number of indexes scanned |
| mongodb_asserts_msg | | Number of message assertions |
| mongodb_mem_mapped | MB | Total memory mapped by the database |
| mongodb_metrics_repl_network_bytes | MB | Total amount of data read from server sync source |
| mongodb_metrics_record_moves | | Number of document moves on disk |
| mongodb_opcounters_query | | Number of query operations |
| mongodb_uptime | s | mongo process startup time |
| mongodb_opcounters_delete | | Number of delete operations |
| mongodb_metrics_getlasterror_wtime_num | | Write operation to get the number of last error operations |
| mongodb_metrics_operation_fastmod | | Number of operations that do not result in update |
| mongodb_metrics_document_updated | | Number of document updates |
| mongodb_mem_resident | MB | Total memory used by the database process |
| mongodb_mem_virtual | MB | Total virtual memory used by the database process |
| mongodb_asserts_user | | Number of user assertions |
| mongodb_metrics_repl_apply_batches_totalmillis | ms/s | Time to execute operations from oplog |
| mongodb_metrics_document_inserted | | Number of documents added |
| mongodb_globallock_currentqueue_writers | | The number of operations currently waiting for write locks in the queue |
| mongodb_opcountersrepl_query | | Number of replica set query operations |
| mongodb_metrics_operation_scanandorder | | Returns the number of numerical requests that cannot be indexed |
| mongodb_connections_totalcreated | | Number of total connections |
| mongodb_metrics_operation_idhack | | Number of requests containing the _id field |
| mongodb_metrics_repl_buffer_sizebytes | MB | oplog cache size |
| mongodb_opcountersrepl_command | | Total number of commands |
| mongodb_metrics_repl_buffer_maxsizebytes | MB | Maximum cache size |
| mongodb_metrics_document_returned | | Number of documents requested and returned |
| mongodb_metrics_ttl_deleteddocuments | | Number of documents deleted with ttl index |
| mongodb_metrics_repl_network_ops | | Number of read operations |
| mongodb_metrics_document_deleted | | Number of document deletions |
| mongodb_metrics_repl_apply_batches_num | | Number of batches |
| mongodb_asserts_rollovers | | Counter rollover times |
| mongodb_opcounters_command | | The total number of commands passed to the database |
| mongodb_globallock_totaltime | μs | Global lock startup time |
| mongodb_opcountersrepl_insert | | The number of replica set insert operations |
| mongodb_opcountersrepl_getmore | | The number of replica set getmore operations |
| mongodb_opcountersrepl_update | | Number of replica set update operations |
| mongodb_opcounters_update | | Number of update operations |
| mongodb_asserts_warning | | Number of warning assertions |
| mongodb_opcounters_getmore | | Number of getmore operations |
| mongodb_globallock_currentqueue_total | | Number of operations currently waiting for locks in the queue |
| mongodb_metrics_repl_apply_ops | | Number of oplog operations performed |
| mongodb_metrics_ttl_passes | | Number of deleted documents |
| mongodb_connections_current | | Number of connections from client to database server |
| mongodb_metrics_getlasterror_wtimeouts | | Number of operations caused by timeouts |
| mongodb_globallock_currentqueue_readers | | Number of operations currently waiting for read locks in the queue |
| mongodb_stats_indexsize | | Total number of all indexes created in the library |
| mongodb_stats_objects | | Number of documents in the database |
| mongodb_stats_indexes | | Total number of indexes in the database |
| mongodb_stats_storagesize | MB | collections storage space |
| mongodb_stats_datasize | MB | Amount of data in the library |

### Ceph plugin

#### Indicator description
|Indicator | Unit | Specific meaning |
| --- | --- | --- |
| ceph_num_in_osds | | Number of participating storage daemons |
| ceph_aggregate_pct_used | % | Overall capacity usage |
| ceph_num_up_osds | | Number of online storage daemons |
| ceph_num_mons | | Number of monitor daemons |
| ceph_num_pools | | Number of storage pools |
| ceph_pgstate_active_clean | | Number of active placement groups |
| ceph_num_pgs | | Number of available placement groups |
| ceph_num_near_full_osds | | Number of nearly complete osds |
| ceph_num_full_osds | | Number of full osds |
| ceph_total_objects | | Total number of objects |
| ceph_num_osds | | Number of known storage daemons |
| ceph_read_op_per_sec | MB/s | Storage pool read bytes per second |
| ceph_num_objects | | Number of objects |
| ceph_write_op_per_sec | MB/s | The number of bytes written by the storage pool per second |
| ceph_write_bytes_sec | MB/s | ceph writes bytes per second |
| ceph_read_bytes_sec | MB/s | ceph read bytes per second |
| ceph_pct_used | % | usage |
| ceph_op_per_sec | | Pool IO operations per second |
| ceph_apply_latency_ms | s | Time required for disk update |
| ceph_commit_latency_ms | s | Time required for log operations |

## JMX plugin

### JMX components

#### Indicator description

| Indicator | Unit | Specific meaning |
| ------------------------------- | ------ | ---------------- |
| jvm_buffer_pool_used_bytes | MB | Size of the used buffer pool |
| jvm_buffer_pool_capacity_bytes | MB | The byte capacity of the buffer pool |
| jvm_buffer_pool_used_buffers | | Number of buffers that have been used |
| jmx_config_reload_success_total | | The number of times the configuration has been successfully reloaded |
| jvm_threads_current | | Current number of threads |
| jvm_threads_daemon | | Current number of background threads |
| jvm_threads_peak | | Current peak number of threads |
| jvm_threads_started_total | | Count of started threads |
| jvm_threads_deadlocked | | Number of deadlocked threads waiting to acquire an object monitor or their own synchronizer |
| jvm_threads_deadlocked_monitor | | Number of deadlocked threads waiting to acquire the object monitor |
| jmx_scrape_duration_seconds | seconds | scrape time |
| jmx_scrape_error | | Number of scrape failures |
| jvm_classes_loaded | | Number of currently loaded classes |
| jvm_classes_loaded_total | | The total number of classes that have been loaded since the JVM started executing |
| jvm_classes_unloaded_total | | The total number of unloaded classes since the JVM started executing |
| jvm_info | | JVM version information |
| jvm_memory_bytes_used | MB | Memory used |
| jvm_memory_bytes_committed | MB | Committed memory |
| jvm_memory_bytes_max | MB | Maximum memory |
| jvm_memory_bytes_init | MB | Initialize memory |
| jvm_memory_pool_bytes_used | MB | Memory used in the memory pool |
| jvm_memory_pool_bytes_committed | MB | Committed memory in the memory pool |
| jvm_memory_pool_bytes_max | MB | Maximum memory in the memory pool |
| jvm_memory_pool_bytes_init | MB | Initialized memory in the memory pool |
| jmx_config_reload_failure_total | | Configure the number of reload failures |
| jvm_gc_collection_seconds_count | seconds | gc time |

### Tomcat plug-in

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| tomcat.bytes_rcvd | bytes/second | Bytes received per second |
| tomcat.bytes_sent | bytes/second | Number of bytes sent per second |
| tomcat.cache.access_count | gets/second | The number of cache accesses per second |
| tomcat.cache.hits_count | hits/second | Number of buffer hits per second |
| tomcat.error_count | errors/second | Number of requests with errors |
| tomcat.jsp.count | pages/second | Number of JSPs loaded in the web module |
| tomcat.jsp.reload_count | pages/second | Number of JSPs reloaded in the web module |
| tomcat.max_time | milliseconds | Maximum request processing time (milliseconds) |
| tomcat.processing_time | | The sum of the processing times of all requests per second |
| tomcat.request_count | requests/second | Total requests per second |
| tomcat.servlet.error_count | errors/second | The number of error requests received by the servlet /s |
| tomcat.servlet.processing_time | | The sum of the processing times of all requests passing through the servlet per second |
| tomcat.servlet.request_count | requests/second | The total number of requests through the servlet per second |
| tomcat.threads.busy | threads | Number of threads in use |
| tomcat.threads.count | threads | Number of threads in the current thread pool |
| tomcat.threads.max | threads | The maximum number of threads that can be generated by the thread pool |

## DataDog plugin

## BK-Pull plugin

### Weblogic plug-in

#### Indicator description
| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| weblogic.config.webapp_config_deployment_state | | Deployment status, the deployment status of the current application, such as being deployed, deployment failed, deployment successful, etc. |
| weblogic.config.webapp_config_jsppage_check_secs | | How often to check whether a JSP file has changed and needs to be recompiled |
| weblogic.config.webapp_config_open_sessions_current_count | | The current number of sessions for the application |
| weblogic.config.webapp_config_open_sessions_high_count | | Highest number of sessions for an application |
| weblogic.config.webapp_config_servlet_reload_check_secs | | How often to check whether a servlet has been modified |
| weblogic.config.webapp_config_session_cookie_max_age_secs | s | Session cache retention time |
| weblogic.config.webapp_config_session_idlength | | Session id length (number of digits) |
| weblogic.config.webapp_config_session_invalidation_interval_secs | s | The amount of time to wait before releasing a timeout and invalid session |
| weblogic.config.webapp_config_session_timeout_secs | s | Session timeout settings |
| weblogic.config.webapp_config_sessions_opened_total_count | | Number of open application sessions/period, the period refers to the set data collection period |
| weblogic.wls_servlet.weblogic_servlet_execution_time_average | s | The average time it takes to execute each servlet call |
| weblogic.wls_servlet.weblogic_servlet_execution_time_high | s | The length of time the longest servlet call was executed |
| weblogic.wls_servlet.weblogic_servlet_execution_time_low | s | The length of time to execute the shortest servlet call |
| weblogic.wls_servlet.weblogic_servlet_execution_time_total | s | The time for all servlet calls to be executed |
| weblogic.wls_servlet.weblogic_servlet_invocation_total_count | | The total number of servlet calls/cycle, the cycle refers to the set data collection cycle |
| weblogic.wls_servlet.weblogic_servlet_pool_max_capacity | | The maximum thread capacity of the servlet pool |
| weblogic.wls_servlet.weblogic_servlet_reload_total_count | | The number of servlet reloads/cycle, the cycle refers to the set data collection cycle |
| weblogic.workmanager.workmanager_completed_daemon_requests | | Number of daemon requests processed/cycle, the cycle refers to the set data collection cycle |
| weblogic.workmanager.workmanager_completed_requests | | Number of requests processed/cycle, the cycle refers to the set data collection cycle |
| weblogic.workmanager.workmanager_pending_daemon_requests | | The number of pending daemon requests/cycle, the cycle refers to the set data collection cycle |
| weblogic.workmanager.workmanager_pending_requests | | Number of pending requests/cycle, the cycle refers to the set data collection cycle |
| weblogic.workmanager.workmanager_stuck_thread_count | | Number of suspended threads |
| weblogic.jvm.jvm_heap_free_current | MB | Heap memory free amount |
| weblogic.jvm.jvm_heap_free_percent | % | Heap memory usage percentage |
| weblogic.jvm.jvm_heap_size_current | MB | Heap memory usage |
| weblogic.jvm.jvm_heap_size_max | MB | Maximum allowed value of heap memory |
| weblogic.jvm.jvm_process_cpu_load | | cpu load of jvm |
| weblogic.jvm.jvm_uptime | s | jvm runtime |

### Consul plugin

#### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| consul_net_node_latency_max | ms | Maximum latency from this node to other nodes |
| consul_net_node_latency_p25 | ms | p25 latency from this node to other nodes |
| consul_net_node_latency_p95 | ms | p95 latency from this node to other nodes |
| consul_net_node_latency_p90 | ms | p90 latency from this node to other nodes |
| consul_net_node_latency_p99 | ms | p99 latency from this node to other nodes |
| consul_net_node_latency_min | ms | Minimum latency from this node to other nodes |
| consul_net_node_latency_p75 | ms | p75 latency from this node to other nodes |
| consul_net_node_latency_median | ms | Medium latency from this node to other nodes |
| consul_peers | | Number of peers |
| consul_catalog_nodes_warning | | Number of warning nodes |
| consul_catalog_nodes_passing | | Passing the number of nodes |
| consul_catalog_nodes_up | | Number of nodes |
| consul_catalog_nodes_critical | | Number of critical nodes |
| consul_catalog_services_critical | | Total number of critical services |
| consul_catalog_services_passing | | Total amount of passing services |
| consul_catalog_services_up | | Total services |
| consul_catalog_services_warning | | Total number of warning services |

## IIS Plug-in

### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| iis_httpd_request_method_options | | options number of method requests |
| iis_httpd_request_method_head | | Number of head method requests |
| iis_httpd_request_method_del | | Number of del method requests |
| iis_requests_cgi | | Number of cgi request executions |
| iis_requests_isapi | | isapi request execution number |
| iis_errors_not_found | | The document causing the error was not found |
| iis_net_files_rcvd | | Number of files received per second |
| iis_httpd_request_method_put | | Number of put method requests |
| iis_httpd_request_method_trace | | number of trace method requests |
| iis_net_connection_attempts | | Connection attempts per second |
| iis_users_nonanon | | Requests from non-anonymous users per second |
| iis_net_bytes_total | | Total number of bytes transferred per second |
| iis_net_bytes_rcvd | | Bytes received per second |
| iis_net_bytes_sent | | Bytes sent per second |
| iis_net_num_connections | | Number of active connections |
| iis_errors_locked | | Number of errors caused by document locking |
| iis_users_anon | | Anonymous user requests per second |
| iis_net_files_sent | | Number of files sent per second |
| iis_httpd_request_method_post | | Number of post method requests |
| iis_httpd_request_method_get | | Number of get method requests |
| iis_uptime | | iis server runtime |

## Active_Directory plugin

### Indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| active_directory_dra_outbound_values_dns_persec | | Number of attribute values sent to replication partner DN/s |
| active_directory_dra_outbound_bytes_total | | Total number of bytes sent to replication partners |
| active_directory_ldap_searches_persec | | Rate at which LDAP clients perform search operations |
| active_directory_dra_inbound_values_dns_persec | | Number of DN attribute values received from replication partners/s |
| active_directory_dra_inbound_bytes_total | | Total bytes received from replication partners |
| active_directory_dra_outbound_values_total_persec | | Number of object attribute values sent to replication partners/s |
| active_directory_dra_inbound_objects_remaining | | Number of objects that have not completed synchronization |
| active_directory_dra_inbound_properties_filtered_p | | Number of objects that do not need to be updated |
| active_directory_dra_outbound_objects_persec | | Number of objects sent to replication partners/s |
| active_directory_ds_threads_in_use | | The number of threads currently used by the directory service |
| active_directory_dra_inbound_properties_total_pers | | Total number of object properties received from replication partners |
| active_directory_dra_inbound_objects_applied_perse | | Rate of application of updates received from replication partners |
| active_directory_dra_outbound_properties_persec | | Number of property values sent to replication partners/s |
| active_directory_dra_inbound_objects_remaining_in | | Number of object updates that were not applied to the local server |
| active_directory_dra_inbound_bytes_after_compressi | Byte | Compressed size (in bytes) of inbound compressed replication data from the Directory System Agent (DSA) at other sites (per second) |
| active_directory_dra_inbound_properties_applied_pe | | Number of inbound replication application object property changes/s |
| active_directory_dra_inbound_values_total_persec | | Number of object attribute values received from replication partners/s |
| active_directory_ldap_successful_binds_persec | | Number of LDAP binds that occurred successfully/s |
| active_directory_dra_outbound_bytes_after_compress | Byte | Compressed size, in bytes, of compressed replication data outbound to DSA in other sites (per second) |
| active_directory_dra_replication_pending_synchroni | | Number of directory synchronizations pending for this server |
| active_directory_dra_outbound_objects_filtered_per | | Number of objects confirmed by outbound replication partners/s |
| active_directory_dra_outbound_bytes_before_compres | Byte | DSA data/s outbound to other sites |
| active_directory_dra_inbound_objects_persec | | Number of objects received by replication partner inbound replication/s |
| active_directory_dra_inbound_bytes_not_compressed | KB | Other DSA inbound data/s for the same site |
| active_directory_dra_sync_requests_made | | Number of synchronization requests made to replication partners since startup |
| active_directory_ldap_bind_time | ms | Time since last successful LDAP bind |
| active_directory_dra_inbound_objects_filtered_pers | | Number of objects received from replication partners/s |
| active_directory_dra_outbound_bytes_not_compressed | Byte | Outbound data size to DSA in same site |
| active_directory_ldap_client_sessions | | Number of sessions with connected LDAP clients |
| active_directory_dra_inbound_bytes_before_compress | Byte | Other site DSA inbound data size/s |

## Exchange plugin

### Indicator description
| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| exchange_database_io_reads_avg_latency | ms | Average time for database read operations |
| exchange_database_io_db_reads_attached_persec | | Attached database database read operations per second |
| exchange_netlogon_semaphore_waiters | | Number of threads waiting to get signals |
| exchange_adaccess_processes_ldap_search | ms | Time to send LDAP search request response |
| exchange_netlogon_semaphore_hold_time | s | The average time the signal stayed in the previous example |
| exchange_network_outbound_errors | | Number of outbound packets that could not be transmitted due to errors |
| exchange_adaccess_domain_controllers_ldap_search | ms | Time to send LDAP read request to domain controller to receive response |
| exchange_database_io_db_writes_attached_persec | | Displays the number of database write operations per second for each attached database instance |
| exchange_netlogon_semaphore_acquires | | The total number of semaphore acquisitions during the entire lifetime of the secure channel connection or since the system was started for _Total |
| exchange_ws_current_connections_default_website | | Displays the current number of connections established to the default website, which corresponds to the number of connections hitting the front-end CAS server role |
| exchange_netlogon_semaphore_timeouts | | The total number of times a thread timed out while the thread was waiting for a semaphore during the entire lifetime of the secure channel connection or since the system was started for _Total |
| exchange_adaccess_processes_ldap_read | | Displays the time it took for an LDAP read request to receive a response |
| exchange_database_io_log_writes_avg_latency | | Displays the number of logs written per second for each database instance. |
| exchange_database_io_db_writes_recovery_avg_latenc | ms | Displays the average length of time for each passive database write operation (milliseconds) |
| exchange_adaccess_domain_controllers_ldap_read | ms | Displays the time it took to send an LDAP read request to the specified domain controller and receive a response |
| exchange_database_io_log_writes_persec | | Displays the number of logs written per second for each database instance |
| exchange_netlogon_semaphore_holders | | Number of threads storing signals |
| exchange_database_io_db_reads_recovery_avg_latency | ms | Displays the average length of time for each passive database read operation |
| exchange_database_io_writes_avg_latency | ms | Displays the average length of time for each database write operation (milliseconds) |
| exchange_is_store_rpc_latency | ms | RPC Latency average (msec) is the average latency (msec) of RPC requests per database |
| exchange_is_clienttype_rpc_latency | ms | Displays the average server RPC latency (milliseconds) over the past 1024 packets for a specific client protocol |
| exchange_is_clienttype_rpc_ops_persec | ms | Displays the number of RPC operations per second per client type connection |
| exchange_is_store_rpc_requests | ms | Indicates all RPC requests currently performed in the information store process |
| exchange_is_store_rpc_ops_persec | ms | Displays the number of RPC operations per second per database instance |
| exchange_activemanager_database_mounted | | Number of active database copies on the server. |
| exchange_ws_requests_persec | | Displays the number of active database copies on the server |
| exchange_network_tcpv6_connection_failures | | Displays the number of TCP connections whose current status is ESTABLISHED or CLOSE-WAIT |
| exchange_memory_available | MB | Displays the amount of physical memory (MB) immediately available for allocation to a process or for use by the system |
| exchange_ws_current_connections_total | | The current number of connections to the web service |
| exchange_rpc_ops_persec | | Displays the rate at which RPC operations occur (per second) |
| exchange_autodiscover_requests_persec | | Autodiscover service requests processed per second |
| exchange_memory_committed | % | Displays the ratio of Memory\Committed Bytes to Memory\Commit Limit |
| exchange_rpc_conn_count | | Displays the total number of client connections maintained. |
| exchange_rpc_requests | | Displays the number of client requests currently being processed by the RPC Client Access service |
| exchange_rpc_averaged_latency | | Displays the average latency of the last 1024 packets (milliseconds) |
| exchange_processor_queue_length | | Indicates the number of threads served by each processor |
| exchange_network_tcpv4_conns_reset | | Displays the number of times a TCP connection transitioned directly from the ESTABLISHED state or the CLOSE-WAIT state to the CLOSED state |
| exchange_activesync_sync_persec | | Displays the number of sync commands processed per second |
| exchange_activesync_ping_pending | | Displays the number of ping commands currently pending in the queue |
| exchange_ws_other_attempts | | Shows the rate of HTTP requests that were not made using the OPTIONS, GET, HEAD, POST, PUT, DELETE, TRACE, MOVE, COPY, MKCOL, PROPFIND, PROPPATCH, SEARCH, LOCK, or UNLOCK methods |
| exchange_ws_connection_attempts | | Displays the rate of attempts to connect to a web service |
| exchange_processor_cpu_time | | Displays the percentage of time the processor spent executing an application or operating system process |
| exchange_activesync_requests_persec | | Displays the number of HTTP requests received from clients over ASP.NET per second |
| exchange_rpc_active_user_count | | Displays the number of unique users who have performed some activity in the last 2 minutes |
| exchange_processor_cpu_privileged | | Displays the percentage of processor time spent in privileged mode |
| exchange_owa_unique_users | | Displays the number of unique users currently logged in to Outlook Web App |
| exchange_owa_requests_persec | | Displays the number of requests processed by Outlook Web App per second |
| exchange_network_tcpv6_conns_reset | | The number of times a TCP connection transitioned directly from the ESTABLISHED state or the CLOSE-WAIT state to the CLOSED state |
| exchange_processor_cpu_user | % | Percentage of processor time in user mode |
| exchange_rpc_user_count | | Displays the number of users connected to the service |
| exchange_ab_nspi_rpc_browse_requests_avg_latency | ms | Average time for sampled browsing requests to be completed |
| exchange_ab_nspi_rpc_requests_avg_latency | ms | Average NSPI request completion time |
| exchange_ab_referral_rpc_requests_avg_latency | ms | Average time for sampled reference requests to be completed |
| exchange_ab_nspi_connections_current | | Current number of NSPI clients connected to the server |
| exchange_ab_nspi_connections_per | | Number of NSPI clients connecting to the server per second |
| exchange_ab_nspi_rpc_requests_per | | Rate at which NSPI requests occur/s |
| exchange_ab_referral_rpc_requests_per | | Rate at which referral requests occur/s |
| exchange_is_store_rpc_client_backoff_per | | Indicates the rate at which client backoff occurs |
| exchange_availability_service_avg_time_to_Process | s | Average time to process free/busy requests |
| exchange_panel_asp_net_request_failures_per | | Number of failures per second detected by ASP.NET in Control Panel |
| exchange_panel_sign_on_inbound_proxy_requests_per | | Displays the number of explicit login requests received from the primary Client Access server per second |
| exchange_panel_sign_on_inbound_proxy_sessions_per | | Displays the number of explicit sign-in inbound proxy sessions loaded per second in the Exchange control panel |
| exchange_panel_sign_on_outbound_proxy_requests_per | | Displays the number of explicit login requests sent to the secondary Client Access server per second. |
| exchange_panel_inbound_proxy_requests_per | | Displays the number of requests received per second from the primary Client Access server. |
| exchange_panel_inbound_proxy_sessions_per | | The number of inbound proxy sessions loaded per second displayed in the Exchange control panel || exchange_panel_outbound_proxy_requests_avg_time | | Displays the average time (in milliseconds) it took to complete requests to the secondary Client Access server during the sample period. |
| exchange_panel_outbound_proxy_requests_per | | Displays the number of requests sent to the secondary Client Access server per second. |
| exchange_panel_outbound_proxy_sessions_per | | The number of outbound proxy sessions loaded per second displayed in the Exchange control panel |
| exchange_panel_powershell_runspace_activations_per | | Displays the number of Exchange PowerShell runspaces activated per second in Windows Control Panel |
| exchange_panel_powershell_runspace_avg_active_time | | Displays the average time in seconds that the Windows PowerShell runspace was active when executing cmdlets in the Exchange Control Panel during the sample period |
| exchange_panel_powershell_runspaces_per | | Displays the number of Windows PowerShell runspaces created per second in the Exchange Control Panel |
| exchange_panel_rbac_sessions_per | | Number of RBAC sessions loaded per second displayed in Exchange Control Panel |
| exchange_panel_requests_activations_per | | Displays the number of activated requests per second in the Exchange control panel. |
| exchange_panel_requests_avg_response_time | | The average time, in milliseconds, that the Exchange control panel took to respond to requests.

### Exchange 2013 indicator description

| Indicator | Unit | Specific meaning |
| --- | --- | --- |
| exchange_database_io_reads_avg_latency | ms | Average time for database read operations |
| exchange_database_io_db_reads_attached_persec | | Attached database database read operations per second |
| exchange_netlogon_semaphore_waiters | | Number of threads waiting to get signals |
| exchange_adaccess_processes_ldap_search | ms | Time to send LDAP search request response |
| exchange_netlogon_semaphore_hold_time | s | The average time the signal stayed in the previous example |
| exchange_network_outbound_errors | | Number of outbound packets that could not be transmitted due to errors |
| exchange_adaccess_domain_controllers_ldap_search | ms | Time to send LDAP read request to domain controller to receive response |
| exchange_database_io_db_writes_attached_persec | | Displays the number of database write operations per second for each attached database instance |
| exchange_netlogon_semaphore_acquires | | The total number of semaphore acquisitions during the entire lifetime of the secure channel connection or since the system was started for _Total |
| exchange_ws_current_connections_default_website | | Displays the current number of connections established to the default website, which corresponds to the number of connections hitting the front-end CAS server role |
| exchange_netlogon_semaphore_timeouts | | The total number of times a thread timed out while the thread was waiting for a semaphore during the entire lifetime of the secure channel connection or since the system was started for _Total |
| exchange_adaccess_processes_ldap_read | | Displays the time it took for an LDAP read request to receive a response |
| exchange_database_io_log_writes_avg_latency | | Displays the number of logs written per second for each database instance. |
| exchange_database_io_db_writes_recovery_avg_latenc | ms | Displays the average length of time for each passive database write operation (milliseconds) |
| exchange_adaccess_domain_controllers_ldap_read | ms | Displays the time it took to send an LDAP read request to the specified domain controller and receive a response |
| exchange_database_io_log_writes_persec | | Displays the number of logs written per second for each database instance |
| exchange_netlogon_semaphore_holders | | Number of threads storing signals |
| exchange_database_io_db_reads_recovery_avg_latency | ms | Displays the average length of time for each passive database read operation |
| exchange_database_io_writes_avg_latency | ms | Displays the average length of time for each database write operation (milliseconds) |
| exchange_httpproxy_server_locator_latency | ms | Displays the average latency (milliseconds) of MailboxServerLocator web service calls |
| exchange_httpproxy_clientaccess_processing_latency | ms | Displays the average latency (milliseconds) of CAS processing time (excluding time spent by proxy) over the last 200 requests |
| exchange_httpproxy_proxy_requests_persec | ms | Displays the number of proxy requests processed per second |
| exchange_httpproxy_requests_persec | ms | Displays the number of requests processed per second |
| exchange_httpproxy_mailbox_proxy_failure_rate | ms | Displays the percentage of connections involving failures between this Client Access server and the MBX server for the last 200 examples |
| exchange_httpproxy_avg_auth_latency | ms | Displays the average time taken to authenticate CAS requests over the last 200 examples |
| exchange_httpproxy_outstanding_requests | ms | Displays the number of concurrent outstanding proxy requests |
| exchange_is_store_rpc_latency | ms | RPC Latency average (msec) is the average latency (msec) of RPC requests per database |
| exchange_is_clienttype_rpc_latency | ms | Displays the average server RPC latency (milliseconds) over the past 1024 packets for a specific client protocol |
| exchange_is_clienttype_rpc_ops_persec | ms | Displays the number of RPC operations per second per client type connection |
| exchange_is_store_rpc_requests | ms | Indicates all RPC requests currently performed in the information store process |
| exchange_is_store_rpc_ops_persec | ms | Displays the number of RPC operations per second per database instance |
| exchange_workload_management_completed_tasks | ms | Displays the number of workload management tasks currently queued for processing |
| exchange_workload_management_queued_tasks | ms | Displays the number of completed workload management tasks |
| exchange_workload_management_active_tasks | ms | Displays the number of active tasks running in the background for the current workload management |
| exchange_activemanager_database_mounted | | Number of active database copies on the server. |
| exchange_ws_requests_persec | | Displays the number of active database copies on the server |
| exchange_network_tcpv6_connection_failures | | Displays the number of TCP connections whose current status is ESTABLISHED or CLOSE-WAIT |
| exchange_memory_available | MB | Displays the amount of physical memory (MB) immediately available for allocation to a process or for use by the system |
| exchange_ws_current_connections_total | | The current number of connections to the web service |
| exchange_rpc_ops_persec | | Displays the rate at which RPC operations occur (per second) |
| exchange_autodiscover_requests_persec | | Autodiscover service requests processed per second |
| exchange_memory_committed | % | Displays the ratio of Memory\Committed Bytes to Memory\Commit Limit |
| exchange_rpc_conn_count | | Displays the total number of client connections maintained. |
| exchange_rpc_requests | | Displays the number of client requests currently being processed by the RPC Client Access service |
| exchange_rpc_averaged_latency | | Displays the average latency of the last 1024 packets (milliseconds) |
| exchange_processor_queue_length | | Indicates the number of threads served by each processor || exchange_network_tcpv4_conns_reset | | Displays the number of times a TCP connection transitioned directly from the ESTABLISHED state or the CLOSE-WAIT state to the CLOSED state |
| exchange_activesync_sync_persec | | Displays the number of sync commands processed per second |
| exchange_activesync_ping_pending | | Displays the number of ping commands currently pending in the queue |
| exchange_ws_other_attempts | | Shows the rate of HTTP requests that were not made using the OPTIONS, GET, HEAD, POST, PUT, DELETE, TRACE, MOVE, COPY, MKCOL, PROPFIND, PROPPATCH, SEARCH, LOCK, or UNLOCK methods |
| exchange_ws_connection_attempts | | Displays the rate of attempts to connect to a web service |
| exchange_processor_cpu_time | | Displays the percentage of time the processor spent executing an application or operating system process |
| exchange_activesync_requests_persec | | Displays the number of HTTP requests received from clients over ASP.NET per second |
| exchange_rpc_active_user_count | | Displays the number of unique users who have performed some activity in the last 2 minutes |
| exchange_processor_cpu_privileged | | Displays the percentage of processor time spent in privileged mode |
| exchange_owa_unique_users | | Displays the number of unique users currently logged in to Outlook Web App |
| exchange_owa_requests_persec | | Displays the number of requests processed by Outlook Web App per second |
| exchange_network_tcpv6_conns_reset | | The number of times a TCP connection transitioned directly from the ESTABLISHED state or the CLOSE-WAIT state to the CLOSED state |
| exchange_processor_cpu_user | % | Percentage of processor time in user mode |
| exchange_rpc_user_count | | Displays the number of users connected to the service |


