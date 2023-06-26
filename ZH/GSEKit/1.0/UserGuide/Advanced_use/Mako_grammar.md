进程配置管理 使用 [Mako](http://www.makotemplates.org/) 模板引擎渲染配置文件，借助模板引擎，我们可以在利用变量、循环逻辑以及条件判断逻辑来简化配置文件管理工作。

### 变量替换

Mako 中最简单的语法便是变量替换，语法结构为${}，和 Bash 中的变量替换一致，但有所区别的是大括号不可省略

```bash
bind_addr = ${ InnerIP }   # 大括号与变量名之间可以有任意多个空格，但不能换行
```

以上代码中，InnerIP 是一个 进程配置管理 提供的全局变量，它将被替换为配置文件实例所在服务器的内网 IP 地址，如10.0.0.1
如果您引用的变量不存在，将会产生异常并显示这个不存在的变量名。

### 表达式语句

在变量替换中您可以使用 Python 表达式语句，比如四则运算：

```bash
<%
BasePort = 8000
%>
BindPort = ${ BasePort + InstID }

# 如上，在配置文件中得到的结果将是：
# BindPort = 8002
```

简单的条件判断表达式也是被支持的：

```bash
# 如果 SetName（集群名） 等于 aqq 或者 iqq，则值为 1，否则为 0
is_qq_or_wx = ${ 1 if SetName in ("aqq", "iqq") else 0  }
```

您也可以在表达式中使用部分 Python 的内置函数：
```bash
# 如果 SetName < 1000，则值为 1，否则为 0
is_qq_or_wx = ${ 1 if int(SetName) < 1000 else 0 }
# SetName 默认为字符串，故这里需要用到 Python 的内置函数 int 进行类型转换
```

还可以使用 Python 对象的内置方法：

```bash
# 如果 SetName 以 qq 开头（如 qq1），则值为 1，否则为 0
is_qq_or_wx = ${ 1 if SetName.startswith('qq') else 0 }
# Python 字符串内置方法 startswith 可用于判断字符串是否以特定字字符串开头
```

### 结构控制

与 Bash 的结构控制类似，Mako 中的结构控制也需要开启和关闭。

#### 条件判断

借用上面的一个例子，改为结构控制语句实现同样的逻辑：
```bash
% if SetName.startswith("qq"):  
is_qq_or_wx = 1
% else:                         
is_qq_or_wx = 0
% endif                        
```

#### 循环

为了方便描述，这里仅以假想的例子演示循环语法：
```bash
% for set_name in ("aqq", "iqq", "awx", "iwx"):  # 将循环对象赋值给 set_name 变量
    ${ set_name }                                # 引用 set_name 变量
% endfor                                         # 关闭循环
```

与 Bash 类似，结构控制语句是可以嵌套的，比如，您完全可以在上面的循环结构中嵌入条件判断语句：

```bash
% for set_name in ("aqq", "iqq", "awx", "iwx"):
    % if set_name.endswith("qq"):
        ${ set_name } = 1
    % else:
        ${ set_name } = 0
    % endif
% endfor

# 上面这个例子的输出结果为：
        aqq = 1
        awx = 0
        iqq = 1
        iwx = 0
# 注意：您在模版中的缩进也会得到保留
```
#### 注释
单行注释

```bash
           ## 这是一行注释，它必须是单独的一行，且该行的非空字符以 ## 开头
some text  ## 这不是一行注释，因为该行开头的非空字符不是 ##
```
#### 多行注释

```bash
<%doc>
我是一条注释
我是另一条注释
......
这里的所有内容都是注释
</%doc>
```