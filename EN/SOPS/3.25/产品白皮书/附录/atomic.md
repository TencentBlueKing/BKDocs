# 标准插件后台开发

在 custom_atoms/components/collections 目录下创建 test.py 文件，其中需要定义的属性和类如下所示。

![-w2020](../assets/34.png)

test.py 属性详解：
- **__group_name__** ：标准插件所属分类（一般是对应 API 的系统简称，如配置平台(CC)）
- class TestCustomService(Service)：标准插件后台执行逻辑
- **__need_schedule__** = True：是否是异步执行，默认为 False
- interval = StaticIntervalGenerator(5)：异步标准插件的轮询策略
- def execute：前端参数获取、API 参数组装、结果解析、结果输出
- def schedule：轮询逻辑、结果输出
- def outputs_format：输出参数格式化
- class TestCustomComponent(Component)：标准插件定义
- name： 标准插件名称
- code：唯一编码
- bound_service：绑定后台服务
- form：前端表单定义文件路径  

TestCustomService 中 execute 函数详解：
- 可以是任何 Python 代码，如果对应于 ESB API 调用，一般分为参数组装、API 调用、结果解析。
- data 是标准插件前端数据，对应于前端的表单，可以用 get_one_of_inputs 获取某一个参数；执行完成可以使用 set_outputs 写入返回值和异常信息(ex_data)。
- parent_data 是任务的公共参数，包括 excutor—执行者，operator—操作员，biz_cc_id—所属业务 ID。详细请查看 gcloud/taskflow3/utils.py。
- 返回 True 表示标准插件执行成功，False 表示执行失败。

![-w2020](../assets/35.png)

TestCustomService 中 execute 函数详解：
- 返回列表格式。
- 列表格式的每一项定义一个返回字段，是 execute 函数中的 set_outputs 输出的字段的子集；key—输出字段标识，name—输出字段含义，type—输出字段类型（str、int 等 Python 数据结构）。

![-w2020](../assets/36.png)

TestCustomService 中 shedule 函数详解：
- 由 interval 控制调用策略，如 pipeline.core.flow.activity.StaticIntervalGenerator（每隔多少秒轮询一次）、DefaultIntervalGenerator（每次轮询间隔时间是上一次的两倍）。
- 使用 self.finish_schedule 结束轮询。
- 返回 True 表示标准插件执行成功，False 表示执行失败。

![-w2020](../assets/37.png)
