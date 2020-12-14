# 私有构建机方案

>**提示**
> 我们默认的构建资源类型为公共构建机。此方案作为选配，在您需要的时候可继续实施。

私有构建机，也称为 “第三方构建机” ，是和项目绑定的专用构建机。
私有构建机一般用于敏感项目或者需要保障构建资源供应的场景。

## 补充软件包
### jre.zip

`/data/src/ci/agent-package/jre` 下需要放置 Linux / Windows / MacOS 对应的 jre.zip 文件。
一般使用 JDK8 的 tgz 安装包为基础， jre.zip 中应当存在 `bin/java` ，并预打包 `lib/ext/bcprov-jdk16-1.46.jar` 到 jre.zip 里。

预期 jre 的路径：
```text
/data/src/ci/agent-package/jre/
|-- linux
|   |-- jre.zip
|   `-- README.md
|-- macos
|   |-- jre.zip
|   `-- README.md
`-- windows
    |-- jre.zip
    `-- README.md
```

各 jre.zip 里的 `bcprov.jar` 放置路径：
```text
jre/linux/jre.zip
  1876535  05-23-2018 20:18   lib/ext/bcprov-jdk16-1.46.jar
jre/macos/jre.zip
  1876535  05-23-2018 20:24   Contents/Home/lib/ext/bcprov-jdk16-1.46.jar
jre/windows/jre.zip
  1876535  05-23-2018 20:20   lib/ext/bcprov-jdk16-1.46.jar
```

### unzip.exe

windows 需要 unzip.exe ，放在 `/data/src/ci/agent-package/packages/windows/` 目录下。
