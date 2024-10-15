# The operation process and logical relationship of the job template

The logic flow chart below shows in detail the logical relationship between job templates and execution plans, as well as the operation process information during job execution.

![Job template operation flow logic diagram](media/作业模板操作流程逻辑图.jpg)

A few more important key points:

- `debug` has a **strong sync** relationship with job templates
- Once the variable properties or step content of the template are modified, there will be differences with the execution plan, and synchronization is required to maintain consistency
- `force terminate` is for "whole task", not "single step"
- The variable value of the execution plan can be customized and will not change due to synchronization with the template
- In the manual confirmation step, only `confirmation person` can perform related operations