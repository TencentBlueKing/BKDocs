# 使用场景相关

## 1. 怎么实现批量鉴权, 一个用户是否有查看 1000 台主机的权限 

- 调用策略查询`/api/v1/policy/query`接口
    - 传了 resource, 相当于权限中心会基于表达式做第一遍计算, 缩小策略数量
    - 不传 resource, 会把所有策略返回去
- 不传 resource, 获取得到所有策略
- 将 1000 台主机 for 循环逐一带入求值
- 此时, 相当于做一次策略查询, 执行 1000 次计算(内存表达式求值性能很高)

## 2. 配置权限的时候, 怎么控制只能选择实例, 不需要配置属性

action 操作注册时, `related_resource_types[i].selection_mode=instance`即可, 具体见文档  [操作(Action) API](../../../Reference/API/02-Model/13-Action.md)

如果只需要属性,  `selection_mode=attribute`; 如果两者都要`selection_mode=all`