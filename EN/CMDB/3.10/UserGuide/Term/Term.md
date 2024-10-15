 # Term 


 - **Business Name**: It can be understood as a project and is the Base Object of the BlueKing CMDB. It can definition the division of business Role (such as product, Test, Develop, and OPS) and the Life Cycle of the business.  In the Job System, monitoring, Standard OPS system, all operate on the Base of existing Business Name. 

 - **Set**: Used to distinguish different environment of One Business Name or multiple Deploy gateway of the same environment.  Common definition are, According to the envType: Formal Set and Test cluster.  Divided According to gateway: East China and Northern Region. 

 - **module**: A module is the smallest unit of Business Name topology Manage. It is usually used to identify One Collection of fixed processes, such for example database, DR, Login, and Web. 

 - **Idle machine**: By default, the Business Name allocated approve resources pool are placed in the idle machine module, which is defined as the unused Host resources. 

 - **Failed machine**: When a Host is found to be abnormal in actual Apply, it is recommended to transfer it to the "Failed machine" module for identification. After repair, it can be transferred to an idle machine or divided into Business Name modules. 

 - **Cloud area**: A cloud region is a logical division of Host intranet. CVMs across cloud regions cannot access each other directly approve private networks, and the IPs can be duplicate.  The default Host belongs to a directly connected gateway. 

 - **model**: A model is a standard format definition for setting instances of the same type. for example different configuration records are required for Host and Computer room: Host need to include Asset ID, Computer room data centers need to include ISP information. You can definition two model, namely, CVMs and data centers, to ensure that the required information Must be included when relevant setting are entered into the CMDB.  In addition to the attribute list, the model can also definition uniqueness Check, link, etc. 

 - **model group**: Model grouping can help classify models for easy Query and understanding. for example, switches, routers and hardware firewalls are usually grouped into network equipment groups. 

 - **link type**: Service Classification of model association relationship. For example, the relationship between Host and switch or route can be classified as "uplink", and the relationship between software and host is "Run". 

 - **model link**: definition the associability between models. 

 - **link**: Instance association refers to the association between instances. for example Host is "connected" to One switch.  In a CMDB, this relationship can be visualized as a mesh. 

 - **Instance**: Also called setting instance, each meaningful record subject in CMDB is One configuration instance, for example a switch, a Host, etc. 

 - **dynamicGroup**: Dynamic grouping is mainly used to definition Starred condition Query. When using Job System or Standard OPS, you can quickly Search target Host based on dynamic grouping. 

 - **event Push**: Event push mainly refers to the Real time notification to the link system when the Basic Info changed.  Currently, Push setting According to model Service Classification is supported. 