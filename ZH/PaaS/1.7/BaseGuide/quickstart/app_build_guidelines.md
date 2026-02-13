## 蓝鲸应用构建指引

蓝鲸开发者中心支持云原生应用的快速构建与部署，目前提供以下 **两种标准构建方式**：

- **蓝鲸 Buildpack（推荐）**：平台内置多种语言的构建工具，自动识别项目依赖并完成构建流程，无需手动编写 Dockerfile。
- **Dockerfile**：支持容器构建方式，适用于特殊构建需求或非标准项目结构。

> **注意**：无论采用哪种构建方式，都**需要在项目根目录下提供 [app_desc.yaml](../topics/paas/app_desc_cnative) 应用描述文件**，用于声明应用的进程配置、端口、启动命令等关键信息。

---

## 一、蓝鲸 Buildpack 构建方式

蓝鲸 PaaS 平台基于 [Cloud Native buildpack](https://buildpacks.io/) 规范，兼容多种语言的构建工具链。这些构建工具是一系列自动化脚本，用于将源码转换为可在运行时环境中执行的程序。

构建工具会根据项目中的**特征文件**（如 requirements.txt、package.json、go.mod 等）自动识别项目类型及是否需要构建，无需手动指定。

下面针对常见语言的项目结构和构建行为进行说明：

---

### 1. Python 语言

Python 应用通常使用 **pip** 作为依赖管理工具。推荐项目结构如下：

```
.
├── app_desc.yaml          # 应用描述文件（必需）
├── demo                   
├── requirements.txt       # Python 依赖清单（构建工具会自动识别）
└── urls.py                
```

**构建行为**：  
构建工具会检测到根目录（或构建目录，默认为项目根目录）下的 `requirements.txt` 文件，并执行以下命令安装依赖：

```bash
pip install -r requirements.txt
```

> **说明**：如果项目目录下**同时存在 Pipfile 和 requirements.txt**，构建工具将**优先使用 Pipfile** 进行依赖安装。

---

### 2. Go 语言

Go 语言项目通常使用 **Go Modules**（go.mod）进行依赖管理，推荐项目结构如下：

```
.
├── app_desc.yaml          # 应用描述文件（必需）
├── demo                   
└── go.mod                 # Go 模块定义文件
```

**构建行为**：  
构建工具会识别 `go.mod` 文件，并根据 Go Modules 自动完成依赖下载与编译流程。

---

### 3. Node.js 语言

Node.js 项目通常使用 **npm** 作为包管理工具，构建工具会自动安装运行时并执行构建脚本，推荐项目结构如下：

```
.
├── app_desc.yaml          # 应用描述文件（必需）
├── demo                   
└── package.json           # npm 配置及构建脚本定义
```

**构建行为**：  
构建工具会识别 `package.json`，自动安装 Node.js 运行时依赖，并执行 `npm install` 以及 `npm run build`（如果定义了构建脚本）。

---

## 二、Dockerfile 构建方式

如果您的应用无法通过内置的 Buildpack 工具链完成构建（例如使用了特殊构建流程、多阶段构建、自定义基础镜像等），您可以选择**使用自定义 Dockerfile** 来完成应用的构建与镜像生成。

 **使用方法**：  
在项目根目录下提供标准的 Dockerfile，蓝鲸平台将基于该文件构建应用镜像。

> **重要提示**：  
> 如果您同时提供了 `app_desc.yaml` 文件，**其中定义的进程配置（如 CMD、启动命令、端口等）将覆盖 Dockerfile 中的相关指令（如 CMD 或 ENTRYPOINT）**。  
> 建议您**直接在 app_desc.yaml 中定义进程相关的配置信息**，以确保配置的统一性与可维护性。

---