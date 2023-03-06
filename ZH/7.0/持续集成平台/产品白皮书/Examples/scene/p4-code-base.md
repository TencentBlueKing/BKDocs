# 集成P4代码库


## 关键词：P4、事件触发、代码拉取 <a id="&#x51C6;&#x5907;&#x4E8B;&#x9879;"></a>

## 业务挑战 <a id="&#x51C6;&#x5907;&#x4E8B;&#x9879;"></a>

Perforce是一款非常优秀的商业化版本管理工具，特别是对美术资源等大文件管理比较友好，被很多项目所追捧。使用P4的项目如果不能实现与DevOps工具打通，将大大影响CI的效率。

## 蓝盾优势 <a id="&#x51C6;&#x5907;&#x4E8B;&#x9879;"></a>

使用P4作为代码仓库的业务，可以使用蓝盾官方的P4功能插件。

## 解决方案 <a id="&#x51C6;&#x5907;&#x4E8B;&#x9879;"></a>

事件触发：

部分使用P4作为代码仓库的业务，希望能在某些P4事件产生的时候能够触发蓝盾流水线的自动执行，当前蓝盾支持“P4事件触发”，能够捕获“change commit”、“change content”、“change submit”、"shelve commit"、“shelve submit”5个事件；

![&#x56FE;1](../../assets/scene-p4-code-base-a.png)

代码拉取： 

事件代码的自动拉取，本插件同时支持Stream和Manual类型的仓库；

![&#x56FE;1](../../assets/scene-p4-code-base-b.png)