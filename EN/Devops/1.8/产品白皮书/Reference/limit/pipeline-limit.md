# 流水线复杂度限制

* 每个Pipeline最多包含30个Stage
* 每个Stage最多包含30个Job
* 每个Job最多包含50个Task
* 每个Task最多包含150个输入参数、100个输出参数
* 每个输入参数也有对应的大小限制

| 组件类型 | 大小限制 |
| :--- | :--- |
| input | 1KB |
| checkbox | 1KB |
| textarea | 16KB |
| code\_editor | 16KB |

* 每个输出参数最多4KB大小

