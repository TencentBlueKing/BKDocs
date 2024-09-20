 # Import Windows agent 

 > 1. Before hosting, prepare the execute environment: [Self hosted agent environment preparation](prepara-agent.md) 
 > 2. **If your Windows build needs to Start Up UI programs in Pipeline**(for example, open a browser for auto Test), please see [Solution to Windows Agent Startup Interface Program](windows-agent-run-ui.md). 
 > 3. Agent resources are isolated by project. If multiple projects import Self hosted agent, you need to import agents under different projects and install them in different directories.  (The install package/Script for each agent is different) 

 ## Obtaining Agent Package from BK-CI 

 According to [Host your agent to BK-CI](../host-to-bkci.md), select Windows, and download the Agent package 

 ## create an Agent Install directory on a Windows agent 

 ```text 
 new-item C:\data\landun -itemtype directory 
 ``` 

 ## Decompressing RUNNING 

 Unzip OK download Agent package to the file create in One previous step 

 ![bkci-hosted-windows-agent-1](../../../assets/bkci-hosted-windows-agent-1.png) 

 Run install.bat as Administrator 

 ![bkci-hosted-windows-agent-2](../../../assets/bkci-hosted-windows-agent-2.png) 

 ## Switching Agent service startUser 

 The above Operation Agent Install as a system service, and the startUser of the service is the built-in user `system` of windows.  In order to read user Env Variables, user directory and other information during the Pipeline process,`the startUser of the system service needs to be changed to the signIn user` 

 execute the command `services.msc` to open the windows service Manage interface, and find the service `devops_agent_{agent_id}`(each agent\_id is different, and the value of agent\_id can be found in the setting file `.agent.properties`) 

 Right-click-&gt;Properties, and select `This account` in the signIn tab. 

 If the server is a domain agent, Fill In `domain name\username` for the account name; If there is no domain agent, Fill In `.\  username `, for example`.\  admin`、`.\  administrator`、`.\  bkci` 

 Input the password and click `Confirm` 

 ![bkci-hosted-windows-agent-3](../../../assets/bkci-hosted-windows-agent-3.png) 

 Right-click-&gt;Start Up, Restart service 

 ![bkci-hosted-windows-agent-4](../../../assets/bkci-hosted-windows-agent-4.png) 

 ## Checking status 

 Open Task management, view whether the processes devopsDaemon.exe and devopsAgent.exe exist, and check whether the Start Up username of the two processes is the current signIn user 

 ## Page import 

 click `reflash` on the build import page to see that the Agent status changes to `normal`. 

 ## Solution to Windows Agent Start Up Interface Program 

 BK-CI Self hosted agent windows agent is Start Up as system service by default. When starting a program with UI approve agent, an error will be reported or the interface will be invisible. 

 Cause: All processes Start Up by Windows Service Run in Session0, and Session0 Limit the pop-up of information windows, UI windows and other information to desktop user. 

 In this case, you can Start Up agent in One way, as follows: 

 1. If the agent has been install as a system service, execute uninstall.bat to uninstall agent service 
 2. Double-click devopsDaemon.exe to Start Up agent. Be careful not to close the pop-up window. 

 > The agent Start Up in this way has no boot function. 
 > 
 > After the agent execute the buildTask, it will auto pause all child processes Start Up by the agent. If you do No Need to end the child process, you can Set the Env Variables before starting the process: set DEVOPS\_DONT\_KILL\_PROCESS\_TREE=true 