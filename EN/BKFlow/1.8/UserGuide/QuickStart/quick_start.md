# Quick Start

> Here is how to quickly create your own space in BKFlow and complete the experience of related functions as a space administrator for a user who has never used or connected to BKFlow. For the system access process, please refer to the [System Access](../SystemAccess/system_access.md) document.

## Create a space

Click [Experience Now] on the project homepage.

![Experience Now](assets/homepage.png)

Fill in the corresponding information and click Submit to create a space. BKFlow will automatically add you as the administrator of the space.

![Create a New Space](assets/space_create.png)

## Space Configuration

You can configure the space. The configurable items include space administrator, canvas mode, gateway expression, etc. These configurations will take effect on the entire space.

![Space Configuration](assets/space_config.png)

## Process Management

Space administrators can view and filter the process list.

![Process List](assets/template_list.png)

You can create and edit process templates directly on the Admin management end.

![Process Edit](assets/template_edit.png)

Click the [Debug] button, the process template supports configuring Mock data schemes as node outputs and performing debugging.

![Process Debug](assets/debug_mock.png)

![Process Debug](assets/mock_params.png)

Click the [Execute] button to create and execute a debugging task. You can see that the [Pause] node is executed in MOCK mode.

![Debug Task](assets/mock_task.png)

## Task Management

Space administrators can view and filter task and debugging task lists.

![Task List](assets/task_list.png)

## Rule Decision Management

Space administrators can directly create a new decision table and associate a process template, and edit the input and output field configuration of the decision table.

![dmn](assets/dmn_field.png)

By configuring rules, you can get a decision table.

![dmn](assets/dmn_detail.png)

Directly debug rule decisions based on the Admin management end.

![dmn](assets/dmn_debug.png)

Associate the decision table in the process and execute it.

![dmn](assets/dmn_in_template.png)

## System Management

If you are a system administrator of BKFlow, you can also configure and manage spaces and modules on the Admin management end.

Space configuration can view and configure all space information.

Module configuration can configure the mapping relationship between space and task execution module.

![system_admin](assets/system_admin.png)