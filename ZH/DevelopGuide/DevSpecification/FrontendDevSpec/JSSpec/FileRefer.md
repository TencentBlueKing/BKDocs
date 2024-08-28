- 在页面中引用 css 和 js、或配置 url 路径时，必须使用“绝对路径”，而不要使用 `../`，`./` 等相对路径的引用方式

- 发布上线之前，需要检查相应的环境是否存在引用的静态资源，不同环境之间不能交叉引用。

- 在页面中引用开发者编写的静态文件时，需要在资源路径后面增加版本号。如：

    `<link rel="stylesheet" href="${STATIC_URL}index.css?v=${STATIC_VERSION}">`

    `<script src="${STATIC_URL}index.js?v=${STATIC_VERSION}"></script>`

    发布上线前，需检查静态文件是否有改动。若有改动，则需要更新 settings 中 `STATIC_VERSION` 的值，以避免用户加载缓存的旧版本静态文件。
