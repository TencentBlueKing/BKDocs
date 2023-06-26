# Transfer手动分配data_id维护说明

1. 命令介绍
```bash
Usage:
  transfer manual [flags]

Flags:
  -d, --data_id string   需要操作的数据源ID
  -h, --help             help for manual
  -l, --list             例举所有手动分配的数据源信息
  -r, --remove           删除配置，默认为追加
  -t, --target string    目前实例ID，格式为 transfer-xxxxx
```

2. 操作命令
   1. 查看当前集群
   ```bash
   ./transfer  cluster 
   Using config file: /data/bkee/bkmonitorv3/transfer/transfer.yaml
   +--------+------------------------+---------------+-------+---------------------------+------+
   |        |        SERVICE         |    ADDRESS    | PORT  |           TAGS            | META |
   +--------+------------------------+---------------+-------+---------------------------+------+
   |        | bkmonitorv3-2465020571 | 9.1.1.1       | 10202 | transfer-service,transfer |      |
   | leader | bkmonitorv3-1028574878 | 9.1.1.2       | 10202 | transfer-service,transfer |      |
   |        | bkmonitorv3-4282652943 | 9.1.1.3       | 10202 | transfer-service,transfer |      |
   |        | bkmonitorv3-1605428007 | 9.1.1.4       | 10202 | transfer-service,transfer |      |
   +--------+------------------------+---------------+-------+---------------------------+------+
   ```

   2. 查看当前data_id分配
   ```
   ./transfer  shadow
   Using config file: /data/bkee/bkmonitorv3/transfer/transfer.yaml
   +------------------------+---------+-------------------------------------------------------------------------------------+
   |        SERVICE         | SOURCE  |                                       TARGET                                        |
   +------------------------+---------+-------------------------------------------------------------------------------------+
   | bkmonitorv3-1028574878 | 1200024 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-1028574878/1200024 |
   | bkmonitorv3-1028574878 | 1500088 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-1028574878/1500088 |
   | bkmonitorv3-1028574878 | 1500132 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-1028574878/1500132 |
   ....
   | bkmonitorv3-2465020571 |    1007 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-2465020571/1007    |
   | bkmonitorv3-4282652943 | 1500119 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-4282652943/1500119 |
   | bkmonitorv3-4282652943 | 1500087 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-4282652943/1500087 |
   +------------------------+---------+-------------------------------------------------------------------------------------+
   253 links, avg:63.25, var:0.92  
   ```

   3. 指定data_id分配
   ```
   ./transfer manual -d 1007 -t bkmonitorv3-4282652943 
   ```
   > 注意：增加-r参数则可以将该指派清理

   4. 触发重新分配data_id
   ```
   ./transfer dispatch
   ```

   5. 检查效果
    ```
   ./transfer  shadow
   Using config file: /data/bkee/bkmonitorv3/transfer/transfer.yaml
   +------------------------+---------+-------------------------------------------------------------------------------------+
   |        SERVICE         | SOURCE  |                                       TARGET                                        |
   +------------------------+---------+-------------------------------------------------------------------------------------+
   | bkmonitorv3-1028574878 | 1200024 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-1028574878/1200024 |
   | bkmonitorv3-1028574878 | 1500088 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-1028574878/1500088 |
   | bkmonitorv3-1028574878 | 1500132 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-1028574878/1500132 |
   ....
   | bkmonitorv3-4282652943 |    1007 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-2465020571/1007    |
   | bkmonitorv3-4282652943 | 1500119 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-4282652943/1500119 |
   | bkmonitorv3-4282652943 | 1500087 | bk_bkmonitorv3_enterprise_production/service/data_id/bkmonitorv3-4282652943/1500087 |
   +------------------------+---------+-------------------------------------------------------------------------------------+
   253 links, avg:63.25, var:0.92  
    ```

3. 常见问题

   1. 如果data_id有多个分区，该如何分配？
   - 同一个data_id的指派操作可以多次执行

      

   2. 如果一个data_id被多次指派，会有什么表现？
   - 如果当data_id指派的次数小于kafka的分区数，那么每个指派都会生效，交由各个transfer实例负责处理
   - 如果当data_id指派的次数大于kafka的分区数，那么最后一次的指派会生效，前面的各项指派将会被覆盖

      