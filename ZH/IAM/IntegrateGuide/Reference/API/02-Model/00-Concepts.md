# 名词及概念

说明: 1. 概念 2.限制(例如正则校验/非空/全局唯一等等)

> 所有更新(`PUT`)操作, 如果传了`key`并给了`空值`, 那么执行的是`置空操作`; 如果没有传`key`, 表示不更新该字段

## 1. System: 接入权限中心的 SaaS 或平台或第三方系统
- id: 系统的唯一标识，可直接使用 app_code 的值作为唯一标识，但 app_code 还用于接口的认证，值可以一样，但需支持 id 和 app_code 可单独配置不一样的，同时对于 cmdb 这种被依赖的系统，需要保证所有版本的系统 ID 都一样；只允许小写字母开头、包含小写字母、数字、下划线(_)和连接符(-)， 最长 32 个字符。
- name: 系统名称，注册时权限中心不允许与已存在系统同名
- name_en: 系统英文名，国际化时切换到英文版本显示
- description:  系统描述
- description_en: 系统描述描述英文, 国际化切换到英文版本展示
- clients： 有权限调用权限中心获取或操作该系统权限相关数据的客户端列表，即 app_code list，多个使用英文逗号分隔， 比如 BCS 由一个客户端 bk_bcs 注册，但是需要多个客户端（bk_bcs,bk_bcs_app,bk_devops,bk_harbor）都可以调用鉴权接口进行该系统的鉴权 
- provider_config.host：权限中心回调接入系统时需要的配置文件，权限中心需要调用接入系统拉取资源实例接口，所以需要接入系统 API 的 HOST, HOST 格式：scheme://netloc，与 resource_type.provider_config.path 配合使用. `例如system.provider_config.host=http://cmdb.consul, resource_type.provider_config.path=/api/v1/resources`, 那么将调用`http://cmdb.consul/api/v1/resources`去拉取该资源类型相关信息
- provider_config.auth: 权限中心调用接入系统吸取资源信息需要用的的接口鉴权方法, 目前支持`none/basic`, (`digest/signature`规划中), 接入系统需要实现相应的鉴权逻辑, 确保是合法的 iam 请求. [系统间调用接口鉴权:权限中心->接入系统](../01-Overview/03-APIAuth.md)
- provider_config.healthz: 权限中心调用接入系统的 healthz 检查系统是否健康; 与 provider_config.host 配合使用, `例如system.provider_config.host=http://cmdb.consul, provider_config.healthz=/healthz/`, 那么将调用`http://cmdb.consul/healthz/`检查系统是否健康. 

---

## 2. ResourceType: 操作对象的资源类别
- id: 资源类型的唯一标识，接入系统下唯一，只允许小写字母开头、包含小写字母、数字、下划线(_)和连接符(-)，最长 32 个字符。
- name: 资源类型名称，系统下唯一
- name_en:  资源类型英文名，国际化时切换到英文版本显示
- description: 资源类型描述
- description_en: 资源类型描述英文, 国际化切换到英文版本展示
- parents: 资源类型的直接上级，可多个直接上级，可以是自身系统的资源类型或其他系统的资源类型, 可为空列表，不允许重复，数据仅用于权限中心产品上显示  
- provider_config: 权限中心调用查询资源实例接口需要的配置文件，包括权限中心调用查询资源实例接口的 URL 的 path，与 system.provider_config.host 配合使用. `例如system.provider_config.host=http://cmdb.consul, resource_type.provider_config.path=/api/v1/resources`, 那么将调用`http://cmdb.consul/api/v1/resources`去拉取该资源类型相关信息

---

## 3. InstanceSelection: 实例视图

- id: 实例视图的唯一标识，接入系统下唯一，只允许小写字母开头、包含小写字母、数字、下划线(_)和连接符(-)，最长 32 个字符。
- name: 实例视图名称，系统下唯一
- name_en:  实例视图英文名，国际化时切换到英文版本显示
- resource_type_chain：实例视图包含的资源类型的层级链路
- is_dynamic：是否是动态拓扑视图，`默认为false`，如果是动态拓扑视图, 需要在`list_instance`中实现`child_type`来拉取到下一级的资源类型, [具体参考](../03-Callback/12-list_instance.md)
    - 使用动态拓扑视图的所有下级资源类型的系统 id 必须与 root 节点的系统 id 相同, 不能出现系统 id 不同的情况, 会导致配置出错误的权限
    - 使用动态拓扑视图时, 权限中心不会校验用户提交的数据是否与视图匹配, 并且在创建依赖操作时, 如果发现是动态拓扑视图, 不会产生依赖操作

