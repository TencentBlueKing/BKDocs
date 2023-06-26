
 ### Uninstalling Agent Manually in Linux 
 1. NodeMan-Remove Agent 

 ![](../assets/001.png) 

 2. Go to the Configuration System Delete the host (if you need to reinstall the agent and Install it under the same Business Name, you can not delete it). 

 ```bash 
  Transfer the host to the idle machine-> transfer to the host pool, switch to the host pool to Delete 
  ``` 

 3. Stop the process 
 ```bash 
 /usr/local/gse/agp 
 ``` 

 4. Delete the directory 
 ```bash 
 rm -rf /run/gse 
 rm -rf /var/lib/gse 
 rm -rf /var/log/gse 
 rm -rf /use/local/gse 
 ``` 
 <br/> 

 ### Uninstalling Agent Manually on Windows 

 1. NodeMan-Remove Agent 

 ![](../assets/001.png) 

 2. Go to the Configuration System Delete the host (if you need to reinstall the agent and Install it under the same Business Name, you can not delete it). 

  ```bash 
  Transfer the host to the idle machine-> transfer to the host pool, switch to the host pool to Delete 
  ``` 

 3. Stop the service 
 ```bash 
 cd c:\gse\agent\bin 
 gsectl.bat stop agent 
 ``` 

 ![16530466032174](../assets/16530466032174.png) 

 4. Delete the directory 

 ![](../assets/1653046582122.png) 