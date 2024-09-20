## Log extraction issues QA
Q: Can the preview function directly browse/filter logs?
A: BKLog itself has a log retrieval function (ES), and the Tencent version is open to developers. It is recommended that logs be connected to BKLog log retrieval first. It supports real-time query/context/real-time log and other query methods. Files such as corefile can be extracted through logs. download. Used in combination, efficiency can be significantly improved.
![QA_1.png](../media/QA_1.png)

Q; I don’t have permission to develop feedback from classmates.
![QA_2.png](../media/QA_2.png)
A: Operation and maintenance students need to authorize the user first, management--log extraction configuration--user list

Q: Tips on job_api permission issues:
![QA_3.png](../media/QA_3.png)
A: In the new version of log extraction, files are viewed/distributed through the job platform to execute commands, so the execution role needs to have corresponding permissions. The current default is to take the first person in the operation and maintenance role as the executor (Management--User Group Configuration--Operation Maintenance personnel), if the user does not have corresponding business job permissions, an error will be reported. Adjustment method: Management--Log extraction configuration--Edit--Change to me, modify the default executor.

Q: Selecting a server takes a long time. About 5-10 minutes, and may fail
A: Check the configuration of log extraction, Manage--Log Extraction Configuration--Edit--Authorization Target, and check whether the number of authorization targets is too many. If the entire business is authorized, only one node in the top-level directory of the business can be selected for authorization.
![QA_4.png](../media/QA_4.png)