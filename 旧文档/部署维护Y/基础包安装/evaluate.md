##  硬件选择 {#hardware}

对于蓝鲸部署所需的硬件配置选型并无定规，蓝鲸由众多开源组件和自研组件构成。

开源组件的硬件选型可以参考相应的官方文档，参见附录 - [蓝鲸产品及开源组件版本](/12.附录/蓝鲸组件配置文件/configuration.md)。

安装主机系统官方推荐 CentOS 7.0 或以上。

蓝鲸产品本身的建议配置如下：

<table border="0" cellpadding="0" cellspacing="0" width="575" style="border-collapse:
 collapse;table-layout:fixed;width:431pt">
 <colgroup><col width="72" style="width:54pt">
 <col width="295" style="mso-width-source:userset;mso-width-alt:9440;width:221pt">
 <col width="104" span="2" style="mso-width-source:userset;mso-width-alt:3328;
 width:78pt">
 </colgroup><tbody><tr height="20" style="height:15.0pt">
  <td height="20" class="xl72" width="72" style="height:15.0pt;width:54pt">部署方式</td>
  <td class="xl72" width="295" style="border-left:none;width:221pt">产品</td>
  <td class="xl72" width="104" style="border-left:none;width:78pt">建议资源分配</td>
  <td class="xl72" width="104" style="border-left:none;width:78pt">建议满足配置</td>
 </tr>
 <tr height="36" style="mso-height-source:userset;height:27.0pt">
  <td rowspan="5" height="124" class="xl65" style="border-bottom:.5pt solid black;
  height:93.0pt;border-top:none">标准部署</td>
  <td class="xl66" style="border-top:none;border-left:none">PaaS</td>
  <td class="xl66" style="border-top:none;border-left:none">2核4G</td>
  <td rowspan="5" class="xl67" width="104" style="border-bottom:.5pt solid black;
  border-top:none;width:78pt">1台 4核16G<br>
    2台 4核8G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl66" style="height:16.5pt;border-top:none;border-left:
  none">CMDB</td>
  <td class="xl66" style="border-top:none;border-left:none">2核4G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl66" style="height:16.5pt;border-top:none;border-left:
  none">JOB</td>
  <td class="xl66" style="border-top:none;border-left:none">2核4G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl66" style="height:16.5pt;border-top:none;border-left:
  none">BKDATA</td>
  <td class="xl66" style="border-top:none;border-left:none">2核4G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl66" style="height:16.5pt;border-top:none;border-left:
  none">FTA</td>
  <td class="xl66" style="border-top:none;border-left:none">1核2G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td rowspan="2" height="44" class="xl65" style="border-bottom:.5pt solid black;
  height:33.0pt;border-top:none">单机部署</td>
  <td class="xl66" style="border-top:none;border-left:none">包含CMDB、JOB、PaaS、GSE、节点管理</td>
  <td class="xl66" style="border-top:none;border-left:none">　</td>
  <td class="xl66" style="border-top:none;border-left:none">1核4G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl66" style="height:16.5pt;border-top:none;border-left:
  none">与标准部署相同</td>
  <td class="xl66" style="border-top:none;border-left:none">　</td>
  <td class="xl66" style="border-top:none;border-left:none">2核16G</td>
 </tr>
 <!--[if supportMisalignedColumns]-->
 <tr height="0" style="display:none">
  <td width="72" style="width:54pt"></td>
  <td width="295" style="width:221pt"></td>
  <td width="104" style="width:78pt"></td>
  <td width="104" style="width:78pt"></td>
 </tr>
 <!--[endif]-->
</tbody></table>

> 注：单机部署-配置一可以满足最基础的运维场景，单机部署-配置二与标准部署相同，但是只有单台主机，运行效率与标准部署相比较低，出于业务的稳定性考虑，仅建议用于安装测试环境体验蓝鲸，具体请参考后续的单机部署文档。
