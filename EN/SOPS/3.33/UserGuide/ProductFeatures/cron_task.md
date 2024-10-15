 # Scheduled Task 

 Scheduled Task can meet the needs of user to execute tasks According to specific period. 

 ![周期任务](../assets/image-20220915155737486.png)

 1. Add Scheduled Task. A recurring task has Three important components 

   - Flow to be execute 
   - Periodic Expression, the expression is exactly the same as Crontab 
   - Input parameter of the Flow to be execute 

 ![1689048688364](image/cron_task/1689048688364.png) 

 2. Update Scheduled Task 

 - The snapshot Data of the Flow is used when the Scheduled Task is create. When the process is changed, the periodic task will prompt the process Updated, but the link snapshot will not be Automatic update. 

  You can Update the Flow approve edit Scheduled Task. 

 - In addition to Update Flow, you can also update information such as cycle Expression and Parameter 

 ![1689049178132](image/cron_task/1689049178132.png) 