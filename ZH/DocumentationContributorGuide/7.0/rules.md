# 文档编辑规范

## 内容编辑语法
本文档旨在降低工作成本和规范蓝鲸官网所有对外文档的基本格式及风格。蓝鲸文档书写语法为 Markdown，更多请参考 [Markdown官网](http://markdown.p2hp.com/basic-syntax/)。


## 层级规范
1.必须英文命名每一个文件夹和文件名
2.目录从一级开始，最多可到第四级（四级以上的标题不符合常规阅读需求，请拆分或使用标题内的列表进行相应处理）
3.目录及文件命名需做到简介，尽量见名知意
4.目录不能为空，不要创建只有目录名而没有正文的内容

**目录层级可以参考以下模板**：

```bash
support-docs
─EN
│  └─CMDB
│      ├─GithubContributorGuide.md
│      ├─3.10
│      │  ├─SUMMARY.md
│      │  ├─APIDocs
│      │  ├─Architecture
│      │  ├─assets
│      │  ├─DevelopTools
│      │  ├─IntegrateGuide
│      │  ├─Operation
│      │  ├─ReleaseNote
│      │  ├─Troubleshooting
│      │  └─UserGuide
│      ├─3.11
│      │  ├─SUMMARY.md
│      │  ├─APIDocs
│      │  ├─Architecture
│      │  ├─assets
│      │  ├─DevelopTools
│      │  ├─IntegrateGuide
│      │  ├─Operation
│      │  ├─ReleaseNote
│      │  ├─Troubleshooting
│      │  └─UserGuide
│      ├─3.2
│      │  ├─SUMMARY.md
│      │  ├─APIDocs
│      │  ├─Architecture
│      │  ├─assets
│      │  ├─DevelopTools
│      │  ├─IntegrateGuide
│      │  ├─Operation
│      │  ├─ReleaseNote
│      │  ├─Troubleshooting
│      │  └─UserGuide
│      ├─3.9
│      │  ├─SUMMARY.md
│      │  ├─APIDocs
│      │  ├─Architecture
│      │  ├─assets
│      │  ├─DevelopTools
│      │  ├─IntegrateGuide
│      │  ├─Operation
│      │  ├─ReleaseNote
│      │  ├─Troubleshooting
│      │  └─UserGuide
│      └─ErrorCode
│          ├─xxx.md    
│
└─ZH
    └─CMDB
        ├─GithubContributorGuide.md
        ├─3.10
        │  ├─SUMMARY.md
        │  ├─APIDocs
        │  ├─Architecture
        │  ├─assets
        │  ├─DevelopTools
        │  ├─IntegrateGuide
        │  ├─Operation
        │  ├─ReleaseNote
        │  ├─Troubleshooting
        │  └─UserGuide
        ├─3.11
        │  ├─SUMMARY.md
        │  ├─APIDocs
        │  ├─Architecture
        │  ├─assets
        │  ├─DevelopTools
        │  ├─IntegrateGuide
        │  ├─Operation
        │  ├─ReleaseNote
        │  ├─Troubleshooting
        │  └─UserGuide
        ├─3.2
        │  ├─SUMMARY.md
        │  ├─APIDocs
        │  ├─Architecture
        │  ├─assets
        │  ├─DevelopTools
        │  ├─IntegrateGuide
        │  ├─Operation
        │  ├─ReleaseNote
        │  ├─Troubleshooting
        │  └─UserGuide
        ├─3.9
        │  ├─SUMMARY.md
        │  ├─APIDocs
        │  ├─Architecture
        │  ├─assets
        │  ├─DevelopTools
        │  ├─IntegrateGuide
        │  ├─Operation
        │  ├─ReleaseNote
        │  ├─Troubleshooting
        │  └─UserGuide
        └─ErrorCode
           ├─xxx.md    
```

## 文档内容规范

### 文案风格

1. 一定多检查，确保没有错别字。即使是流行语中的谐音错别字也不要使用，比如”墙裂”、”童鞋”、“程序猿”等。
2. 段落之间使用一个空行隔开。段落开头 **不要留出空白字符** 。
3. 请把对表达意思没有明显作用的字、词、句删除，在不影响表达效果的前提下把文案长度减到最短。
4. 避免口语，使用规范的书面语。例子：避免使用“么”、“喔”、“挂掉”等口语词汇。
5. 尽量避免中英文混杂。
6. 请一定注意“的”、“地”、“得”的用法。
7. 第一人称：推荐使用“蓝鲸”、“我们”，不推荐使用“小编”、“笔者”。
8. 避免多介词的复合长句。注意句子成分要齐全。
9. 产品名称一致性，产品名称要跟官网首页导航保持一致，不可随意书写。
10. 内容顺序，各类列表中的排序，需要符合惯例，不可随意排列，应跟官网首页导航顺序保持一致。
11. 命名合理性，概念命名，要通俗易懂，最好不要有歧义。
12. 文档里面引用了的文档链接必须要在渲染文件SUMMARY.md存在， 未在SUMMARY.md引用的链接不可访问。

### 中文、英文、数字混排时空格的使用

1. **中英文之间需要增加空格**，如：包管理 SaaS，它采用了类似 Git 的版本管理理念。
2. **中文与数字之间需要增加空格**，如：企业标准版拥有 7*24 小时的专属服务。
3. **数字与单位之间需要增加空格**，如：0-100 台服务需要的系统配置至少是 4 核 8 G，/data 盘至少 50 G。
4. **中文符号与其他字符之间不加空格**，如：蓝鲸智云日志检索产品是为了解决运维场景中查询日志难的问题而推出的一款 SaaS，基于业界主流的……
5. **链接之间需要增加空格**，如：蓝鲸文档书写语法为 Markdown，更多请参考 [Google](https://github.com/TencentBlueKing/BKDocs/blob/master/新文档中心格式要求)。

### 标点符号相关

1. 只有中文或中英文混排中，一律使用中文 / 全角标点。
2. 中英文混排中如果出现整句英文，则在这句英文中使用英文 / 半角标点。
3. 省略号：请使用”……“标准用法，请勿使用”。。。“。
4. 感叹号：请勿使用”！！“。尽量避免使用”！“。请先冷静下来再坐电脑前敲键盘。
5. 波浪号：请勿在文章内使用“~”，活泼地卖萌有很多其他的表达方式。

### 名词的正确用法

1. 专有名词大小写，如：GitHub，而不是 github、Github 或者 GITHUB。
2. 使用正确的缩写，如：JavaScript、HTML5，而不是 Js、h5。


## 特殊文件名规范

- SUMMARY.md
1.首行为一级标题Summary
2.第二行为空格
3.第三行为二级标题产品名字
4.第四行就可以开始写页面的标题了（和第三行不能有空行）
5.标题前面必须带* [xx](xx/xx.md)
6.如果* [xx]()是这种就必须在下面一行空四格在写* [xx](xx/xx.md)
7.summay文件只能存在产品/版本/下 在同产品下其他位置不能存在，存在代码会报错
8.新文档绝对路径从对应产品下的版本号开始写
9.整体绝对路径为ZH或者EN为起点

- Index.md
1.待补充

## 示例

*本示例仅供参考此规范中部分条款的使用说明，不保证其对客观事实的描述正确性。* 

![img](https://raw.githubusercontent.com/shpdnkti/bkFramework/master/example.png)

## 注意事项

1. 内容编辑/审核请遵循 [文档编辑规范](#文档编辑规范) 及 [语法](http://markdown.p2hp.com/basic-syntax/)
2. 已发布的文章不能删除，以免文章删除引起相关页面链接无法访问。
