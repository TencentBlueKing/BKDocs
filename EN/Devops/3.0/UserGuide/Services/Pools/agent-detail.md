 # Agent detail Page 

 After hosting your agent to BK-CI, you can view the list of build machines and the detail of each build machine on this page. 

 ## List of agent 

 ![](../../assets/image%20%2834%29.png) 

 * **agent detail** 

 ![](../../assets/image%20%2820%29.png) 

 1. agent cpuUsageRate trend Chart 
 2. agent ramUsageRate trend Chart 
 3. agent networkIo trend Chart 
 4. agent diskIo trend Chart 
 5. copyInstallCommand: used when RUNNING in the Scene where the agent is reinstalled and the Agent directory is delete 
 6. provided four important pieces of information about this agent: 
   1. Basic Information: Contains basic information such as the startUser, install directory, agentVersion, and the maximum concurrent number of buildTask (default is 4, to prevent the agent from being Load). 
   2. Env Variables (to be delete) 
   3. buildTask: all Pipeline jobs assigned to this agent will appear here. You can view the specific task assignment information here when you encounter task QUEUE. 
   4. machineActivityRecord and offline: One record will be generated here when the Agent of the agent is Batch and online.assets