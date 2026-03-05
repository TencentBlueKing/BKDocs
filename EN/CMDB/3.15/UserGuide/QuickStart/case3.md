 # QuickStart model and Model Topology Manage 

 With the development of enterprises, CMDB will gradually assume more Basic Config responsibilities. The BlueKing CMDB provided dynamic expansion capabilities approve build the underlying "model" to help enterprises upgrade their CMDB capabilities online.  The following approve an example of how to Operation a Computer room: 

 Specific step: 

 **create Computer room model--Improve server room attributes--Improve link relationship--Create instance** 

 ## create a Computer room model 

 Some general model are built into the CMDB. When the existing models cannot meet the needs, you can add new models approve add models. 

 click add model/B in the upper left corner to open the dialog box for creating a new model, select the group to which it belongs, select the model icon (the icon can be customize later), Fill In the unique ID and name of the model, and finally click BSave/B to complete 

 ![image-20201105105142618](../media/case3/image-20201105105142618.png) 
 ![image-20201105105224370](../media/case3/image-20201105105224370.png) 


 "Unique ID" and "name" are Fill In to New: 

 **Unique ID**: It is the unique ID of model in the system and must be non-duplicate. 

 **name**: The description name that user can see in the product. 

 click Confirm to create the new model successfully.  The new model will have One default isRequired unique Field "Instance Name". user can Revise the chineseName of this field according to the actual positioning of the model, but the English Name cannot be adjusted because it is the unique identifier of the system bottom layer. 

 ![image-20201105105425125](../media/case3/image-20201105105425125.png) 

 In the actual Scene, we need to enrich more Field for the model approve click "add Field" to add more fields (you can import fields in batches. For more information, please see [exportPipelineJson and Import Model Fields](../Product Features/Model.md) section). 

 ![image-20201105105449717](../media/case3/image-20201105105449717.png) 

 Currently,"Short Character"(length 256 English),"Long Character"(length: 2000 English characters),"Number","Enumeration","List","date","time","Time zone","user","Boolean","Organization" and other type are supported. 

 user verification methods are supported according to the select Type: required "," Regular Validation "," gt less than lt range "and so on. 

 ![image-20201105105749968](../media/case3/image-20201105105749968.png) 



 ## Improving link Relationship 

 In order to enable Computer room to be link with the Host, we will setting the association relationship between the host and the server room. 

 Switch to the model link Tab page, and click add 

 ![image-20201105105907518](../media/case3/image-20201105105907518.png) 

 For the setting of link relationship, the core needs to analyze the relationship Limit between two Object. Since One Host can only belong to one physical Computer room, we configure the computer room as the source and the host as the target, and the constraint is set to 1-N: 

 ## create an Instance 

 complete above Operation, we have expanded the Manage capabilities of the Computer room for the CMDB, and then create the actual computer room record 

 On the resources page 

 ![image-20201105105950250](../media/case3/image-20201105105950250.png) 

 click add and Fill In the necessary attributes complete the create 

 ![image-20201105110132817](../media/case3/image-20201105110132817.png) 

 >Note: If you want to Batch Add., you can click "import" Enter the Import dialog box. If you are importing for the first time, you can download the instance Import template and edit it. 

 ![image-20201105110200939](../media/case3/image-20201105110200939.png) 

 link can open the detail of the newly create Computer room and switch to the Association options. You can see that the current server room is not associated with any Other instance. 

 create an link, click Association Manage, and the Host that can be associated current will be Display. Select Association. 

 ![image-20201105110511066](../media/case3/image-20201105110511066.png) 

 When complete, close this view to see link or topology. 

 ![image-20201105110540021](../media/case3/image-20201105110540021.png) 



 ![image-20201105110618098](../media/case3/image-20201105110618098.png) 