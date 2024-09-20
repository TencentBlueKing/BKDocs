 # Host Auto-apply

 Mainly used to setting the auto Apply of Host attributes.  That is, when a Host is transferred or a new module is added, the host attribute will be auto triggered to be modified according to the Alert Rules of the target module. 

 ## Enable auto Apply 

 Enter "Host Auto-apply", select the module to be setting (idle machine or Normal business module can be selected), click "Enable Immediately" on the Right. 

 ![image-20220923211100647](media/image-20220923211100647.png) 
 <center>Figure 1: Enable auto Apply</center> 

 There are two step to Start Up an auto Apply. 

 ### Step One: setting the attributes of auto Apply 

 ![image-20220923211146521](media/image-20220923211146521.png) 
 <center>Figure 2: select the properties that need to be setting auto Apply</center> 

 ![image-20220923211243351](media/image-20220923211243351.png) 
 <center>Figure 3: setting auto Apply Properties</center> 

 ### Step Two: Revise the existing Host attributes to auto Serving Config 

 This step will set the attributes of all Host in the current module to be consistent with the setting attributes. The list Display which host attributes need to be Revise. 

 It should be noted that the Alert Rules can only be save after the Two step execute complete, and the setting of the logout policy will be discarded. 

 ![image-20220923211446597](media/image-20220923211446597.png) 
 <center>Figure 4: Apply to an Existing Host</center> 

 ![image-20220923211513773](media/image-20220923211513773.png) 
 <center>Figure 5: Alert Rules successfullySaved</center> 

 After the auto Apply Rule Configuration is Success, when the Host is new to the current module, the configured attributes will be automatically applied (in this The Case, the main principal and backup responsible person will be set to admin). 

 ## Close auto Apply 

 When the auto Alert Rules is Take Effect, you can see One green checkmark behind the corresponding module in the topology on the left. 

 When the module no longer needs the auto feature, click the corresponding module in the topology tree, and then click close. 

 ![image-20220923211615201](media/image-20220923211615201.png) 
 <center>Figure 6: close auto Apply</center> 

 At this time, One prompt box will pop up, asking whether to save the current configItem. If it is only temporarily close, you can select to save it, and then Enable it when it needs to be Apply. The previously configured attributes do No Need to be selected and Fill In in repeatedly.  If you no longer need to setting, select not to save, and then enable again next time to configure from scratch. 

 When auto Apply is close, the Host properties of the existing current module will not be changed. 

 In addition, in the close status, no matter whether the previous setting is save or not, the Host moves into the current module, and the properties do not change. 

 ![image-20220923211636822](media/image-20220923211636822.png) 
 <center>Figure 7: close auto Apply Confirm</center> 

 ## Advanced Usage: setting auto Apply by Service Template 

 We have described how to setting auto Apply rules approve `Business Topology`. The difference between `configuration by service template` and `configuration by business topology` is as follows: The former is Apply to the instance level of topology node, while the latter (by Service Template) is One dynamic setting mode for all node instances Generate by The service template. We Recommended that user use templates to standardize and manage Business setting, whether topology or Host attributes. 

 ![image-20220923212354549](media/image-20220923212354549.png) 

 The following figure Display the module node link with The Service Template (`Apache` in the example), and the rule is Apply to all of them: 

 ![image-20220923212700532](media/image-20220923212700532.png) 