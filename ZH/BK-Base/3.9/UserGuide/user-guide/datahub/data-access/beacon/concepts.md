# 灯塔接入

## 简介

灯塔接入支持拉取灯塔数据

## 采集原理

平台的灯塔任务从灯塔拉取数据到平台, 根据 appkey 和 eventcode 过滤数据,且 appkey，eventcode 只能接入一次

## 数据接入

### 数据信息

定义 了源数据的基础信息, 包含业务, 源数据名称等.

### 接入对象

填写灯塔 appkey 和 eventcode. appkey 支持填写多个

### 接入方式

采集方式目前不可修改

#### 接入界面示例如下

![](../../../../assets/access_new_beacon.png)

