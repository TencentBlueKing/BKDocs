# TDBANK 接入

## 简介

tdbank 接入是 tdbank 数据导入的一种方式. 通过 tdbank 的 tube 消费数据上报到平台.

用户在 tdbank 中先创建 tube 消费, 然后在平台上配置即可.

## 采集原理

平台的 tdbank 任务从从 tube 消费数据

## 数据接入

### 数据信息

定义 了源数据的基础信息, 包含业务, 源数据名称等.数据源名称由用户自己定义, 在相同业务中不能重复

### 接入对象

接入对象参数均可从 tdbank 页面上查询获取, 参考 [tdbank 参数如何查询](./tdbank-query.md)

* Master 地址

* 消费组

* 消费 Topic

* 接口名称 根据用户在 TDBANK 的接入方式有两种接口类型：tid 与 iname，默认为 tid

tid：通过消息发送至 TDBANK，或者从 oceanus 中经过 tdbus 流入到消息中间件中
iname：TDBANK 文件类型接入，或者是通过 oceanus 直接接入到消息中间件中
具体情况请咨询：TDBank_TDW_TRC_Helper

* 接口值 与接口名称结合，用来区分数据归属

* 是否为混合数据源 \(需要找数据写入方确认, 混合数据的多种接口存在于同一文件中\)

* 分隔符. 混合数据源时有效. 支持 ASCII 码填写不可见字符

### 接入方式

接入方式为暂时不可修改

#### 接入界面示例如下

![](../../../../assets/access_new_tdbank.png)

