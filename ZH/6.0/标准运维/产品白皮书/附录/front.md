# 标准插件前端开发

在 custom_atoms/static/custom_atoms 目录下创建 test 目录，并创建 test_custom.js 文件，注意文件路径和标准插件后台定义的 form 保持一致。通过 $.atoms 注册标准插件前端配置，其中各项含义是：
- test_custom：标准插件后台定义的 code
- tag_code：参数 code，请保持全局唯一，命名规范为 “系统名_参数名”
- type：前端表单类型，可选 input、textarea、radio、checkbox、select、datetime、datatable、upload、combine 等
- attrs：对应 type 的属性设置，如 name、validation

![-w2020](../assets/38.png)
