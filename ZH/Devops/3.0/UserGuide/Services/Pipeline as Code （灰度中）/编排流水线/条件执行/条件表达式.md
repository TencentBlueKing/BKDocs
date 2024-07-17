# 条件表达式

# 1.表达式功能描述

流水线编排过程中，通常在stage/job属性设置、step入参等位置通过表达式来引用上下文，参数化构建过程。
除此之外常见的场景是和 if 关键字一起组合使用来确定对应的 stage/job/step 是否运行。当  if 条件值为 true 时，运行对应的 stage/job/step。
 
表达式可以是文字值、上下文引用或函数的任意组合。流水线中，通过 ${{ <expression> }} 的方式申明表达式：
- <expression> 前后的空格可以省略，不影响计算后的值
- 在 if 关键字下，可以省略 ${{ }}。if 条件将自动作为表达式求值

 
if 条件示例：
	
 ```
- uses: gitbranchop@3.*
  name: 创建一个 git release
  if: variables.git_op_type == 'release'
```
 
插件入参中引用上下文的示例：
	
 ```
- run: |
      echo "hello ${{ ci.actor }}, ci.sha is ${{ ci.sha }}"

```
 
设置环境变量的示例：
	
 ```
env:
  MY_ENV_A: ${{ variables.a }}

```
	
# 2.字面量

表达式中支持的字面量类型如下：


| |
|:--|
|**类型** |**值** |**备注** |
|boolean |true / false | |
|null |null | |
|number |JSON 支持的任何数字格式 | |
|string |表达式中，常量字符串需使用**单引号''**包起来 |`不支持双引号` |

	
示例：
	
 ```
inputs:
  myNull: ${{ null }}
  myBoolean: ${{ false }}
  myIntegerNumber: ${{ 711 }}
  myFloatNumber: ${{ -9.2 }}
  myHexNumber: ${{ 0xff }}
  myExponentialNumber: ${{ -2.99e-2 }}
  myString: Mona the Octocat
  myStringInBraces: ${{ 'It''s open source!' }}

```
	
 
# 3.运算符

表达式中，支持如下运算符：


| |
|:--|
|**运算符** |**描述** |**备注** |
|() |逻辑运算 | |
|[ ] |数组索引 | |
|! |非 | |
|< |小于 | |
|<= |小于等于 | |
|> |大于 | |
|>= |大于等于 | |
|== |等于 | |
|!= |不等于 | |
|&& |与 | |
|  |或 | |
|. |属性访问 | |


在表达式计算时，进行宽松的等式比较：
- 一个 NaN 与另一个 NaN 的比较不会产生 true，更多信息请参阅“[NaN Mozilla 文档](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/NaN)”
- 比较字符串时，**区分**大小写
- 当类型不匹配时，将强制转换类型为 number：


| |
|:--|
|**类型** |**结果** |**备注** |
|null |0 | |
|boolean |true 返回 1<br>false 返回 0 | |
|string |Parsed from any legal JSON number format, otherwise NaN.<br>Note: empty string returns 0 | |
|arrar |NaN | |
|object |NaN | |

 
注：目前流水线变量值仅支持 string 类型，针对变量值为 true 和 false 的场景(其他按照上表中 string 统一处理)， 表达式场景下系统自动适配为boolean，无需用户进行显式类型转换，示例：
	
 ```
if: steps.step_2.outputs.var_1 == true
```
 
# 4.函数

系统提供了一系列内置函数，可以在表达式中使用。
	
## 4.1 contains(search, item)

当 search 中包含 item 时，返回 true。此函数不区分大小写。
- 当 search 类型为 array 时，若 item 为其中的元素，则返回 true
- 当 search 类型为 string 时，若 item 为 search 的子字符串，则返回 true

## 4.2 startsWith(searchString, searchValue)

当 searchString 以 searchValue 开头时返回 true，此函数不区分大小写。
	
## 4.3 endsWith(searchString, searchValue)

当 searchAtring 以 searchValue 结尾时返回 true，此函数不区分大小写。
	
## 4.4 join(array, separator=",")

使用分隔符 separator 将数组 array 中的所有元素组合为一个字符串。
separator 可以缺省，缺省值为英文逗号(,)。
	
## 4.5 fromJSON(string)

返回 json 对象，或 值
示例1：
	
 ```
variables:
  continue: true
  time: 3
   
jobs:
  job1:
    runs-on: docker
    steps:
    - continue-on-error: ${{ fromJSON(variables.continue) }}
      timeout-minutes: ${{ fromJSON(variables.time) }}
      run: echo ...

```
 
示例2：
	
 ```
variables:
  continue: true
  time: 3
   
jobs:
  job1:
    runs-on: docker
    steps:
    - continue-on-error: ${{ fromJSON(variables.continue) }}
      timeout-minutes: ${{ fromJSON(variables.time) }}
      run: echo ...

```