 # Product Architecture 

 The Standard OPS backend uses Python as the Development language and the Django App framework. The front-end uses Vue to Develop page and jQuery to develop atoms. approve the setting development mode, the difficulty of developing atomic front-end forms is continuously reduced. 

 The product structure of Standard OPS is shown in the figure below: 

 ![-w2020](../assets/1.png) 

 - Access layer: including auth control, API interface and Statistics; 

 - Task management layer: It mainly corresponds to the task scheduling and task control functions of Standard OPS. Task scheduling includes the Base unit Standard Plugin framework and standard plug-in display layer. Task control includes template Check and Parameter verification for Create Task instances, and Operation interfaces provided to user during task instance execute, such as PAUSE, Continue, and Undo tasks. 

 - Flow engine layer: It is responsible for parsing the Task instance of the upper layer, mapping the service corresponding to the Node Standard Plugin, and calling the API of Other system approve the underlying BlueKing Service Bus (ESB)(such as the create Set of the CMDB, the quick execute Script of the Job System, etc.). The process engine layer also includes the specific task execution engine, process control, context Manage and other module. 