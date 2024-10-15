 # MetaData Specification 

 ## What is metaData 

 Just like photos have resolution, shooting location, file size, artifact also have their own label, we call this kind of tag "metaData", BK-Repo provided a powerful metadata filter function, approve reasonable metadata specification, you can easily get compliant products. 

 ## What metaData does an artifact need? 

 metaData KEY| metaData Value| Comment 
 -- | -- | -- 
 pipeline_id | p-xxxxxx |Create the pipelineId corresponding to this artifact. 
 build_id | b-xxxxxx | 

 ## Writing a metaData filter 

 Currently one set of key/value scripts is supported: 

 `key:value`. 