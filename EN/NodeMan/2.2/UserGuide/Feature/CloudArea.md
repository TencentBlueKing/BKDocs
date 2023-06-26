# Cloud Area Manage 

A cloud area is a group of server units that can communicate directly with each other, such as a local area network within an enterprise or a public cloud VPC (Virtual Private Cloud). 

When BlueKing is initially deployed, a "direct mode" is created by default. When the host can directly communicate with the network where BlueKing is deployed, the agent is installed in this zone. 

If the enterprise network is divided into regions, such as the isolation between the office network and the production network, the isolation between the head office and the branch network, and the isolation between the domestic service network and the foreign service network, multiple cloud areas can be created according to the actual network connectivity planning. 

## Viewing Cloud Area 

Click "Cloud Area Manage" to view the existing cloud areas. The initial deployment of BlueKing is complete, and this list is empty. It is important to note that cloud area viewing requires authorization.

![-w2020](media/20200604101308.png)

## Create a Cloud Area 

**Step 1: Create a Cloud Area.** 

On the Cloud Area Manage page, click "New" to create a new cloud region. Explanation of cloud area parameters: 
- Cloud Area Name: the unique ID of the cloud zone. In BlueKing, this name must be unique 
- Cloud Service Provider: This is used to identify the provider of the current network. For enterprise private cloud, select Enterprise Private Cloud. For the network provided by public cloud, BlueKing has provided a list of common domestic and foreign vendors for selection by default. 
- Access Point: When there are multiple access points in Global Setting, you can define which access point is used to communicate with BlueKing in the current cloud area. 

![-w2020](media/20200604100613.png)

**Step 2: "Continue to Install Proxy" will be prompted after success submission.** 

Since the customized cloud area is isolated from the network, you cannot continue to install the agent under it before installing the proxy. Therefore, it is recommended to select "Continue to Install Proxy" to configure the proxy. 
If you do not have the network or CVM resource ready for the proxy, you can install the proxy in the Cloud Area Manage at any time. 

![-w2020](media/20200604100832.png)

**Step 3: Enter Proxy Install Parameters**

Detail of the parameters required for install are explained below: 

- LAN IP: The IP that can communicate with the agent on the network 
- External communication IP: The IP that can communicate with the access point 
- Login IP: The IP of the proxy host that can be SSH logged in from BlueKing. This is an optional configuration. If it is not entered, the private IP will be used by default. 
- Authentication method: Supports password or key 
- Operation system: The host used as a proxy must be a 64-bit Linux system 
- Login port: The port where SSH connections can be made 
- Login account: It is recommended to use the root account. If you cannot use the root account, you must enter the account to execute the /tmp/setup_agent.sh script without secret. 
- Attributed Business Name: Used to define which business is entered into the BlueKing Configuration System after the proxy is installed. Please note that you must get the business name permissions of BlueKing Configuration System to perform this action 

![-w2020](media/20200604100902.png) 

## Proxy Query 

After the cloud area complete install, click the cloud region title to view the proxy detail under the cloud region. 

![-w2020](media/20200604104408.png) 

If you have not installed a proxy before, you can click New to continue installing a proxy. 
If a proxy already exists, you can decide whether to install multiple proxies according to the actual needs of your enterprise to achieve higher availability and load balancer requirements. 

![-w2020](media/20200604104513.png) 

## Uninstalling Proxy 

To uninstall the proxy of a cloud area, click the name of the cloud region to view the existing proxies. 
Before uninstalling, you need to confirm that the current proxy has no agent connected to it. Failure to do so will result in failure. 

## Delete a Cloud Area 

Before deleting a cloud area, you need to confirm that the proxy in the current cloud region has been completely uninstalled.