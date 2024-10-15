# Component monitoring failed to start Exporter, fail to restart process

## Problem Description

![-w2021](../media/15366475980839.png)

## Troubleshooting method

1. Enter the job platform, open the "Execution History" page, filter the task list according to the conditions in the red box, filter out tasks close to the component delivery time, and click "View Details"

![-w2021](../media/15366476048793.png)

2. After entering the task details, view the step details. Record component name and script parameters

![Image description](../media/tapd_20365752_base64_1536201059_26.png)

3. Use job or log in to the target machine and execute the script

Assume that the component name is `oracle_exporter` and the script parameters are `--port=1521 --host=10.0.0.1`

```bash
cd /usr/local/gse/external_collector/oracle_exporter
./oracle_exporter --port=1521 --host=10.0.0.1
```

Then solve the problem based on the specific error message

- The port is occupied: Exporter has been started, just kill the process and re-issue it.
- For oracle components, it is usually due to the lack of `libclntsh.so` library