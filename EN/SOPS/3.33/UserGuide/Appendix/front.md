 # Standard Plugin Front-End Develop 

 Created the test directory under the custom_atoms/static/custom_atoms directory, and create the test_custom.js file. Note that the file path is consistent with the form definition by the Standard Plugin backend.  Registers the Standard Plugin Frontend Config approve $.atoms, where each item means: 
 - test_custom： Standard Plugin background definition code 
 - tag_code: Parameter code, which should be globally unique. The naming standard is "system name_Name" 
 - type: front-end form Type, optional input, textarea, radio, checkbox, select, datetime, datatable, upload, combine, etc. 
 - attrs: attribute Set corresponding to type, such as name and validation 

 ![-w2020](../assets/38.png) 