 # Standard Develop Plugin specification 

 - The group naming rule is "system name (system englishName)", such as: Job System (JOB). 
 - The Standard Plugin code is underlined, and the rule is "system name_interface name", for example: job_execute_task。 
 - The backend class name is camel-shaped, and the rule is "Standard Plugin code + inherited class name", such as: JobExecuteTaskService。 
 - The front-end JS file directory shall be consistent with the system name abbreviation, and the JS fileName shall be consistent with the Standard Plugin coding. 
 - The Parameter tag_code naming rule is "system name_Name", which can ensure global uniqueness; length not exceed 20 characters. 