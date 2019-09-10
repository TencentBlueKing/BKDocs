### Web 安全防护 {#WebSafetyProtection}

WEB安全防护模块主要包括防 csrf 攻击和防 xss 攻击两方面。

(1)防 csrf 攻击：使用 django 提供的 csrf 模块，开发框架中已集成，用户无需做其他设置。

注：如需对某些请求去除 csrf 验证，可在对应 view 函数添加 csrf_exempt 装饰器。

(2)防 xss 攻击：开发框架中已集成防 xss 攻击的中间件，会对所有请求参数将进行特殊字符转义（富文本内容、URL 有特殊处理方式）。
