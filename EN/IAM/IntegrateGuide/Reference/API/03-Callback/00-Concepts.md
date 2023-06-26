# 名词及概念说明

## 1. 资源实例 Resource

- id：资源实例唯一标识，`需要保证对于一个系统同一种资源类型下id唯一`
- type: 资源类型的 ID，比如主机、集群、业务即 host、set、biz
- name: 资源实例名称，比如 192.168.1.1
- display_name: 资源实例展示名称，比如 大区 1(qq 大区)

## 2. 可用于配置权限的`属性`和`属性值`

可以使用资源属性配置权限, 例如用户 1 可以操作所有`os=linux`的主机;

为了实现这个功能, 需要从接入系统拉取可以配置权限的属性及属性值列表;

比如：在配置平台中，`主机`有属性`地区`，属性值, 枚举: 中国、美国、新加坡、日本等，则：
```bash
属性 id = "area"
属性 display_name = "地区"
属性值 id = "China"
属性值  display_name = "中国"
```

属性值 id 的类型支持 `string/int/bool`; 以配置平台主机属性为例：

```json
[string]
属性 id = "os"
属性 display_name = "操作系统"
属性值 id = "linux" 
属性值 display_name = "Linux" 

[int]
属性 id = "isp"
属性 display_name = "运营商"
属性值 id = 1 
属性值 display_name = "中国电信"

[bool]
属性 id = "is_public"
属性 display_name = "是否公共"
属性值 id = true
属性值 display_name = "是" 
```

## 3. 特殊属性：路径(path)属性说明
[说明: 资源拓扑`_bk_iam_path_`](../../../Explanation/04-BkIAMPath.md)
