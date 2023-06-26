 # Environment Requirements 
 * Kubernetes: `1.12` or later 
 * Helm: `v3.0.0` or later 

 # Storage 
 | name | note | 
 |-------------------|------------------------| 
 | **MySQL** | Used to store relational data, requires version 5.7 or later| 
 | **Redis** | Message queue for storing cached data and background task| 
 | **bkrepo** | used to store apply deploy intermediate results and cache information; used as a pypi, npm image source; and provides object storage add-ons to SaaS| 
 | **RabbitMQ** | Used to deploy RabbitMQ add-ons to SaaS| 
 | **Sentry** | Non-core dependency, used to report abnormal information of program| 
 | **ElasticSearch** | Non-core dependency, used to store SaaS log| 

 # System Functions 

 | Process name | Function | 
 |-------------------|------------------------| 
 | bkpaas3-webfe-web | The front-end of a PaaS, hosting static page, approving Nginx| 
 | bkpaas3-apiserver-web |The PaaS master module provides API service and is responsible for interacting with the Kubernetes backend.| 
 | bkpaas3-apiserver-worker |apiserver background task process| 
 | bkpaas3-apiserver-deleting-instances |Delete the Binding Add-ons instance every half hour| 
 | bkpaas3-apiserver-update-pending-status |Update the status of the Deploy tasks Every half-hour 
 | bkpaas3-apiserver-migrate-db |Initialize api-server module DB and create bkreop repository and bucket| 
 | bkpaas3-apiserver-init-data |initialization data| 
 | bkpaas3-apiserver-init-devops |Initialize Application Runtime| 
 | bkpaas3-apiserver-init-npm |Initialize the Apply Develop NPM package, It is also possible not to open| 
 | bkpaas3-apiserver-init-pypi |Initialize the Apply Develop Pypi package, It is also possible not to open|
 | bkpaas3-svc-bkrepo-web |bkrepo add-ons master process| 
 | bkpaas3-svc-bkrepo-migrate-db |Initialize svc-bkrepo module DB| 
 | bkpaas3-svc-mysql-web |MySQL Add-ons Master Process 
 | bkpaas3-svc-mysql-migrate-db |Initialize svc-mysql Module DB| 
 | bkpaas3-svc-mysql-deleting-instances |Clean up deleted MySQL Add-ons instances every half hour| 
 | bkpaas3-svc-rabbitmq-web |RabbitMQ Add-ons Master Process| 
 | bkpaas3-svc-rabbitmq-migrate-db |Initialize svc-rabbitmq module DB| 
 | bkpaas3-svc-rabbitmq-deleting-instances | Clean up deleted RabbitMQ Add-ons instances every half hour|. 