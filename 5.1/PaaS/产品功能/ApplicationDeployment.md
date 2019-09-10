### 基于 Virtualenv 的应用部署 {#ApplicationDeployment}

SaaS 部署时，平台为会它们创建独立的 Virtualenv，保证每个 SaaS 拥有一套“隔离”的 Python 运行环境。SaaS 的服务进程则是以 uWSGI 的 cheaper 模式托管，由于采用了 Busyness 算法，uWSGI 能够根据繁忙度，动态的调配 worker 个数，从而达到合理利用系统资源的目的。
