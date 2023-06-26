# devops\_ci\_image

**数据库名：** devops\_ci\_image

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_image的数据库文档

|                     表名                     |  说明 |
| :----------------------------------------: | :-: |
| [T\_UPLOAD\_IMAGE\_TASK](broken-reference) |     |

**表名：** T\_UPLOAD\_IMAGE\_TASK

**说明：**

**数据列：**

|  序号 |       名称      |    数据类型   |     长度     | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-----------: | :-------: | :--------: | :-: | :--: | :-: | :-: | :--: |
|  1  |    TASK\_ID   |  varchar  |     128    |  0  |   N  |  Y  |     | 任务ID |
|  2  |  PROJECT\_ID  |  varchar  |     128    |  0  |   N  |  N  |     | 项目ID |
|  3  |    OPERATOR   |  varchar  |     128    |  0  |   N  |  N  |     |  操作员 |
|  4  | CREATED\_TIME | timestamp |     19     |  0  |   Y  |  N  |     | 创建时间 |
|  5  | UPDATED\_TIME | timestamp |     19     |  0  |   Y  |  N  |     | 修改时间 |
|  6  |  TASK\_STATUS |  varchar  |     32     |  0  |   N  |  N  |     | 任务状态 |
|  7  | TASK\_MESSAGE |  varchar  |     256    |  0  |   Y  |  N  |     | 任务消息 |
|  8  |  IMAGE\_DATA  |  longtext | 2147483647 |  0  |   Y  |  N  |     | 镜像列表 |
