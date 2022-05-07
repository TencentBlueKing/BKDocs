# 第一大类：代码问题

## 1.1、发现代码缺陷

### SpotBugs

支持语言：Java

描述：SpotBugs 即 Findbugs，是 Java 的缺陷检测工具，它使用静态分析来查找 400 多种错误模式，例如空指针取消引用，无限递归循环，对 Java 库的错误使用和死锁等。


## 1.2、发现安全漏洞

工具待补充。

## 1.3、规范代码，检查一些逻辑错误


### CppLint
支持语言：C/C++

描述：谷歌开源的 C++代码风格检查工具，可确保 C++代码符合谷歌编码规范，并能检查语法错误。


### CheckStyle
支持语言：Java

描述：用于检查 Java 源代码是否符合编码规范。它可以找到类和方法设计问题，还能够检查代码布局和格式问题。



### ESLint
支持语言：JS

描述：开源的 JavaScript 代码检查工具，可以在开发阶段发现代码问题，支持最新的 ES6 语法标准，支持前端框架 Vue 和 React 等。


### StyleCop
支持语言：C#

描述：微软的开源静态代码分析工具，它检查 C＃代码是否符合 StyleCop 推荐的编码样式和 Microsoft .NET Framework 设计指南。



### Gometalinter
支持语言：Golang

描述：一款开源的 Golang 代码检查工具，支持检查代码规范、死代码、语法错误和安全漏洞等问题。



### detekt
支持语言：kotlin

描述：Kotlin 语言代码分析工具，除了能扫出编码的风格规范问题之外，还能检查出代码的复杂度、某些潜在逻辑错误以及性能问题，告警类型多达 152 种。



### PHPCS
支持语言：php

描述：PHP_CodeSniffer 用于检查 PHP 的编码规范。PHPCS 支持包括 PEAR、PSR-1、PSR-2、PSR-12 等 5 类代码规范标准，涵盖 257 种告警类型。



### PyLint
支持语言：python

描述：Python 代码风格检查工具，可检查代码行的长度、变量命名是否符合编码规范或声明的接口是否被真正的实现等。



### OCCheck
支持语言：OC/OC++

描述：OCCheck 是一款基于 ANTLR4 的 Objective-C 代码分析工具，可检查 Obj-C 常见的风格规范问题，目前支持 11 种告警类型。




# 第二大类：控制复杂度

### 圈复杂度

支持语言：C/C++、JAVA、C#、JS、OC/OC++、Python、PHP、Ruby、Golang、Swift、Scala、Lua、TTCN-3、Rust

描述：通过计算函数的节点个数来衡量代码复杂性。复杂度越高代码存在缺陷的风险越大。





# 第三大类：检测重复代码

### 重复率

支持语言： C/C++、JAVA、C#、JS、OC/OC++、Python、Golang、Kotlin、Lua、PHP、Ruby

描述：可以检测项目中复制粘贴和重复开发相同功能等问题，帮助开发者发现冗余代码，以便代码抽象和重构。





# 第四大类：检测代码行数

### 代码统计

支持语言： 支持所有语言，JAVA,Golang,C#,JS,Kotlin,C/C++,OC/OC++等

描述：可以统计代码中各类语言代码行、注释行、空白行的情况。