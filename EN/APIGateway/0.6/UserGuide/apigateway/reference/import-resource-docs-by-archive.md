# 编写并归档 markdown 格式文档

> 网关支持导入 markdown 格式的资源文档，具体如何导入，请参考指引文档 [导入网关 API 文档](../howto/import-resource-docs.md)。

本文档将指引用户编写 markdown 格式的资源文档，并归档为导入文档时需要的压缩包。

## 编写资源文档

资源文档为 markdown 格式，具体内容的编写请参考 [API 资源文档规范](../reference/api-doc-specification.md)。

资源文档的文件名，应为 `资源名称` + `.md` 格式，例如：资源名称为 get_user 时，则其文档文件名应为 get_user.md。

资源的中文、英文文档，应分别放在目录 `zh`、`en` 下。如果某语言的文档不存在，可忽略对应的目录。

网关资源文档的目录结构样例如下：
```
.
├── en
│   ├── create_user.md
│   └── get_user.md
└── zh
    ├── create_user.md
    └── get_user.md
```

### 如何在资源文档中引用公共文档片段

网关采用 [Jinja 模板](https://jinja.palletsprojects.com/en/3.0.x/templates/) 支持文档文件的引用。对于需采用 Jinja 模板渲染的资源文档，需将文件名后缀设置为 `.md.j2`；对于被引用的公共文档片段，文件名可以以下划线（\_）开头。

网关导入文档时，将分别进入 zh、en 目录，处理中文、英文文档，不同类型的文档，处理方式不同：
- `.md` 为后缀的文档，将直接读取文档内容
- `.md.j2` 为后缀的文档，将以文档所在目录为基准，采用 Jinja 模板进行渲染
- 下划线 (\_) 开头的文档，将跳过解析，此类文档为公共文档片段，非具体资源的文档

例如资源 get_user，采用 Jinja 模板渲染时，其文档文件名应为 `get_user.md.j2`，其引用其它文档示例如下：
```
...

{# 引用公共文档片段 _user_model.md.j2 #}
{% include '_user_model.md.j2' %}
```

资源文档中包含 Jinja 模板文件时，文档的目录结构示例如下：
```
.
├── en
│   ├── create_user.md
│   ├── get_user.md.j2
│   └── _user_model.md.j2
└── zh
    ├── create_user.md
    ├── get_user.md.j2
    └── _user_model.md.j2
```

## 将文档归档为压缩包

导入文档时，需将资源文档归档为压缩包，压缩包支持 tgz, zip 两种格式。归档压缩包时，需直接将 zh、en 文档目录打包进压缩包。

在 Linux 系统中，你可以执行以下命名创建压缩包：
```
# 可将 my-gateway-name 替换为具体的网关名
zip -rq my-gateway-name.zip zh en
tar czf my-gateway-name.tgz zh en
```
