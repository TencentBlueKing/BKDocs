 # BK-CI Components 

 ![](../../assets/image%20(15).png) 

 BlueKing CI\(**BK-CI** \for short) is written and implemented based on multiple languages such as kotlin/java/js/go/lua/shell. It adopts complete front-back separation, Plugin Develop, and has a highly available and extensible service architecture design: 

 * **WebAPI Gateway & FrontEnd\:** 
  * **WebAPI Gateway：** Managed by OpenResty, including the lua Script and Nginx configuration for connecting user signIn and identity authentication, and the **Consul** service discovery and forwarding of backend APIs setting 
  * **FrontEnd:** A pure front-end project based on VUE, including One index of static resources such as js,img and html. 
 * **Backend service\(MicroService BackEnd\):** It is written in Kotlin/Java and adopts the service architecture design of SpringCloud framework. The following is the Start Up order of each microservice module: 
  * **Project:** projectManage, which is used to manage Pipeline. Modules dependOn it. 
  * **Log:** build log service, which is responsible for receiving the forwarding Storage and Query Output of the built logs. 
  * **Ticket:** credentialManage service, which Storage user certificate information, such as Code Repository account password/SSL/Token. 
  * **Repository:** Code Package management service, which Storage the user's code base and dependOn the linkage of tickets. 
  * **Artifactory:** Artifact artifactory service, The only implements the simplified version of component access function and can be extended to connect with your own Storage system. 
  * **Environment:** agent service, which is used to import builders and manage the concurrency of the builder cluster with Pools. 
  * **Store:** store service, which is responsible for Manage the functions of Pipeline extension Plugin and pipeline templates, including plug-in and template upgrade and removal, and linkage with process and artifactory. 
  * **Process:** Pipeline Manage is the core service for managing pipelines and scheduling pipelines. 
  * **Dispatch:** build (machine) Schedule, which is responsible for receiving agent Start Up event of Pipeline and distributing it to the corresponding build machine for processing. 
  * **Plugin:** service Plugin extension service. It is empty at present. It is mainly used to provided subsequent extensions with backend services linked with the front-end page, such as connecting various CD platforms, Test platforms, quality inspection platforms, etc. There is a lot of room for imagination when setting with the front-end page. 
 * ** resources service: ** provided Storage and Must Base middleware. 
  * **Storage Storage service:** One index of dependent Base environment such as storage service/middleware. 
    * **MySQL/MariaDB：** BK-CI's main Database Storage, mysql 5.7.2 /mariadb 10.x can be used to store the relational data of all the above service. 
    * **Redis:** Core service cache, version 3.x. Caches the information of the agent and the information during building, and provided distributed locking Operation. 
    * **ElasticSearch：** log Storage. The log module interfaces with ES to access the build log. 
    * **RabbitMQ:** Core Message queue service. BK-CI's Pipeline event mechanism flows event messages based on RabbitMQ. 
    * **FileSystem：** This block mainly provided service for artifactory, which is used to Storage Plugin, build products and other Two file services. It can be used to connect files or cloud storage classes, and is extended to the artifactory service module. 
    * **Consul:** As the service discovery Server of service, you need to build Consul Server, install Consul on the machine where BK-CI microservices Deploy, and Run it as an Agent. The cluster can be directly Start Up on the BK-CI service Deploy machine\(2 sets\) in the form of consume server and agent to decreased the number of machines. 
  * **Agent\(agent\):** A builder is One service/PC that Run CI packages, compiles, and builds. It is dependent on compilation environment such as go, gcc, java, python, and nodejs, and runs two service processes that are provided and implemented by BK-CI: 
    * **Agent:** Written and implemented by Golang, it consists of DevopsDaemon and DevopsAgent processes: 
      * **DevopsDaemon：** Responsible for guarding and Start Up DevopsAgent. 
      * **DevopsAgent：** is responsible for communicating with **Dispatch** and **Environment** service, upgrading the entire **Agent** and Start Up and destory the **Worker**\(Task executor\) process. 
    * **Worker:** Written and implemented by Kotlin, it is One file named agent.jar, which is the real execute of the Task.  It is pulled up and run by **DevopsAgent** approve jre, and then it is responsible for communicating with **Process service module **, receiving Plugin Task, execute and reporting result\(**Log&Process**\). 

