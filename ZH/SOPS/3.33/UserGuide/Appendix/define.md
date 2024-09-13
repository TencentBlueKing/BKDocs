# 定义

分支表达式是一段类似 Python 语法的简单代码，是二元操作符和关键字组成的表达式。支持 "==、!=、>、>=、<、<=、in、notin" 等二元比较操作符和 "and、or、True/true、False/false" 等关键字语法,更多细节可参考 [boolrule](https://boolrule.readthedocs.io/en/latest/expressions.html#basic-comparison-operators) 。

操作符两侧的比较对象支持通过 ${key} 或${int(key)} 等方式引用全局变量。

全局变量支持基于python基础表达式进行处理，函数仅可使用内置函数和datetime、re、hashlib、random、time、os.path模块。

