## 蓝鲸日常维护

### 全站 HTTP 切换 HTTPS

- 修改 globale.env 中的 HTTP_SCHEMA='https'。

- 修改完成后按如下命令顺序执行。

- 全站 https 切换 http ，只需要修改 globale.env 中的 HTTP_SCHEMA='http' 即可，然后执行相同步骤即可

```bash
./bkcec sync common
./bkcec install nginx
./bkcec stop nginx
./bkcec start nginx
echo  job cmdb paas  | xargs -n 1 ./bkcec stop
echo  job cmdb paas  | xargs -n 1 ./bkcec render
echo  job cmdb paas  | xargs -n 1 ./bkcec start
echo  job cmdb paas  | xargs -n 1 ./bkcec status
```