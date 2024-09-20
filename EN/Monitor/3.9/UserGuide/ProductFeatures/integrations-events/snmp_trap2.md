# snmp trap usage instructions



## **⼀1. snmp trap reporting process**



1. The monitoring platform delivers the trap server (implemented as the trap task of bkmonitorbeat) to the designated machine and monitors the trap port.
2. The user configures the device that needs to be monitored and reports the trap message to the trap server.

3. The trap server parses the report, converts the data format into custom event format data that can be recognized by monitoring, and reports it to the monitoring link. For details, please refer to the figure below:



![](media/16612336066249.jpg)




## **2. Snmp trap task delivery process**



### **1. Generate snmp.yml**



Use the generator tool provided by monitoring and combine it with the mib library file provided by the user to generate the snmp.yml file. In the MIBDIRS environment variable, fill in the folder where the user stores the mib library. Use multiple mib folders: segmentation



```
export MIBDIRS=mibs:/usr/local/share/snmp/mibs:/usr/share/snmp/mibs .
/generator all

```


Example of the obtained snmp.yml content:


```
basic_name:
   metrics:
   - name: etherRateControlGroup
     oid: 1.3.6.1.2.1.35.2.1.15
     type: OBJGROUP
     help: ""
   - name: netSnmpDomains
     oid: 1.3.6.1.4.1.8072.3.3
     type: OTHER
     help: ""
    
```



### **2. Add additional snmp.yml configuration**



For example: If the user needs to pay attention to the oid 1.3.6.1.2.1.2333 and the group of oids 1.3.6.1.2.1.2334.1~10, he needs to manually configure additional report_oid_dimensions in snmp.yml:



Note that a "." must be added in front of oid. This is caused by the underlying implementation.


```
 
basic_name:
   report_oid_dimensions: [".1.3.6.1.2.1.2333",".1.3.6.1.2.1.2334"]
   metrics:
   - name: etherRateControlGroup
     oid: 1.3.6.1.2.1.35.2.1.15
     type: OBJGROUP
     help: ""
   - name: netSnmpDomains
     oid: 1.3.6.1.4.1.8072.3.3
     type: OTHER
     help: ""
```



If there is a scenario where a large number of oid indexes need to report dimensions, the snmp.yml configuration requires additional processing.



For example: Customers need to pay attention to 200,000-level oids such as 1.3.6.1.2.1.2334.1 ~ 1.3.6.1.2.1.2334.200000. If the above writing method is used at this time, there will be too many oid dimensions and the es data cannot be entered into the database. , which leads to the problem of event loss. A special writing method needs to be used here, that is, adding **.index** at the end of oid:


```
 
basic_name:
   report_oid_dimensions: [".1.3.6.1.2.1.2333",".1.3.6.1.2.1.2334.index"]
   metrics:
   - name: etherRateControlGroup
     oid: 1.3.6.1.2.1.35.2.1.15
     type: OBJGROUP
     help: ""
   - name: netSnmpDomains
     oid: 1.3.6.1.4.1.8072.3.3
     type: OTHER
     help: ""
```




At this time, the dimension name corresponding to the oid will be reported as the part in front of the index, and the value of the dimension will be spliced in the form of {oid_index}::::{value}. For example: The name of the oid reported by the user is .1.3.6.1.2.1 .2334.333, the value is test1, then the actual reported dimension name is .1.3.6.1.2.1.2334, the value is



333::::test1



The screenshot of the effect is roughly as follows:



![](media/16612337982102.jpg)



Note: Since there can only be one same dimension name in a single event, this solution is **not applicable** to scenarios where the same prefix oid index appears in a **single** event at the same time. For example: .1.3. is reported at the same time. 6.1.2.1.2334.1 and .1.3.6.1.2.1.2334.2 scenarios, using this solution will cause dimension loss



### **3. Configure and distribute collection tasks**



On the monitoring collection and delivery page, configure the snmp_trap task parameters, upload snmp.yml, and then click Next to select a machine to deliver the trap server



![](media/16612338940177.jpg)


### **4. Observation data reporting**



You can observe the data reporting status of this task through data retrieval:


![](media/16612339210562.jpg)


### **5. Policy configuration**



Note: Based on the field discovery mechanism of custom events, when the trap event data is reported for the first time (the data can be seen on the view), the oid dimension is often not found, and you need to wait 5-10 minutes for the data to be retrieved via the link. The field discovery function is automatically added to the Saas dimension list. Based on this feature, the policy configuration of the trap task needs to be processed after a period of time after the trap task is reported.



Configure the trap alarm for this task on the policy page




![](media/16612339577609.jpg)



## **3. Additional configuration related**



### **1. Turn on the dimension translation switch**



By default, the oid dimension reported by trap will be reported in the original oid form, such as oid dimension key such as 1_3_6_1_2_1_35_2_1_15. Users may want to obtain the translated oid English name in the dimension, such as etherRateControlGroup



