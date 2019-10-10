# InfluxDB 常见问题

## InfluxDB 查询

Influxdb 为蓝鲸监控数据存储载体，在发生蓝鲸监控没有数据时，有个 check 点，确认 InfluxDB 是否正常

检查 InfluxDB 的数据库

```bash
$ influx -host $INFLUXDB_HOST -port $INFLUXDB_PORT -execute 'show databases'
name: databases
name
----
_internal
system_2
```

检查 InfluxDB 的结构

```bash
$ influx -host $INFLUXDB_HOST -port $INFLUXDB_PORT -database system_2 -execute 'show measurements'
name: measurements
name
----
system_cpu_detail_2
system_cpu_summary_2
system_disk_2
system_env_2
system_inode_2
system_io_2
system_load_2
system_mem_2
system_net_2
system_netstat_2
system_proc_2
system_swap_2
```

检查 InfluxDB 的数据

```bash
> select * from system_cpu_detail_2 limit 10;
name: system_cpu_detail_2
time                company_id device_name hostname idle               iowait               ip            plat_id stolen system               usage              user
----                ---------- ----------- -------- ----               ------               --            ------- ------ ------               -----              ----
1535439967000000000 0          cpu0        rbtnode1 0.6058552226105512 0.0694560560385358   10.x.x.x 0       0      0.04019670092112785  48.09914587171289  0.28380991039469905
1535439967000000000 0          cpu7        rbtnode1 0.7863101634785973 0.00837019347933527  10.x.x.x 0       0      0.030681614533304973 24.205951186893405 0.17413388216866021
1535439967000000000 0          cpu2        rbtnode1 0.6678563495185631 0.009100081035768667 10.x.x.x 0       0      0.040028319084854255 35.79896476874237  0.2824698411674115
1535439967000000000 0          cpu6        rbtnode1 0.7829082548721787 0.012854377626957599 10.x.x.x 0       0      0.03067846131995839  24.644470470134607 0.1730757661552659
1535439967000000000 0          cpu5        rbtnode1 0.7646966906635414 0.028642471368069893 10.x.x.x 0       0      0.030657712793992715 30.637870416875536 0.1755306285693026
1535439967000000000 0          cpu1        rbtnode1 0.6646903677764837 0.011202611791902923 10.x.x.x 0       0      0.03985501626475787  35.816906114265606 0.2837339392108164
1535439967000000000 0          cpu4        rbtnode1 0.7346243011891722 0.05592099142758973  10.x.x.x 0       0      0.0312518993637984   38.19095477386919  0.1776992052751767
1535439967000000000 0          cpu3        rbtnode1 0.6710939376132079 0.007952705725687499 10.x.x.x 0       0      0.0398088272799649   34.2078877005351   0.28061707932910834
1535440027000000000 0          cpu4        rbtnode1 0.7345565004723897 0.05588967150219944  10.x.x.x 0       0      0.03126793860725039  28.370927318295703 0.1777816774563495
1535440027000000000 0          cpu3        rbtnode1 0.6710074762738196 0.00793005575830115  10.x.x.x 0       0      0.03980792783012481  35.225375626044226 0.2807265704162614
```
