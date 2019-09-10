### 开源组件{#openplugins}

#### Java

- Elasticsearch: 切换到 ES 用户执行 /data/bkce/service/es/bin/es.sh start

- ZooKeeper: /data/bkce/service/zk/bin/zk.sh start

- Kafka: /data/bkce/service/kafka/bin/kafka.sh start

#### Golang/C/C++

- Nginx: nginx 或者nginx -s reload

- Beanstalkd: `nohup beastalkd -l $LAN_IP -p $BEANSTALK_PORT &>/dev/null &`

- MySQL: /data/bkce/service/mysql/bin/mysql.sh start

- MongoDB: /data/bkce/service/mongodb/bin/mongodb.sh start

#### Erlang

- RabbitMQ: `systemctl start rabbitmq-server`
