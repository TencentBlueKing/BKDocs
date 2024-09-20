 # Full Text Search 

 Full Text Search on the Home helps user search existing CMDB resources approve keywords. 

 ## Enable Original Text Search 

 By default, the Full Text Search function of CMDB is close, as shown in the following figure. Only the search function of the Host is enabled. 

 You can Revise the CMDB setting file and restart the process to enable Full Text Search. 

 ![image-20220510121057604](media/image-20220510121057604.png) 

 How to enable Full Text Search: 

 ```bash 
 Revise full_text_search = true under the [site] entry in common.conf 
 Then restart the process 
 ``` 

 enable Full Text Search As shown in the figure below, there will be One additional label to switch to full-text search. 

 ![image-20220510121145216](media/image-20220510121145216.png) 

 You can Input keywords to perform Fuzzy Search from All or specified model in the CMDB 

 ![image-20220510121318539](media/image-20220510121318539.png) 