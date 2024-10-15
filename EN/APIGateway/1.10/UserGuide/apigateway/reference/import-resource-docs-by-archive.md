# Write and archive markdown format documents

> The gateway supports importing resource documents in markdown format. For details on how to import, please refer to the guide document [Import Gateway API Document] (../howto/import-resource-docs.md).

This document will guide users to write resource documents in markdown format and archive them into compressed packages required when importing documents.

## Write resource documentation

The resource document is in markdown format. For specific content, please refer to [API Resource Document Specification](../reference/api-doc-specification.md).

The file name of the resource document should be in the format of `resource name` + `.md`. For example: when the resource name is get_user, the document file name should be get_user.md.

The Chinese and English documents of the resources should be placed in the directories `zh` and `en` respectively. If documentation for a language does not exist, the corresponding directory can be ignored.

An example of the directory structure of a gateway resource document is as follows:
```
.
├── en
│ ├── create_user.md
│ └── get_user.md
└── en
     ├── create_user.md
     └── get_user.md
```

### How to reference public document fragments in resource documents

The gateway uses [Jinja templates](https://jinja.palletsprojects.com/en/3.0.x/templates/) to support the reference of document files. For resource documents that need to be rendered using Jinja templates, the file name suffix needs to be set to `.md.j2`; for referenced public document fragments, the file name can start with an underscore (\_).

When the gateway imports documents, it will enter the zh and en directories respectively to process Chinese and English documents. Different types of documents are processed in different ways:
- For documents with the suffix `.md`, the content of the document will be read directly
- Documents with the suffix `.md.j2` will be rendered using the Jinja template based on the directory where the document is located.
- Documents starting with an underscore (\_) will skip parsing. Such documents are public document fragments and are not documents of specific resources.

For example, when the resource get_user is rendered using the Jinja template, its document file name should be `get_user.md.j2`. Examples of its references to other documents are as follows:
```
...

{# Reference to public document fragment _user_model.md.j2 #}
{% include '_user_model.md.j2' %}
```

When the resource document contains Jinja template files, the directory structure example of the document is as follows:
```
.
├── en
│ ├── create_user.md
│ ├── get_user.md.j2
│ └── _user_model.md.j2
└── en
     ├── create_user.md
     ├── get_user.md.j2
     └── _user_model.md.j2
```

## Archive the document into a compressed package

When importing documents, you need to archive the resource documents into a compressed package. The compressed package supports two formats: tgz and zip. When archiving a compressed package, you need to directly package the zh and en document directories into the compressed package.

On a Linux system, you can create a compressed package by executing the following naming:
```
# My-gateway-name can be replaced with the specific gateway name
zip -rq my-gateway-name.zip en
tar czf my-gateway-name.tgz zh en
```