 # Windows agent Start Up interface program solution 

 BK-CI thirdPartyBuildMachine windows agent is Start Up as a system service by default. When starting a program with UI approve the agent, an error will be reported or the interface will be invisible. 

 Cause: All processes Start Up by Windows Service Run in Session0, and Session0 Limit the pop-up of information windows, UI windows and other information to desktop user. 

 In this case, you can Start Up agent in One way, as follows: 

 1. If the agent has been install as a system service, execute uninstall.bat to uninstall agent service 
 2. Double-click devopsDaemon.exe to Start Up agent. Be careful not to close the pop-up window. 

 > The agent Start Up in this way has no boot function. 
 > 
 > After the agent execute the buildTask, it will auto pause all child processes Start Up by the agent. If you do No Need to end the child process, you can Set the Env Variables before starting the process: set DEVOPS\_DONT\_KILL\_PROCESS\_TREE=true 