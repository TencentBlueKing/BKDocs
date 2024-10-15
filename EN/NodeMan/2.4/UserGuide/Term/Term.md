# Basic Concepts 

## BK-Net 

A group of server units that can communicate directly with each other, such as a local area network within an enterprise or a public cloud VPC (Virtual Private Cloud).

## Proxy 

Proxy probes for external communication in the BK-Net. In a BK-Net that is not directly connected, you need to install a proxy so that BlueKing can connect to CVMs in this region for control. For load balancer and disaster recovery, you can install multiple proxies in a BK-Net.

## Agent 

BlueKing Agent is a special program for communication between host and BlueKing. After installing BlueKing Agent on the CVM, you can control the CVM pass BlueKing, including file distribution, job execution, data reporting, and base information collections.

## Plugins 

A plugin is a subroutine or script that can be dispatched by the BlueKing Agent. You can customize plugins with specific functions pass get the plugins development framework, and deploy them to CVMs through NodeMan to expand more business name and enterprise management and control functions.

## Access Point 

The Agent establishes communication connection with BlueKing pass the access point, and the access point can directly issue management and control instructions, file distribution, etc. to the connected Agent. 

If your CVM resource span a large geographic area, you can deploy multiple access points in different regions to improve file transfer rates, reduce cross-region bandwidth costs, and reduce command latency.

Complete initial deployment of BlueKing will include a default access point.
