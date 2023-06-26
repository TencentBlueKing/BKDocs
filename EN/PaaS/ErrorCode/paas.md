# PaaS3.0 平台错误码

请参考：[PaaS3.0 平台错误码](../DevelopTools/DevGuideV3/BaseGuide/faq/error_code.md)

# PaaS2.0 平台错误码

|错误码|错误码标志|错误码含义|处理方案|
|--|--|--|--|
|1301000|E1301000_DEFAULT_CODE|默认错误码|根据日志中异常堆栈信息处理|
|1301001|E1301001_BASE_SETTINGS_ERROR|配置文件中配置项不正确|根据错误日志确认对应配置项是否配置/配置是否正确|
|1301002|E1301002_BASE_DATABASE_ERROR|数据库访问存在问题|确认配置的数据库连接正常且库和表都存在|
|1301003|E1301003_BASE_HTTP_DEPENDENCE_ERROR|第三方 HTTP 依赖存在问题|根据错误日志检查对应配置的依赖服务访问正常|
|1301004|E1301004_BASE_REDIS_ERROR|依赖的 Redis 存在问题|确认配置的 redis 服务访问正常|
|1301005|E1301005_BASE_PAASAGENT_ERROR|当前没有注册并激活的 PaaSAgent 服务器|注册并激活测试/正式服务器|
|1301006|E1301006_BASE_RABBITMQ_ERROR|未注册并激活 RabbitMQ 服务|注册并激活 rabbitmq 集群|
|1301007|E1301007_BASE_BKSUITE_DATABASE_ERROR|无法连接并访问 bksuite 数据库|确认 bksuite 数据库已新建|
|1301008|E1301008_BASE_APPENGINE_ERROR|App Engine 未正常启动或 App Engine 接口异常|确认 AppEngine 进程存在且接口正常/接口异常则排查 AppEngine 日志|
|1301100|E1301100_PAASAGENT_COMMIT_TEST_DEPLOYMENT_FAIL|测试部署事件提交失败|请确认 appengine 服务正常[/v1/healthz/]|
|1301101|E1301101_PAASAGENT_COMMIT_PROD_DEPLOYMENT_FAIL|正式部署事件提交失败|请确认 appengine 服务正常[/v1/healthz/]|
|1301102|E1301102_PAASAGENT_NOT_INSTALLED|服务器上未安装 Agent|请安装 Agent 后重试|
|1301103|E1301103_PAASAGENT_NOT_HEALTH|PaasAgent 激活失败|请确认对应机器上未安装 PaaSAgent/PaaSAgent 正常启动(日志默认在 ${BK_HOME}/logs/paas_agent/agent.log)|
|1301200|E1301200_DEPENDENCE_REDIS_ERROR|访问 redis 失败|请确认配置文件中 redis 配置正确且对应 redis 服务可用|
|1301300|E1301300_APP_SAAS_UPLOAD_FAIL|SaaS 上传文件失败|请确认 ${BK_HOME}/open_paas/paas/media 路径 NFS 配置正确且权限正常(目录可读写)|
|1302000|E1302000_DEFAULT_CODE|默认错误码|根据日志中异常堆栈信息处理|
|1302001|E1302001_BASE_SETTINGS_ERROR|配置文件中配置项不正确|根据错误日志确认对应配置项是否配置/配置是否正确|
|1302002|E1302002_BASE_DATABASE_ERROR|数据库访问存在问题|确认配置的数据库连接正常且库和表都存在|
|1302003|E1302003_BASE_HTTP_DEPENDENCE_ERROR|第三方 HTTP 依赖存在问题|根据错误日志检查对应配置的依赖服务访问正常|
|1302004|E1302004_BASE_BKSUITE_DATABASE_ERROR|无法连接并访问 bksuite 数据库|确认 bksuite 数据库已新建|
|1302005|E1302005_BASE_LICENSE_ERROR|登录接口依赖的证书服务存在问题|确认是否添加了证书，配置的证书服务是否访问正常|
|1303000|E1303000_DEFAULT_CODE|默认错误码|根据日志中异常堆栈信息处理|
|1303001|E1303001_BASE_SETTINGS_ERROR|配置文件中配置项不正确|根据错误日志确认对应配置项是否配置/配置是否正确|
|1303002|E1303002_BASE_DATABASE_ERROR|数据库访问存在问题|确认配置的数据库连接正常且库和表都存在|
|1303003|E1303003_BASE_HTTP_DEPENDENCE_ERROR|第三方 HTTP 依赖存在问题|根据错误日志检查对应配置的依赖服务访问正常|
|1303004|E1303004_BASE_BKSUITE_DATABASE_ERROR|无法连接并访问 bksuite 数据库|确认 bksuite 数据库已新建|
|1303005|E1303005_BASE_LICENSE_ERROR|登录接口依赖的证书服务存在问题|确认是否添加了证书，配置的证书服务是否访问正常|
|1303100|E1303100_DESKTOP_USER_APP_LOAD_ERROR|加载用户桌面应用出错|请查看日志中异常堆栈信息处理|
|1303101|E1303101_MARKET_APP_QUERY_FAIL|应用市场查询应用失败|请查看日志中异常堆栈信息处理|
|1303102|E1303102_MARKET_APP_DETAIL_QUERY_FAIL|应用市场应用详情查询失败|请查看日志中异常堆栈信息处理|
|1303200|E1303200_WEIXIN_HTTP_GET_REQUEST_ERROR|请求微信 GET 接口出错|请检查微信组件配置是否正确以及 console 模块所在服务器是否有外网能正确请求微信提供的 API|
|1303201|E1303201_WEIXIN_HTTP_POST_REQUEST_ERROR|请求微信 POST 接口出错|请检查微信组件配置是否正确以及 console 模块所在服务器是否有外网能正确请求微信提供的 API|
|1303202|E1303202_WEIXIN_MP_EVENT_PUSH_RESPONSE_ERROR|微信公众号推送事件响应出错|请检查公网上的微信服务器能请求到 console 模块所在服务器，同时检查微信公众号上服务器配置是否正确，以及查看日志中异常堆栈信息来处理|
|1304000|E1304000_DEFAULT_CODE|默认错误码|-|
|1304001|E1304001_DATABASE_ERROR|数据库访问异常|检查数据连接是否正常|
|1304101|E1304101_PAASAGENT_ERROR|paasagent 通用错误|根据日志中异常堆栈信息处理|
|1304102|E1304102_PAASAGENT_INACTIVEATED_ERROR|paasagent 未激活|检查 app 的测试和正式服务器是否都已经注册并激活|
|1304103|E1304103_PAASAGENT_UNAUTHORIZED_ERROR|paasagent 未授权|检查相应服务器的 sid 和 token 是否配置正确|
|1304104|E1304104_PAASAGENT_NOTSTARTED_ERROR|paasagent 未启动成功|确保 paas 能够访问 paasagent 机器，并且检查 paasagent 是否启动成功，如果启动失败，查看 agent 的异常日志定位问题|
|1304201|E1304201_RABBITMQ_ERROR|rabbitmq 通用错误，跟进日志中异常堆栈信息处理|
|1304202|E1304202_RABBITMQ_INACTIVEATED_ERROR|rabbitmq 未注册并激活|检查 rabbitmq 集群是否已经注册并激活|
|1304203|E1304203_RABBITMQ_UNAUTHORIZED_ERROR|rabbitmq 授权信息异常|检查管理员账户名和密码是否正确|
|1304301|E1304301_ASSIGN_SERVER_ERROR|部署时分配服务器异常|检查服务器是否已经注册并激活|
|1304302|E1304302_ASSIGN_PORT_ERROR|部署时分配 port 端口异常|跟进日志堆栈信息处理|
|1305000|E1305000_DEFAULT_CODE|默认错误码|-|
|1305101|E1305101_LICENSE_INVALID|证书无效|检查证书是否放到指定目录并且证书有效|
|1305102|E1305102_TOKEN_INVALID|sid 和 token 异常|检查 agent 服务器配置的 sid 和 token 是否和 paas 中注册的一致|
|1305103|E1305103_PAAS_UNREACHABLE|paas 接口不可达|检查 agent 服务器到 paas 服务器的网络是否可达(包括域名配置是否正确)|
|1305104|E1305104_PORT_ERROR|部署时分配 port 接口异常|通常可忽略该错误|
|1306000|_|组件默认错误码|组件系统默认错误码，需根据错误消息排查原因|
|1306001|_|redis 连接失败|查 redis 配置是否正确，服务是否正常|
|1306101|_|组件代码逻辑错误，无法加载|根据异常信息，检查代码逻辑，排除异常|
|1306102|_|组件通道中的组件配置，不是一个有效的 JSON 字符串|检查组件配置，JSON 字符串需要是一个 dict，或者可以转化为 dict 的列表|
|1306201|_|请求第三方系统接口出现异常|检查第三方系统接口服务是否正常|
|1306202|_|第三方系统接口返回数据不是一个有效的 JSON 字符串|检查第三方系统接口服务是否正常|
|1306203|_|请求第三方系统接口出现 SSLError|检查组件配置中 SSL_ROOT_DIR 对应的文件夹是否存在，及其下的证书是否过期|
|1306204|_|访问系统 GSE 的接口出现错误|检查 GSE 系统接口服务是否正常|
|1306205|_|访问 SMTP 邮箱服务出现错误|检查发送邮件组件 SMTP 配置是否正确，及 SMTP 邮箱服务是否正常|
|1306206|_|组件不支持访问第三方系统测试环境|联系组件开发者确认是否能够支持，或切换访问第三方接口正式环境|
|1306208|_|第三方系统接口返回未知格式数据|联系组件开发者确认，第三方系统接口协议是否变更|
|1306209|_|第三方系统接口不支持请求方法|联系组件开发者确认，组件配置是否正确|
|1306401|_|未指定当前用户|检查请求参数中是否包含 bk_token 或 bk_username，二者至少一个有效|
|1306402|_|用户权限不足|用户没有权限访问配置平台业务数据，需将用户添加到业务运维或其他角色|
|1306403|_|应用权限不足|应用没有权限访问当前 API，请到开发者中心申请 API 权限，并联系 API 网关管理员审批|
|1306404|_|未找到组件类|需联系组件开发者，确认该组件服务是否正常|
|1306405|_|组件通道未开启|需联系组件开发者，确认该组件是否开启，如需开启，请在组件通道管理中修改配置|
|1306406|_|参数错误|参数错误，请参考组件文档，修改请求参数|
|1306407|_|第三方接口地址格式化失败|接口地址中包含路径变量，请参考组件文档，检查请求组件的地址是否合法|
|1306429|_|访问组件频率超限|组件设置了访问频率控制，APP 访问组件的频率超过了 |
