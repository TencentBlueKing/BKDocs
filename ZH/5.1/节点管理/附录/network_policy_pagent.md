# P-Agent 与 Proxy 之间需要的网络策略


源地址|目标地址|协议|端口|用途
--|--|--|--|--
agent|proxy(gse_agent)|TCP|48533|任务服务端口
agent|proxy(gse_transit)|TCP|58625|数据上报端口
agent|proxy(gse_btsvr)|TCP|59173|bt传输
agent|proxy(gse_btsvr)|TCP,UDP|10020|bt传输
agent|proxy(gse_btsvr)|UDP|10030|bt传输
proxy(gse_btsvr)|agent|TCP,UDP|60020-60030|bt传输
agent|agent|TCP,UDP|60020-60030|bt传输(同一子网)
agent|||监听随机端口|bt传输，可不开通