At this time, you need to perform the following two steps:



1. Turn on the translate switch on the admin page



Address: `{paas}/o/bk_monitorv3/admin/bkmonitor/globalconfig/?is_advanced__exact=1`



Configuration name: TRANSLATE_SNMP_TRAP_DIMENSIONS



As shown in the figure, you need to change this item to true



![](media/16612339896078.jpg)




2. Resend the trap task



Just re-issue the trap task by adding or deleting targets.

### **2.oid value Chinese character encoding processing**



If the value of oid in the user trap event is Chinese using a special encoding format (such as gbk), since the default encoding format of Chinese characters processed by the trap server is utf8, the Chinese characters reported by the trap server will become garbled. Users need to manually add a configuration encode in the snmp.yml configuration:



```
 
basic_name:
   encode: gbk
   metrics:
   - name: etherRateControlGroup
     oid: 1.3.6.1.2.1.35.2.1.15
     type: OBJGROUP
     help: ""
   - name: netSnmpDomains
     oid: 1.3.6.1.4.1.8072.3.3
     type: OTHER
     help: ""
```



Note: Based on current scenario considerations, only gbk encoding is currently supported.



Note 2: If you do not use gbk, you need to delete the entire encode parameter and do not leave any blank parameters like encode:



### **3.raw byte type oid processing**



Under normal circumstances, when the trap server obtains the oid value in byte array format, it will try to transcode it into readable characters. However, there are data in special scenarios where the meaning of the value is the byte itself. In this case, it should not be transcoded. In this scenario, the user needs to manually add a configuration raw_byte_oids in the snmp.yml configuration:



At this time, the oid 1.3.6.1.2.333.4 will not be attempted to be transcoded into readable characters, but will be reported in byte array form.



```
basic_name:
   raw_byte_oids: [".1.3.6.1.2.333.4"]
   metrics:
   - name: dot1dStpBridgeGroup
     oid: 1.3.6.1.2.1.17.8.1.3
     type: OBJGROUP
     help: ""
   - name: hrDeviceProcessor
     oid: 1.3.6.1.2.1.25.3.1.3
     type: OBJIDENTITY
     help: ""
```



## **4. Trap task parameter description**

The snmp authentication information is defined by the customer device and then filled in the monitoring collection configuration.
The two protocol authentications of snmpv1/v2 have only one field, namely community, which is translated as community name in Chinese.

Note 1: snmptrap uses the community name as a filtering measure for trap data, so it can be left blank. If not filled in, it will be regarded as receiving traps from all groups. **Multiple community names that need to be filtered can be separated by commas**
Note 2: In the example below, if a column is empty, it means that it is usually not filled in</p>|


|**Name**|**Usage**|**Example**|**Use snmp version**|
|---|---|---|---|

|community|snmp v1,v2’s unique authentication information|public|v1,v2|

|Security name|Username for snmpv3|admin|v3|

|Context name|View name of snmpv3||v3|

|Security level|Security type of snmpv3, select |authPriv|v3| through the drop-down list

|Authentication protocol|snmpv3 authentication protocol, select |SHA|v3| from the drop-down list

|Verification password|Password corresponding to snmpv3 authentication protocol|12345678|v3|

|Privacy Agreement|snmpv3 Privacy Agreement, select |DES|v3| through the drop-down list

|Private key|Password corresponding to snmpv3 privacy protocol|12345678|v3|

|Device ID|snmpV3 device ID, the corresponding device needs to provide |810.0.0.110.0.0.1400|v3|



## **5. Problem Troubleshooting**

### **1.snmp.yml generated result is empty**

It is usually caused by the missing mib library. You can use the following command to observe the results:


`./generator parse_error`


### **2.trap task always has no data**

1. Go to the trap server machine, open the /usr/local/gse/plugins/etc/bkmonitorbeat/xxxx_snmptrap_xxxx.conf file, and check its dataid
2. Using this dataid, there is no data checking process and no data checking document:



## **6. Precautions**



### **1. Dimension oid configuration restrictions**



When supplementing the report_oid_dimensions configuration, you need to control the number of reported oid dimensions. Do not add too much oid information to the dimensions. Too many oid dimensions will cause an error in the total fields limit written by es, resulting in only part of the trap event data being able to be written. es



### **2.Query Limitation**



Do not use dimensions whose dimension values are not enumerable or whose number is too large as query conditions.



For example: trap fixes the reported dimension agent_port. This value is a random value and will produce a dimension magnitude of 1-6w. Configuring this dimension as a query condition may cause the query es to return a "create too many buckets" error and result in no data in the query. In the same way, this condition should not be used as a monitoring dimension when configuring alarms to prevent alarm background query failure resulting in no alarms.




## Related documents

SNMP indicator plug-in production [View document](../integrations-metric-plugins/plugin_snmp.md)