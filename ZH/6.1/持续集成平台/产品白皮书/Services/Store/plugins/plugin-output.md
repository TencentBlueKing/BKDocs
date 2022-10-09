# 插件输出规范

* 插件执行完毕后，支持输出变量传递给流水线下游步骤使用，或者归档文件到仓库、归档报告到产出物报告
* 输出信息由写文件的方式指定，文件路径和名称由系统定义的环境变量指定
* 输出信息格式详细说明如下：

```text
{
    "status": "",      # 插件执行结果，值可以为success、failure
    "message": "",     # 插件执行结果说明，支持markdown格式
    "errorType": 3,    # 插件错误类型，int, 1表示是用户用法（参数不合法等等），2表示依赖的第三方平台问题，3表示是插件逻辑问题
    "errorCode": 0,    # 插件错误码，int，用于后续根据错误码分析插件质量
    "type": "default", # 产出数据模板类型，用于规定产出数据的解析入库方式。目前支持default
    "data": {          # default模板的数据格式如下所示，各输出字段应先在task.json中定义
        "outVar_1": {
            "type": "string",
            "value": "testaaaaa"
        },
        "outVar_2": {
            "type": "artifact",
            "value": ["file_path_1", "file_path_2"] # 文件绝对路径，指定后，agent自动将这些文件归档到仓库
        },
        "outVar_3": {
            "type": "report",
            "reportType": "", # 报告类型 INTERNAL 内置报告， THIRDPARTY 第三方链接， 默认为INTERNAL
            "label": "",      # 报告别名，用于产出物报告界面标识当前报告
            "path": "",       # reportType=INTERNAL时，报告目录所在绝对路径。注意规划报告路径，目录下的所有内容将视为报告关联文件一起存档
            "target": "",     # reportType=INTERNAL时，报告入口文件名称
            "url": ""         # reportType=THIRDPARTY时，报告链接，当报告可以通过url访问时使用
        }
    }
}
```

* 产出 data 中的数据类型支持三类：
  * string：字符串
    * 长度不能超过 4k 字符
  * artifact：构件
    * 支持多个构件
    * 每个构件指定本地绝对路径
  * report：报告
    * 报告有两种类型：内置报告、第三方链接
    * 报告文件不建议直接放在根目录下，如果根目录下其他文件，如代码库之类的，会把所有文件都当作报告的相关文件上传。 建议创建个目录来存，比如，path=${{WORKSPACE}}/report， target=result\_report.html

