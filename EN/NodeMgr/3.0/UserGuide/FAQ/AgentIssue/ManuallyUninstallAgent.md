# Manually Uninstall Agent

Under normal circumstances, prefer the "Uninstall" function on the Node Manager page. When an uninstall task misbehaves and manual cleanup is needed, refer to the following steps.

> The paths below use the default deployment configuration as an example: on Linux the installation directory is `/usr/local/<env>/` (`<env>` is the GSE environment identifier in the backend configuration, e.g. `gse2`) and the working directory is `/tmp/bknm/`; on Windows the installation directory defaults to the corresponding directory under `C:\`. Actual paths are subject to the `baseDeployDir` / `baseWorkDir` configuration in `gseDeployConfs` at deployment time.

## Manually Uninstall Agent on Linux

1. Perform "Remove Agent" on the Node Manager page.

2. Delete the host in CMDB (if you need to reinstall the Agent under the same business, deletion is optional: move the host to idle hosts → move to the host pool, then switch to the host pool and delete it).

3. Stop the processes:

```bash
/usr/local/<env>/bin/gsectl stop
```

4. Delete the directories (subject to the actual installation directory):

```bash
rm -rf /run/<env>
rm -rf /var/lib/<env>
rm -rf /var/log/<env>
rm -rf /usr/local/<env>
rm -rf /tmp/bknm
```

## Manually Uninstall Agent on Windows

1. Perform "Remove Agent" on the Node Manager page.

2. Delete the host in CMDB (same as above; optional if reinstalling under the same business).

3. Stop the service:

```bat
cd c:\<env>\agent\bin
gsectl.bat stop
```

4. Delete the installation and working directories (default `C:\<env>` and `C:\tmp\bknm`, subject to the actual deployment configuration).
