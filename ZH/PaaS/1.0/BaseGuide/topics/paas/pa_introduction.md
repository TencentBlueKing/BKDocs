# 数据统计 - 网站浏览统计简介

## 简介

“网站浏览统计”是蓝鲸 PaaS3.0 开发者中心提供的一个应用数据统计功能。

该功能通过在应用页面代码内嵌入 JavaScript 脚本来统计用户访问行为。

## 如何接入网站浏览统计

如需接入统计，请在页面尾部的 `</body>` 标签前，增加以下代码：

> 注意：所有使用蓝鲸框架的 Django 应用默认已嵌入该脚本，无需重复添加。

```html
<script src="/static_api/v3/analysis_pro.js"></script>
<script>
    BKANALYSIS.init()
</script> 
```

其他注意事项：

只有通过以下地址访问，才能保证数据被正确统计：
  - 蓝鲸 PaaS3.0 开发者中心分配的子路径访问地址
  - 在蓝鲸 PaaS3.0 开发者中心上注册过的独立域名

### 无引擎应用如何接入

无引擎应用需要初始化**siteName**，并在调用时把**siteName**参数传过来。

你也可以在『数据统计』- 『网站浏览统计』-『接入指引』中查看。

```html
<!-- BK Analytics 把以下代码放在最后 -->
<script src="/static_api/v3/analysis_pro.js"></script>
<script>
    // siteName 是网站的唯一标识，请不要修改
    BKANALYSIS.init({
        siteName: 'custom:yourAppCode:default:default'
    })
</script> 
<!-- End BK Analytics -->
```

如果是第三方应用想接入数据统计，可以先创建无引擎应用，然后将**siteName**传过来即可。

### 看不到统计数据这么办

如果你确认应用已经嵌入了上面的统计脚本，但在统计数据页面看不到任何数据变化。

请打开浏览器的开发者工具，将报错页面截图后联系 @蓝鲸助手。
