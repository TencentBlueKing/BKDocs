# Helm 使用技巧
## 在 Chart 中使用 BCS 变量
### BCS 提供的 Helm 变量

- 这些变量可以在 helm chart 中通过`{{ .Values.__BCS__.Key }}`的方式引用。

| Key  | Value 示例 | 说明 |
| ------------- | ------------- | ------------- |
| SYS_JFROG_DOMAIN  | xxx  | 仓库域名  |
| SYS_CLUSTER_ID  | BCS-K8S-XXX  | 集群 ID  |
| SYS_PROJECT_ID  | xxx  | 	项目 ID  |
| SYS_CC_APP_ID  | 1  | 业务 ID  |
| SYS_NAMESPACE  | default  | 命名空间  |

如下两种使用方式支持包含子 Chart 的场景

#### 方式 1 ：直接在 Chart 中使用

```bash
{{ default "127.0.0.1" $.Values.global.__BCS__.SYS_JFROG_DOMAIN }}
```

#### 方式 2 ：通过模板的方式使用

```bash
{{/*
domain template
*/}}
{{- define "bcsDomain" -}}
    {{- $default := "127.0.0.1" -}}
    {{- $values := .Values }}
    {{- if $values -}}

        {{- $global := $values.global }}
        {{- if $global -}}

            {{- $bcs := $global.__BCS__ -}}
            {{- if $bcs -}}

                {{- if $bcs.SYS_JFROG_DOMAIN -}}
                    {{- $bcs.SYS_JFROG_DOMAIN -}}
                {{- else -}}
                    {{- $default -}}
                {{- end -}}

            {{- else -}}
                {{- $default -}}
            {{- end -}}

        {{- else -}}
            {{- $default -}}
        {{- end -}}

    {{- else -}}
        {{- $default -}}
    {{- end -}}
{{- end -}}
```

在 Chart 中使用方式如下：

```bash
{{ template "bcsDomain" $ }}
```

## Helm Release 创建时表单与 values.yaml 参数说明

- 在创建 Helm Release 时，您可以通过填写表单或者直接编辑`values.yaml`来给 chart 传递参数。
- 表单是为了提升输入体验（规避错误输入）而引入的一种技术，它的值最终通过`--set`方式传递给`helm template`命令（string 类型的值通过 `--set-string` 传递给 `helm template`）。
- 页面编辑的`values.yaml`默认值是 Chart 中`values.yaml`文件内容，用于生成 Helm Release 时并不会替换 Chart 中的`values.yaml`文件，而是通过`--values`参数传递给`helm template`命令。
- 优先级问题
    + 为了消除您对参数优先级的困惑，我们通过一种双向同步的技术，将最新修改的输入源同步到另外一个输入源。比如，您在 form 表单中修改了镜像的 tag，当 form 表单失去焦点时，这个 tag 值会同步到`values.yaml`中，对应的，如果您接着编辑`values.yaml`的值，文本内容的变化也会自动反应到 form 表单中。
