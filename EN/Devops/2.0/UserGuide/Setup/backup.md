 # BK-CI Backup Scheme 

 In order to have complete data for environment recovery in the event of an Non-recoverable failure, you can back up the data According to the following way. 


 ## **Mysql**  
    ##auto Generate Cron in MySQL Machine and execute Backup on a Scheduled Basis 

        source /data/install/utils.fc 

        ssh root@$BK_MYSQL_IP0 "$CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking mysql" 



    ##Enter the mysql machine and manual execute the command backup 

        source /data/install/utils.fc 

        bash /data/src/backup/dbbak/dbbackup_mysql.sh /data/src/backup/dbbak/dbbackup_mysql.conf blueking 


 ## **MongoDB**  
    ##auto Generate Cron on MongoDB and execute Backup on a Scheduled Basis 

        source /data/install/utils.fc 

        ssh root@$BK_MONGODB_IP0 "$CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking mongodb" 



    ##Enter the mongodb machine and manual execute the command backup 

        source /data/install/utils.fc 

        bash /data/src/backup/dbbak/dbbackup_mongodb.sh /data/src/backup/dbbak/dbbackup_mongodb.conf blueking 

 ## **Redis** 
    ##auto Generate Cron on the redis machine and execute backups on a scheduled basis 

        source /data/install/utils.fc 

        ssh root@$BK_REDIS_IP0 "$CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking redis" 



    ##Log into the redis machine and manual execute command backup 

     source /data/install/utils.fc 

     bash /data/src/backup/dbbak/dbbackup_redis.sh /data/src/backup/dbbak/dbbackup_redis.conf blueking 


 ## **InfluxDB** 
    ##auto Generate Cron on the influxdb machine to execute backups on a scheduled basis 

        source /data/install/utils.fc 

        ssh root@$BK_INFLUXDB_IP0 "$CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking influxdb" 



    ##Enter the influxdb machine and manual execute the command backup 

        source /data/install/utils.fc 

        bash /data/src/backup/dbbak/dbbackup_influxdb.sh /data/src/backup/dbbak/dbbackup_influxdb.conf blueking 