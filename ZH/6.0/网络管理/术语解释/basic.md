## 术语解释

本文为大家介绍 NOP 网管平台特有的一些术语和基本概念。

### community

SNMP 的团体名，当需要对设备进行 SNMP 发现时，当 SNMP 版本是 1 或者 2 时，community 作为 SNMP 的凭据是必填项目。注意在 V3 版本中，SNMP 是弃用了 community 团体名这个参数的取而代之的是一套更安全的加密认证方法，为 SNMP 凭据提供了更安全的鉴权信息。

### OID

SNMP OID 是用一种按照层次化格式组织的、树状结构中的唯一地址来表示的，它与 DNS 层次相似。与其他格式的寻址方式类型，OID 以两种格式加以应用：全名和相对名（有时称为“相关”） 所有完全验证 OID 都有 `.iso.org.dod.internet.private` 开始，数字表达为: `.1.3.6.4.` 。几乎所有的 OID 都会跟上企业(.1)和由 IANA（互联网编号分配中心分配的）唯一的厂商标号。例如 OID 789 表示 Network Appliance 格式的厂商编号( NetApp ）。

厂商编号后面的是基于厂商实现的功能，并且各不相同。请注意，在 iso.前面的 .  ，与 DNS 中的后点相似，正确验证的 OID 是有一个表示根的前缀 . 开始的。 OID 的相对格式，从企业值开始，略过所有的隐含地址。因此，我们可以用相对地址`enterprises.netapp.netappl.raid.diskSUmmary.diskSpaceCount.0` 来表示上述的 OID，或者用数字格式 `.1.789.6.4.8.0`。

写 OID 的常用格式是用 MIB 名称和在 MIB 中定义的唯一键值。例如，我们可以用简写的格式重写上述 OID:

`NETWORK-APPLIANCE-MIB::diskSpareCount.0`
`MIB中OID的书写格式规则为：:MIB Name::唯一键值.instance.`

某些唯一键值，可用多个实例表示，这样所有的 OID 都以实例值结尾。

### KPI

KPI 通俗来讲就是设备的采集性能指标，当定义好 OID 后，需要配置相应的采集指标并且引入之前定义的 OID，这样就完成了一个采集指标的定义，后面设置采集时直接选择定义的 KPI 应用至相应的设备组或者端口组上就可以对设备性能数据进行采集。