 # The One Flow 

 > Flow orchestration is the core function of Standard OPS. approve visually dragging and arranging atomic Plugin with different functions on the canvas, system Workflow in different Scene can be realized. 

 # Standard OPS Flow 

 The operation step sorted out according to the actual operation Scene Operation are flexibly combined approve different flow logics (parallel, Branch, conditional parallel). 

 # Standard OPS Plugin 

 The smallest execute unit in Standard OPS. It is Two according to the Business Name logic of each ESB Components, and rich form interfaces and verification logic are added.  For example, a Script execute of One Job System, a New Cluster of a CMDB, and a emailNotice of PaaS. 

 Of course, in addition to the Standard Plugin packaged by the BlueKing system, you can Develop third-party plug-ins by yourself, such as an Operation atom of the company's internal system, an operation of the cloud Service, etc. 

 # Practical demonstration 

 Here's an example of the simplest Flow orchestration: execute One Script and then send a message notification. 

 ## 1. Create a add Flow 

 Under demo experience Business Name, Flow-add 

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103330/20044/20230506103330/--17c6a17ec2d0be50fafbfa82d5c7fa95.png)


 ## 2. Orchestration Flow In this process, we use One calling Job System to execute a Script, and then add a notification Node 

 Double-click Node to open the setting panel and Choose the Job System (JOB)-execute Plugin: 

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103354/20044/20230506103354/--60200f8039a3dfd8912b1f3408f49feb.png)

 Setting the One nodes 

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103407/20044/20230506103407/--9ac055edfe93580f27fe80de385569be.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103417/20044/20230506103417/--3e8d0947b273e0ca9d5ccd986f990e6e.png)

 Append One message notification Plugin. For quick Operation on the canvas, see [Quick Operations on Standard OPS Canvas (1)](https://bk.tencent.com/s-mart/community/question/10032)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103505/20044/20230506103505/--cf7438536cb4e7be9e0a8ccfcd6b016e.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103515/20044/20230506103515/--5333dc94a382d28a4c8c01496d4bc7d9.png)

 setting Message Notification node 

 ![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103528/20044/20230506103528/--4637a5e1e0a4190a828173444fc94775.png) 

 ## 3. New task 

 Flow is the template of Task. After the process is setting, you can New task execute 

 ![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103630/20044/20230506103630/--6110a74c01bdbe44c4ffd75b90c994f4.png) 

 ![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103637/20044/20230506103637/--cc725b56f1933ec9d107bf0335c135c2.png) 

 ## 4. Execute the Checks
 ![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103848/20044/20230506103848/--7f04a41c19e03db2ebc26e4c5a18dc01.png) 

 You can click the Node Check the pipelinesDetail, such as Script execution, or location to the Job System to view the detailed pipelinesHistory 

 ![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103907/20044/20230506103907/--2543ad3d20dfd2f82e53e96971f641ea.png) 

 view failed node 

 ![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103921/20044/20230506103921/--0cb887f892082ca31ed54ab5b49de7e6.png) 

 After resolving the Error, you can hover over the Failure Node, Click Retry, or select SKIP. 

 ![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103938/20044/20230506103938/--aa56e383120ebeb268233c717a23e48b.png) 

 edit Checks Parameter 

 ![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103954/20044/20230506103954/--9f844dc6791d2d55964f191087e4d750.png) 

 ![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506104000/20044/20230506104000/--da8ebf02678cbe7406d2a2e080430ca4.png) 

 More information 

 ![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506104014/20044/20230506104014/--3f2ca9f88858f7dea3ec72ec28963928.png) 

 The above demonstrates One simplest Flow orchestration without complex Branch flow logic. For more Advance process orchestration, please view [7.0 Product Feature Usage Series](bk.tencent.com/s-mart/community/question/9761?type=answer) Standard OPS part. 

 