---

## 4. Action: 权限操作，比如增删改查
- id: 操作的唯一标识，接入系统下唯一，只允许小写字母开头、包含小写字母、数字、下划线(_)和连接符(-)，最长 32 个字符。
- name: 操作名称，系统下唯一
- name_en:  操作英文名，国际化时切换到英文版本显示
- description: 操作描述
- description_en: 描述英文, 国际化切换到英文版本展示
- auth_type: 操作的授权类型，枚举值包括`abac\rbac`, 当前操作默认的操作类型为`abac`, 操作的鉴权方式走`abac`表达式计算, 如需使用`rbac`接入方式, 这里需要填写`rbac`, [具体参考](../../../Explanation/10-ActionAuthType.md)
- type: 操作的类型，枚举值包括`create\delete\view\edit\list\manage\execute` 比如创建类操作需要标识为"create"，无法分类可为空字符串，目前权限中心仅仅对创建类操作有相关处理
- related_actions: related_actions: 操作的依赖操作，当用户申请的操作权限必须依赖其他操作权限（暂不支持跨系统操作关联）时，比如用户申请 作业编辑，必须依赖 作业查看 的操作权限，作业查看 就是 作业编辑 的依赖操作。在产品层表现就是：当用户勾选 作业编辑 时，系统在创建申请单时，会自动申请 作业查看 权限。 
- related_resource_types： 操作的对象资源类型列表，列表顺序与产品展示、鉴权校验 顺序 必须保持一致 [产品说明: 依赖资源](../../../../1.8/UserGuide/Term/Trem.md#依赖资源)
    - system_id： 资源类型的来源系统，可以是自身系统或其他系统
    - scope：限制该操作对该资源的选择范围，条件表达式协议: [协议详情](../../Expression/01-Schema.md) [产品说明: 资源范围](../../../../1.8/UserGuide/Term/Trem.md#资源范围)
    - selection_mode: 选择类型, 即资源在权限中心产品上配置权限时的作用范围
        - 等于`instance`, 仅可选择实例, `默认值`
        - 等于`attribute`, 仅可配置属性, 此时`instance_selections`配置不生效
        - 等于`all`, 可以同时选择实例和配置属性
    - related_instance_selections：关联的实例视图，可以关联本系统定义的实例视图, 也可以配置其他系统定义的(如果`selection_mode=attribute`不用配置该字段). 该字段的功能表现在权限中心产品上配置权限时的实例选择方式 [产品说明: 实例选择视图](../../../../1.8/UserGuide/Term/Trem.md#实例视图)
        - system_id：实例视图的系统  
        - id：实例视图的 ID
        - ignore_iam_path：是否忽略路径，`默认为false`，在 IAM 产品上选择实例视图配置权限的资源时，**如果选到 Action 关联的资源类型实例，而不是上级或祖先（选择了中间节点，ignore_iam_path 是不起作用的）**，那么对于`ignore_iam_path=true`时权限保存类似：`id=192.168.1.1`，若`ignore_iam_path=false`时则权限保存类似：`id=192.168.1.1 AND _bk_iam_path_= /biz,1/set,2/module,3/`
            - ignore_iam_path 由 false 变更为 true 时，已配置的权限（类似：`id=192.168.1.1 AND _bk_iam_path_= /biz,1/set,2/module,3/`）将无法通过 id 直接通过鉴权
            - ignore_iam_path 由 true 变更为 false 时，已配置的权限（类似：`id=192.168.1.1`）无论任何路径都可以通过鉴权

---

## 5.版本号 version

- 仅仅作为在权限中心产品上进行 New 的更新提醒。[产品说明：版本号](../../../../1.8/UserGuide/Term/Trem.md#版本)
- 对于 ResourceType，对比该系统的所有 ResourceType 的 Version，最大的 version 将在产品上显示 New 的提示
- 对于 Action，对比该系统的所有 Action 的 Version，最大的 version 将在产品上显示 New 的提示
