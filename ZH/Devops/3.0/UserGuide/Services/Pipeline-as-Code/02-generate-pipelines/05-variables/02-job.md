# 在YAML文件中设置Job/Step环境变量

Job 和 Step 下，支持 env 关键字，可以通过此关键字设置环境变量

## 申明 env

环境变量，当前 job/step 下生效

值格式为：Object

命名规范：

- 由大写字母和下划线组成
- CI_ /BK_CI_为系统内置变量前缀，不建议自定义此前缀开头的环境变量

使用限制：

| 受限项 | 限制规则 |
| --- | --- |
| 环境变量个数 | 不超过 **20** 个 |
| 单变量 key 长度 | 不超过 **128** 字符 |
| 单变量值长度 | 不超过 **4k** 字符 |

示例：

```yaml
jobs:
linux_job:
    name: linux
    env:
      linux_a: 我是 linux job 上的 linux_a.
steps:
    - name: common trigger context
      run: |
echo \$linux_a = $linux_a
        echo envs.linux_a = ${{ envs.linux_a }}
```
- 在 job 上设置的环境变量，job 下的步骤中可以使用
- 在 step 上设置的环境变量，当前 step 可以使用
- job 和 step 上设置了同名环境变量时，以 step 上的设置为准
# 使用 env
在脚本文件/流水线中编写的脚本代码中，可以使用脚本语言支持的获取环境变量方式来读取，示例：
```shell
#!/bin/bash
# 环境变量（假设已设置 MY_ENV_VAR）
echo "环境变量: $MY_ENV_VAR"
```
```python
import os
# 获取自定义变量（未定义时返回默认值）
custom_var = os.getenv("MY_CUSTOM_VAR", "默认值")
print(f"MY_CUSTOM_VAR: {custom_var}")
```
在流水线中编写的脚本代码中，还可以使用上下文 envs 来读取，示例：
```shell
#!/bin/bash
# 环境变量（假设已设置 MY_ENV_VAR）
echo "环境变量: ${{ envs.MY_ENV_VAR }}"
```
