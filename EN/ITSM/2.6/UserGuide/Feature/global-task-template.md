 ## Checks Template 

 The Task Module Apply in the Flow is used to Created and Manage specific tasks related to the process. 

 Applicable Scene: For some node in the Flow, the processing specifications of the template have been formed, but the specific processing content can only be specified when the Ticket instance occurs. 

 for example, in change Manage, the change plan needs to be Confirm.  It involves specific change Operation.  However, the Operation execute items of each change may be different, and the handlers may also be different, and the content of the change items can only be executed after being Approved. 

 ### Create and Manage Checks Templates 

 The system has two built-in templates: Normal Task and Standard OPS task.  Administrator can approve Add new to Created Other Task templates as appropriate. 

 (<font color=red>Currently, the new Task template can only be a Normal task template</font>) 

 Differences between Normal Task templates and Standard OPS task templates: The Standard OPS Task template is mainly used to interface with the Flow template in standard OPS, and is used to Created specific standard OPS tasks in Ticket. 

 (<font color=red>Description: Since Standard OPS Flow templates are strongly link with Business Name attributes, if you want to Created standard OPS Task for different businesses in process instances, you Must strongly associate the process with the business during process design.  Otherwise, you can only Choose the Common Flow template in Standard OPS.  </font>） 

 ![-w2021](media/612edbed8fb0115f01bc25fb68434235.png) 

 <center>Task template</center> 

 ![-w2021](media/abb0c48dc9ad7c3071b542dd7553bf8c.png) 

 <center>Normal Checks Template setting</center> 

 ![-w2021](media/9650d7bdbedb33e96f36959bf5770f3d.png) 

 <center>Standard OPS Checks Template setting</center> 

 setting the Field attributes in the three Stage of the Task as required, and save them as task templates upon submission. 

 ### Apply Checks Template in Flow 

 > **setting entry: In the Three step of Flow design,"Process Enable Set"\>; Advanced configuration\>; Checks Configuration.** 

 append a Task template.  Multiple different Task templates can be append to One Flow.  append multiple Task templates means that you can Choose different task templates to Created tasks in the Flow Ticket instance. 

 ![-w2021](media/a2b665bc93e1e2f680fbaa4655376701.png) 

 <center>Serving Config Entry of Checks</center> 

 After append a Task template, you need to setting the conditions for task Apply. 

 **Create Task criteria**: Indicates at what node in the Flow a Task can be create.  (<font color=red>Description: Since the Task needs to be link with the Ticket instance, the task Must be create after the bill of lading is complete.  </font>When the Flow reaches The Node, the Current processor can Created a Task. 

 **Checks processing conditions**: At what node in the Flow a Task can be processed.  When The Node is reached, the handler of the Task will be able to work on the task.  (<font color=red>Description: Checks create and processing cannot be in the same Node</font>) 

 ### Create and Processing Task in Ticket 

 ![-w2021](media/b178f3194effb1ad01ce3dc14b86c2e8.png) 

 <center>Checks create 1</center> 

 New task: There are two ways to Created a task. 

 -   Created directly: directly Choose a Task template to create. 

 -   Created from Task library: refers to create after select Revise from the previous task library.  Here, user save the previous Task as a task library.  (Applicable to relatively fixed Task item) 

 ![-w2021](media/13e693a8b12ae87f5feaf4a725c7a2b0.png) 

 <center>Checks create 2</center> 

 ![-w2021](media/f52554ab58807dfe7ce5e4ba4f83f87c.png) 

 <center>Tasks</center> 

 Sequence: The order in which Task are execute.  Task are processed in descending order of number.  The same numbers are denoted as parallel Task.  You can change the order in which tasks are executed by modifying their sequence numbers. 

 <font color=red>Task can be created, edit, and delete only during the create Stage.  After the create Stage is finish, the Task cannot be Revise.  </font> 

 ![-w2021](media/e88bee9cc587ec904494e6327adfea6b.png) 

 <center>Operation entry of Task</center> 

 When the Ticket flows to the Node where the Task is processed, the task processor can Enter the Document details page to process and summarize the task.  if that Task are serial, the preceding task must be complete before the next task can be started. 