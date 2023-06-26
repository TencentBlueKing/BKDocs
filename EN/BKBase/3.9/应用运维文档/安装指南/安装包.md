## 安装包

- 文件

bkbase-helmfile-x-x.x.tgz

- 文件目录结构和功能说明
```bash
bkbase-helmfile-x-x.x.tgz

.
├── 00-public.yaml # 各charts的次级入口配置模板
├── 01-migration-sql.yaml # 平台表结构变更
├── 01-migration-lite.yaml # bk-base-lite部分初始化逻辑
├── 01-migration-lake.yaml # bk-base-lake部分初始化逻辑
├── 02-metadata.yaml
├── ...
├── environments
│ └── default # 默认配置的模板存放目录
│ ├── authapi-values.yaml.gotmpl
│ ├── databus # databus配置单独存放目录(比较多的集群)
│ ├── keys.yaml # 放敏感信息
│ ├── values.yaml # 环境的默认值信息
│ ├── version.yaml # charts的版本信息
│ └── yarn-values.yaml.gotmpl
│ └── custom # 自定义环境变量的存放目录
├── env.yaml # 加载默认配置和自定义配置的主环境文件
├── helmfile_lite.yaml # 集成模块主入口文件
├── scripts # 存放一些自定义脚本的目录
│ ├── init_clusters.json
│ ├── init_clusters.json.tmp
│ ├── initialDatahubapi.sh
│ ├── initialHive.sh
│ ├── initialHive.sql
│ ├── initialMetadata.sh
│ ├── initialResourceapi.sh
│ ├── init_scenarios.json
└── templates #保留
```
