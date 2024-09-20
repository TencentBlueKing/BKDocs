 # Business Topology 

 Business Topology is the Base for CMDB for Host Manage. today, as business architecture and type become more and more complex, only by establishing an appropriate business model can we manage hosts in a structured manner.  CMDB provided user structure customize, topology attribute customization and other functions. 

 ## Create Topology 

 By default, the Business Topology only contains idle module. You can create a topology structure that Meets The Scene approve click the add function at the right back of the business.  The meaning of the default "Business Name-module" three-level topology structure is as follows: 

 - Set (SET): a Deploy plate with relatively complete functions, with strong internal coupling and weak external coupling.  that is, there are few dependency between Set, and that failure of One clust does not affect the normal Run of Other clusters 
 - Module: One complete service module, for example a web module, a database module, etc.  module can further definition the service instance, process resources 

 We provided Set template and service template allocation to facilitate user to quickly create clusters and module. For detail view Service Template and Cluster Template.  For Set and module without special rules, You can choose not to create using templates. Subsequent maintenance is complete approve manual adjusting each level node. 

 ![1579158593792](../media/1579158593792.png) 
 <center>Figure 1. create a Topology</center> 

 ## Customize Levels 

 In addition to the two-level structure included system default, user can definition more levels in model Relationship according to the actual needs of the enterprise. 