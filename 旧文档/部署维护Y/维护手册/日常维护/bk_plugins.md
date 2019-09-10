### 蓝鲸组件{#bk_plugins}

- License: `/data/bkce/license/license/bin/license.sh start`

- JOB: `/data/bkce/job/job/bin/job.sh start`

- APPO / APPT : 从/data/bkce/paas_agent/apps/Envs/\* 下遍历 workon home ，然后使用 `apps` 用户调用 supervisord 拉起进程。
