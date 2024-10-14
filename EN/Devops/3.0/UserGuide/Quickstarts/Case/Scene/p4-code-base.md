 # Integrate P4 Code Repository 


 ## Keywords: P4, event Trigger, Code Pull 

 ## Business Name Challenges 

 Perforce is One very good commercial Version Management tool, especially for large file management such as art resources, and is sought after by many project.  If the project using P4 cannot be connected with DevOps tools, it will greatly affect the Efficiency of CI. 

 ## Advantages of BK-CI 

 For Business Name that use P4 as a Code repository, you can use the official P4 Plugin of BK-CI. 

 ## Solution 

 event Trigger: 

 Some Business Name that use P4 as Code repository hope to trigger the auto execute of BK-CI Pipeline when some P4 event occur. current BK-CI supports "P4 event triggering" and can capture 5 events: "change commit","change content","change submit","shelve commit" and "shelve submit"; 

 ![&#x56FE;1](../../../assets/scene-p4-code-base-a.png) 

 Code Pull: 

 auto Pull of event Code. This Plugin supports both Stream and Manual type. 

 ![&#x56FE;1](../../../assets/scene-p4-code-base-b.png) 