 # Host your agent to BK-CI 

 In addition to Run Pipeline using BK-CI's built-in public buildResource, you can also host your own build resources to BK-CI in the form of a Self hosted agent. Build resources support macOS, Windows, and Linux. 
 > Before hosting Please First prepare the execute environment: [Self hosted agent environment preparation](prepara-agent.md) 

 import method: On the service-Pools-node page, click Import Self hosted agent in the upper right corner: 

 ![Resource](../../assets/resource_2.png) 

 According to the pop-up: 

 1. select the system of the machine, and the installCommand and installation method are different for different The operating system (for windows, please refer to [import Windows agent](self-hosted-agents/windows-agent.md)); 
 2. copy the command to RUNNING and execute The in the target workspace of your agent to download and install the Agent 
 3. After install the Agent, clickToRefresh to refresh the node, and then Import. 

 ## Next you may need 

 - [agent detail Page](./agent-detail.md) 