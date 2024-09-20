### Linux Manual Uninstallation of Agent
1、NodeMan - Remove agent 

![](../assets/001.png)

2、Go to CMDB and remove the host (you can leave it off if you need to reinstall the agent and it is installed under the same business)

3、Stop process
```bash
  /usr/local/gse/bin/gsectl stop
```
4、Remove work directory.
```bash
rm -rf /run/gse
rm -rf /var/lib/gse
rm -rf /var/log/gse
rm -rf /use/local/gse
```
<br/>

### Windows Manual Uninstallation of Agent

1、NodeMan - Remove agent 

![](../assets/001.png)

2、Go to CMDB and remove the host (you can leave it off if you need to reinstall the agent and it is installed under the same business)

3、Stop process
```bash
cd c:\gse\agent\bin
gsectl.bat stop
```

![16530466032174](../assets/16530466032174.png)


4、Remove work directory.

![](../assets/1653046582122.png)