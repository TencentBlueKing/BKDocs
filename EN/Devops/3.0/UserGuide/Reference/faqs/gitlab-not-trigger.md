# The gitlab event trigger plugin cannot trigger events?

1. Check whether the pipeline is registered in the devops\_ci\_process.T\_PIPELINE\_WEBHOOK table, SELECT \* FROM devops\_ci\_process.T\_PIPELINE\_WEBHOOK WHERE pipeline\_id = ${pipeline\_id}, ${pipeline\_id} can be obtained from the url address
2. If not registered
    1. Check whether the network from the repository service to gitlba can be communicated
    2. Check whether the permissions of the gitlab warehouse are master permissions
    3. On the machine where the repository service is deployed, execute grep "Start to add the web hook of " $BK\_HOME/logs/ci/repository/repository-devops.log to find the reason for the registration failure. The default value of $BK\_HOME is /data /bkce
3. If it is registered but still not triggered,
    1. Go to the webhook page of gitlab to check whether the registration is successful, as shown in Figure 1
    2. If there is a registered url in gitlab, the url is [http://domainname/external/scm/codegit/commit](http://domainname/external/scm/codegit/commit) and then click Edit to view the sending details , as shown in Figure 2
    3. View the details not sent by gitlab, as shown in Figure 3
4. If there is no problem with the above, on the machine where the process service is deployed, execute grep "Trigger gitlab build" $BK\_HOME/logs/ci/process/process-devops.log to search the log and find the triggered entry log

![](../../assets/image%20%2858%29%20%281%29.png)

![](../../assets/image%20%2859%29.png)

![](../../assets/image%20%2857%29.png)