## 开发一个页面

### 1. 新建视图模板

在 views 加入你的模板 db.ejs

``` html
<ul>
    <% results.forEach(function(r) { %>
        <li><%= r.id %> - <%= r.name %></li>
    <% }); %>
</ul>
```

### 2. 设置路由

在 index.js 加入你的路由

```bash
app.get('/db', function(request, response) {
    response.render('pages/db', {
        'SITE_URL': process.env.BKPAAS_SUB_PATH,
        'results': [
            {
                id: '1',
                name: 'test1'
            }
        ]
    });
});
```

### 3. 再次重启项目

再次重启项目，访问 http://dev.xxx.xxx:5000/db，就可以看到你新加的页面并把数据渲染出来
