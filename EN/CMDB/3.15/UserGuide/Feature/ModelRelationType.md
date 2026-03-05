 # link type 

 In general, model link in an enterprise can be Service Classification, for example the relationship between a network device and a Host is an association.  After Service Classification link, it is easier to create Revise model associations and Query similar associations. 

 Several link types are shipped as default: 

 - Belongs to: Starred connection to organization or Manage level 
 - Composition: Connection between equipment parts and the whole 
 - Topology composition: system built-in type, only used for node relationship of Business Topology, only used by system 
 - Run: The connection between a program and The operating system 
 - Uplink: Starred connection with network equipment 
 - Default link: Associations upgraded from a CMDB earlier than 3.2 will auto correspond to the default association 

 ![image-20220926221256322](media/image-20220926221256322.png) 
 <center>Figure 1. link type</center> 

 ## Add an link type 

 Enter the "model-link type" function click "add" to fill in the information related to the association type in the dialog box: 

 - Unique ID: English characters are recommended to be as short and Identify as possible. This ID is required for link import and API query 
 - name: The name presented to the user 
 - Source-&gt; target description: Description Display when the source instance view the relationship 
 - target-&gt; Source description: Description Display when the target instance view the relationship 
 - Direction: Whether the direction is Display in the view. The default is that the source points to target 

 ![image-20220926221443827](media/image-20220926221443827.png) 
 <center>Figure 2. add link type</center> 