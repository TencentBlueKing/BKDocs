## 开发第一个 Hello World 应用

### 1. 新建视图模板

在 项目的源码 views 目录下新建 hello.tmpl.html 文件，写入：

```bash
{% raw %}Hello {{.To}}{% endraw %}
```

### 2. 创建视图控制器

在项目 controllers 目录下新建 helloworld.go, 创建 HelloController 来处理相关的视图逻辑：

```golang
package controllers

// HelloController : HelloWorld
type HelloController struct {
	BaseController
}

// Get : GET 方法
func (c *HelloController) Get() {
	c.Data["To"] = "world"
    c.TplName = "hello.tmpl.html"
}
```

### 3. 设置路由

在项目 routers 目录下的 router.go 中新加入一条路由规则：

```bash
beego.Router("/hello", &controllers.HelloController{})
```

再次运行项目吧，在浏览器中输入 http://dev.xxx.xxx:5000/hello

将打开 Hello world 页面，“世界就在你眼前”！

