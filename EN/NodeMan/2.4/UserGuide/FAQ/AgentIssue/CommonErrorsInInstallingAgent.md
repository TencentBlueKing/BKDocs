
# Common installation errors of Agent
## Common error 1: UTF-8 issue during Agent installation
- Product version: 2.0.927
- Error message:
```bash
[2022-03-30 16:08:57 ERROR] Traceback (most recent call last):
  File "/data/bkce/bknodemandeman/apps/backend/utils/ssh.py", line 445, in send_cmd
UnicodeDecodeError: 'utf-8' codec can't decode byte 0xba in position 450: invalid start byte
During handling of the above exception, another exception occurred:
```
![](../assets/002.png)

**Solution:**
[https://bk.tencent.com/s-mart/community/question/7033](https://bk.tencent.com/s-mart/community/question/7033)

## Common error 2: Failure in deploying plugin program and issuing installation package
```bash
[2022 06-15 16:20:58 ERROR] [processbeat] Failed to deploy plugin program and issue installation package,[basereport] Failed to deploy plugin program and issue installation package,[exceptionbeat] Failed to deploy plugin program and issue installation package ➊[2022- 06-15 16:20:58 ERROR] Failed to install preset plugin. Please try to check the log and handle it. Contact the administrator if you cannot resolve it.
```
![](../assets/003.png)

**Solution:**
[https://bk.tencent.com/s-mart/community/question/8142](https://bk.tencent.com/s-mart/community/question/8142)
