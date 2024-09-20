# 应用内登录弹窗适配方案
## 整体实现思路

方案主要解决在登录态失效时，ajax 请求不会触发页面整体刷新，而是在页面内弹出登录小窗，使得用户可以保留当前页面的未保存内容。主要流程如下：
![login_plain_usage.png](../assets/LOGIN_PLAIN_USAGE.png)

## 样例代码(Python 项目为例)

- login.js
- 用途：在 ajax 请求返回 401 时，可以识别请求返回的内容并打开弹窗

```javascript
/**
* 登录相关 JS，其中 remote_static_url & static_url 来源于全局变量
*/

document.write(" <script lanague=\"javascript\" src=\""+remote_static_url+"artdialog/jquery.artDialog.js?skin=simple\"> <\/script>");

/**
* 对 AJAX 请求做一些统一公共处理，目前主要是对登录页面做处理
*/
$.ajaxSetup({
    statusCode: {
        401: function(xhr) {
            var response = JSON.parse(xhr.responseText);
             // 确认当前版本是否支持 Iframe 登录方式
            if (!response.has_plain) {
                window.location.reload();
            }

            try{
                window.top.BLUEKING.corefunc.open_login_dialog(response['login_url']);
            }catch(err){
                open_login_dialog(
                    response['login_url'], response['width'], response['height']);
                }
        }
    }
});

/**
* 打开登录窗口
*/
function open_login_dialog(src, width, height){
    var login_html = '<div class="mod_login" id="loginbox" style="padding: 0px 0px; visibility: visible;" align="center">' +
                     '<iframe name="login_frame" id="login_frame"  width="100%" height="100%" frameborder="0" allowtransparency="yes"  src="'+src+
                     '" style="width:'+width+'px;height:'+height+'px;"></iframe>' +
                     '</div>';
    art.dialog({
        id:"401_dialog",
        fixed: true,
        lock: true,
        padding: "0px 0px",
        content: login_html
    });
}

/**
* 关闭登录框
*/
function close_login_dialog(){
    art.dialog({id: '401_dialog'}).close();

    try {
        window.close_login_dialog_after();
    } catch(err){}
}
```

- Login_success.html
- 用途：在用户登录成功后，触发关闭登录弹窗

```html
<!DOCTYPE html>
<html>
    <head>
        <title>登录成功</title>
        <script src="{{ REMOTE_STATIC_URL }}jquery/jquery-1.7.2.min.js"></script>
        <script src="{{ REMOTE_STATIC_URL }}jquery/jquery.json-2.3.min.js"></script>
        <link href="{{ REMOTE_STATIC_URL }}bk/bk.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="errors-login-failure-wrap box">
            <div class="errors-login-fialure-con clearfix" style="border: none;">
                <img src="{{ REMOTE_STATIC_URL }}bk/style_custom/images/expre_login.jpg" width="183" height="112" />
                <h1>登录成功</h1>
            </div>
        </div>
    </body>
    <script type="text/javascript">
        $(document).ready(function () {
            // 关闭登录弹出框
            try{
                window.top.BLUEKING.corefunc.close_login_dialog();
            }catch(err){
                try{
                    window.parent.close_login_dialog();
                }catch(err){}
            }
        });
    </script>
</html>
```

- 登录失效 401 返回格式
- 用途：告知浏览器登录弹窗需要打开的 URL 以及弹窗大小

```json
{
  "login_url": "https://{PaaS_URL}:443/login/plain/?c_url=https%3A//{PaaS_URL}/t/framework-login/account/login_success/&app_code=framework-login",
  "width": 460,
  "height": 490,
  "has_plain": true
}
```

> **注意**：其中，c_url 是告知平台登录成功后，应该让用户重定向到何页面。此处，我们让用户浏览器重定向到上方的 login_success.html 关闭弹窗

## 注意事项

   - 对于使用 Python 开发框架的开发者，可以更新至最新的开发框架，并将`IS_AJAX_PLAIN_MODE`配置改为`True`即可以完成适配

   - 上述的 js 样例是按照 ajax 使用 jquery 发送的配置样例，各项目应该按需调整

   - 注意测试需要在同样的域名或有允许跨域头的情况下进行操作，否则关闭弹窗时会有跨域的问题
