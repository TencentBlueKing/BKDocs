# 命令字与变量在脚本插件中的应用

## 命令字执行时机

命令字在脚本插件所在的步骤运行完毕后，才进行计算、存储、传递。即当前脚本步骤中设置后，不会立即生效；若需生效请使用脚本语言本身的语法。

## 全局变量

设置后的全局变量，在下游步骤中通过 `{{ variables.xxx }}` 的方式引用。

### 设置/修改全局变量

```bash
::set-variable name=<var_name>::<var_value>
```

### 示例

```yaml
version: v3.0
on:
  push: 
    branches: [ "*" ]

variables:
  my_var: "[a, b, c, d]"
  my_const:
    value: my_const_value
    readonly: true

steps:
- checkout: self
- run: |
    echo "------"
    echo "before set: my_var is ${{ variables.my_var }}"
    echo "before set: my_const is ${{ variables.my_const }}"
    echo "::set-variable name=my_var::[a, b]"
    echo "::set-variable name=my_const::my_const_value_1"
- run: |
    echo "------"
    echo "after set: my_var is ${{ variables.my_var }}"
    echo "after set: my_const is ${{ variables.my_const }}"
```

## 步骤输出变量

设置后的步骤输出变量，在下游步骤中通过 `{{ steps.step_idxx.outputs.xxx }}` 的方式引用。

### 设置输出变量

```bash
::set-output name=<output_name>::<output_value>
```

### 示例

```yaml
version: v3.0
on:
  push: 
    branches: [ "*" ]

steps:
- checkout: self
- run: |
    echo "::set-output name=output_var_1::output_value_1"
  id: step_1
- run: |
    echo "output_var_1 is ${{ steps.step_1.outputs.output_var_1 }}"
```

## 产出构件与报告

### 产出构件

```bash
::set-output name=<file_var_name>,type=artifact::*.txt
```

### 产出报告

```bash
# 内置报告
::set-output name=<report_var_name>,type=report,label=<我是个内置报告>,path=<report_path>::<report_index_file>

# 第三方报告
::set-output name=<report_var_name>,type=report,label=<我是个第三方报告>,reportType=THIRDPARTY::<report_url>
```

## 质量红线指标值

```bash
::set-gate-value name=<indicator_name>::<indicator_value>
```

## 流水线备注

```bash
::set-remark xxx
```

若希望引用备注，可以通过 `{{ ci.remark }}` 的方式引用。

---

**注意**：

1. 只读的全局变量不能修改。
2. 设置的命令在当前 step 下不会生效，在下一个 step 才会生效。
3. `variables` 中的变量是全局变量，并发的 job 下设置同名变量会互相覆盖。
4. 可以在脚本任意位置申明输出，但当前 step 执行结束时，才会真正执行归档操作。
5. 内置报告将归档整个目录（`path` 指定的目录），需要将报告相关的内容放到一个单独的目录下，避免影响归档效率。
6. `set-gate-value` 和红线模板中的判断阈值类型要匹配，如比较阈值为 float 类型，`set` 指标值也要为 float 类型。
7. 同一项目下定义相同指标名，以后者定义的数值类型更新该指标。