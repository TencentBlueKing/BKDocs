# 使用研发商店中的插件 uses
​
## 关键字 uses
​
指定当前 step 使用的流水线插件标识和版本
值格式为：<atomCode>@<atomVersion>
<atomCode> 为插件标识，<atomVersion> 为插件对应的版本，支持设置始终使用指定大版本下的最新版本，如1.*
支持的插件有：
- 从[蓝盾研发商店](http://devops.oa.com/console/store/market/home?pipeType=atom)上架的插件
- 不包括：
    - 蓝盾很早以前的旧版插件，这些插件目前已设置为不推荐使用
​
 
可以在[蓝盾研发商店](https://devops.woa.com/console/store/market/list)中查看每个插件的 YAML 片段示例
示例：

 ```
- uses: UploadArtifactory@4.*
  name: 归档构件
  with:
    # 待归档的文件, 必选
    filePath: string
    # 无标题, 必选, 默认: pipeline, 可选项: 流水线仓库[pipeline] | 自定义仓库[custom]
    repoName: string
    # 归档至父流水线, 默认: false, 当 [repoName] = [pipeline] 时必选
    isParentPipeline: boolean
    # 无标题, 默认: ./, 当 [repoName] = [custom] 时必选
    destPath: string
    # 需要输出下载链接的文件
    downloadFiles: string
    # 自定义元数据
    metadata: string
    # 启用增量上传, 默认: false
    enableIncrementalUpload: boolean
    # 启用MD5校验, 默认: false
    enableMD5Checksum: boolean
    # 启用制品扫描, 默认: false
    enableScan: boolean
    # 无标题, 默认: ASYNC, 当 [enableScan] = [true] 时必选, 可选项: 同步执行扫描[SYNC] | 异步执行扫描[ASYNC]
    scanTaskType: string
​
``` 
    