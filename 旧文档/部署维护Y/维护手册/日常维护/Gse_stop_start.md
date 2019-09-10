### GSE 启停方法{#Gse_stop_start}

GSE 组件分为 GSE 后台，GSE 客户端，GSE 插件，分别对应三个不同的启停进程：

- GSE 后台服务端： `/data/bkce/gse/server/bin/gsectl [start|stop|restart] <module>`

- GSE 客户端（Agent）:  `/usr/local/gse/agent/bin/gsectl [start|stop|restart]``

- GSE 插件进程（plugin）： `/usr/local/gse/plugins/bin/{stop,start,restart}.sh <module>`
