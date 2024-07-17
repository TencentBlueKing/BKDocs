# 拉取代码 checkout

## checkout

特殊属性，和 uses、run 不共存。
拉取 git 代码插件，可以拉取工蜂当前库的代码，或拉取工蜂其他库的代码，也可以拉取 gitlab、github的代码。
默认使用 代码库上的 OAUTH 授权拉取代码
语法为：
checkout: self | repo url 
支持如下入参：

| |
|:--|
|**参数名** |**是否必填** |**默认值** |**说明** |
|pullType |否 | |拉取方式，可选值为：BRANCH /TAG /COMMIT_ID <br>checkout: `self` 时将根据触发事件自动设置，如push时为COMMIT_ID ，手动配置无效 |
|refName |否 | |ref，分支名、TAG名或 COMMIT_ID<br>checkout: `self`时将根据触发事件自动设置，如push时为当前分支名，手动配置无效 |
|localPath |否 |当前工作空间 |代码拉取到本地的路径。当拉取其他代码库时，推荐填写，避免和当前代码库冲突。 |
|includePath |否 | |代码库拉取相对子路径 |
|excludePath |否 | |排除代码库以下路径 |
|fetchDepth |否 |1 |git fetch的depth参数值 |
|strategy |否 |REVERT_UPDATE |拉取策略，可选值为：<br>REVERT_UPDATE  增量,每次先 git reset --hard HEAD ,再 git pull<br>FRESH_CHECKOUT 全量,每次都会全新clone代码,之前会delete整个工作空间<br>INCREMENT_UPDATE  增量,只使用 git pull ,并不清除冲突及历史缓存文件 |
|enableSubmodule |否 |true |是否启用Submodule，true or false |
|submodulePath |否 | | |
|enableSubmoduleRemote |否 |false |执行git submodule update后面是否带上–remote参数 |
|enableSubmoduleRecursive |否 |true |执行git submodule update后面是否带上--recursive参数 |
|enableVirtualMergeBranch |否 |true |MR事件触发时是否执行Pre-Merge<br>为 true 时，将在MR事件触发时尝试Merge源分支到目标分支，冲突将直接判定为失败 |
|autoCrlf |否 | |AutoCrlf配置值 |
|enableFetchRefSpec |否 |false |启用拉取指定分支, 默认: false |
|enableGitClean |否 |true |是否开启Git Clean<br>为 true 时，将执行git clean, 删除未进行版本管理的文件 |
|enableGitLfs |否 |true |是否开启Git Lfs |
|authType |否 |当需要自定义鉴权时必填<br>若不指定，默认使用开启CI的用户的OAUTH权限 |授权方式，可选值为：<br>TICKET<br>PERSONAL_ACCESS_TOKEN<br>USERNAME_PASSWORD |
|username |否 | |当 authType=USERNAME_PASSWORD 时有效，拉代码使用的用户名 |
|password |否 | |当 authType=USERNAME_PASSWORD 时有效，拉代码使用的账户密码 |
|ticketId |否 | |当 authType=TICKET 时有效，凭据服务中创建的凭据ID |
|personalAccessToken |否 | |当 authType=PERSONAL_ACCESS_TOKEN 时有效，拉代码使用的工蜂个人token [personal access token](https://git.woa.com/help/menu/instruction/product-docs/profile.html#%E4%B8%AA%E4%BA%BA%E8%AE%BF%E9%97%AE%E5%87%AD%E6%8D%AE-personal-access-token) |


### 拉取事件触发时对应的代码，使用默认配置

 ```
version: v3.0

on:
  push: [ "*", "dev/*" ]

steps:
- checkout: self
  name: checkout the base repo
```

### 拉取事件触发时对应的代码，并指定自定义参数（`self 时`不支持指定pullType和refName）

 ```
version: v3.0

on:
  push: [ "*", "dev/*" ]

steps:
- checkout: self
  name: checkout the base repo with some custom param   
  with:
    strategy: FRESH_CHECKOUT
    enableGitLfs: true
```

### 拉取当前库触发时的分支

 ```
version: v3.0

on:
  push: [ "*", "dev/*" ]

steps:
- checkout: ${{ ci.repo_url }}
  name: checkout the base repo with some custom param   
  with:
    pullType: BRANCH
    refName: ${{ ci.branch }}
```

### 拉取当前库非触发分支或者其他库的代码（工蜂、github、gitlab）

#### 不指定凭证，直接使用代码库授权拉代码：

 ```
version: v3.0

on:
  push: [ "*", "dev/*" ]

steps:
- checkout: https://git.woa.com/XXX/XXX.git
  name: checkout another repo or github repo or gitlab repo
  with:
    pullType: BRANCH
    refName: master
    localPath: XXX/  
```

#### 指定凭证ID拉取代码：

 ```
version: v3.0

on:
  push: [ "*", "dev/*" ]

steps:
- checkout: https://git.woa.com/XXX/XXX.git
  name: checkout another repo or github repo or gitlab repo
  with:
    authType: TICKET
    ticketId: <my_git_personal_access_token>
    pullType: BRANCH
    refName: master
    localPath: XXX/  
```

#### 指定工蜂person_access_token拉取代码:

 ```
version: v3.0

on:
  push: [ "*", "dev/*" ]

steps:
- checkout: https://git.woa.com/XXX/XXX.git
  name: checkout another repo or github repo or gitlab repo
  with:
    authType: PERSONAL_ACCESS_TOKEN
    personalAccessToken: ${{ settings.<key>.access_token }}
    pullType: BRANCH
    refName: master
    localPath: XXX/  
```
