# Terminology

- **Access System**: BKFlow is a process engine platform designed for platforms. Systems that create processes and tasks through API calls are called access systems.

- **Access System Developer**: Developers of BKFlow access systems and users of BKFlow need to understand the relevant concepts of BKFlow and access and configure it, and have all resource management permissions for the corresponding space.

- **Access System User**: Users of BKFlow access systems can operate directly based on the functions provided by the access system or the embedded canvas without being aware of the existence of BKFlow, without having to understand the concept of BKFlow.

- **Space**: The concept of business isolation in BKFlow, and data in different spaces are not interoperable. It is created and managed by the developer of the access system, and needs to be bound to the APP_CODE of the access system. It is recommended that each access system corresponds to only one space.

- **Space Administrator**: Administrator of the BKFlow space, has all resource management permissions for the corresponding space, and the space creator becomes the space administrator by default.

- **Space configuration**: Configuration of BKFlow space, including gateway expression, canvas mode, space administrator and other configurations.

- **Process/Process template**: In BKFlow, the predefined operation process of each basic scenario is a process, and the process is a template for creating tasks.

- **Task/Task instance**: In BKFlow, we can create a task based on a process. Each task is a real business scenario job, and the task can be paused and forced to terminate.

- **Sequence flow**: Sequence flow is a directed line segment used to connect two nodes in BKFlow, which identifies the execution direction of the task process.

- **Node**: A process execution unit in BKFlow, including process control nodes and task nodes. When executing a task, each node will have the status of not executed, executing, successful execution, and failed execution.

- **Process control node**: A type of node in BKFlow, which does not contain specific execution logic itself, but is only used to control the execution process of the task process. For example, the start node identifies the start of the task process, and the gateway node controls the start and end of the parallel process and branch process.

- **Gateway nodes**: including parallel gateways, branch gateways and convergence gateways, used to control the start and end of parallel and branch processes.

- **Parallel gateway**: used to mark the start of a parallel process. By pairing with a convergence gateway, multiple nodes can be controlled to execute in parallel.

- **Branch gateway**: used to mark the start of a branch process. By pairing with a convergence gateway, one of the multiple branches can be dynamically controlled to execute according to the calculation result of the branch expression.

- **Convergence gateway**: used to mark the end of a parallel process or a branch process. It is recommended that each branch gateway and parallel gateway be configured with a corresponding convergence gateway. Please note that branch processes can be embedded in parallel processes in BKFlow, and parallel processes can also be embedded in branch processes. Please make sure that the convergence gateway corresponds to the parallel gateway or branch gateway one by one, and there should be no cross-embedding or unpairing.

- **Task node**: The task node is a specific logical unit for BKFlow task execution. Each task node includes basic information, input parameters and output parameters. The output parameters can be used to check the generation of global variables, and the input parameters can also reference global variables to simplify user input.

- **Plugins**: The business logic encapsulation executed by the task node in BKFlow is called a plug-in, which includes built-in plug-ins, API plug-ins and BlueKing plug-ins.

- **Built-in plug-ins**: The public business logic encapsulation provided by BKFlow by default, including plug-ins such as pause, timing, message display, approval, and decision.

- **API plug-ins**: BKFlow provides plug-ins that allow access system developers to customize business logic. Access system developers can implement customized business logic by exposing interfaces of specific protocols, and generate corresponding plug-ins in BKFlow for access system users to use.

- **BlueKing plug-in**: BKFlow is connected to the BlueKing plug-in service. Access system developers or users can customize plug-ins based on the BlueKing Developer Center and use them in BKFlow.

- **Global variables**: Global variables are public parameters of a process template, and are uniquely constrained by KEY. Users can reference them in the input parameters of the task node and the branch gateway expression. BKFlow will automatically replace the reference to the global variable with the value of the global variable when executing the task.