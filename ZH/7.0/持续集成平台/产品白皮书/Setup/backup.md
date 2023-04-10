# **蓝盾备份方案**

为了在出现不可恢复的故障的时，能够有完整的数据用于环境恢复，您可以按照下面的方式，对数据进行备份。


## **Mysql**  
    ## 在mysql机器自动生成定时任务，定时执行备份

        source /data/install/utils.fc

        ssh root@$BK_MYSQL_IP0 "$CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking mysql"



    ## 进到mysql机器，手动执行命令备份

        source /data/install/utils.fc

        bash /data/src/backup/dbbak/dbbackup_mysql.sh /data/src/backup/dbbak/dbbackup_mysql.conf blueking


## **MongoDB**  
    ## 在mongodb机器自动生成定时任务，定时执行备份

        source /data/install/utils.fc

        ssh root@$BK_MONGODB_IP0 "$CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking mongodb"



    ## 进到mongodb机器，手动执行命令备份

        source /data/install/utils.fc

        bash /data/src/backup/dbbak/dbbackup_mongodb.sh /data/src/backup/dbbak/dbbackup_mongodb.conf blueking

## **Redis** 
    ## 在redis机器自动生成定时任务，定时执行备份

        source /data/install/utils.fc

        ssh root@$BK_REDIS_IP0 "$CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking redis"



    ## 进到redis机器，手动执行命令备份

     source /data/install/utils.fc

     bash /data/src/backup/dbbak/dbbackup_redis.sh /data/src/backup/dbbak/dbbackup_redis.conf blueking


## **InfluxDB** 
    ## 在influxdb机器自动生成定时任务，定时执行备份

        source /data/install/utils.fc

        ssh root@$BK_INFLUXDB_IP0 "$CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking influxdb"



    ## 进到influxdb机器，手动执行命令备份

        source /data/install/utils.fc

        bash /data/src/backup/dbbak/dbbackup_influxdb.sh /data/src/backup/dbbak/dbbackup_influxdb.conf blueking



