# devops\_ci\_store

**The database name:** devops\_ci\_store

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_store

 |                          Table name                          |                      Description                     | 
 | :--------------------------------------------------: | :-----------------------------------------: | 
 |              [T\_APPS](broken-reference)             |                   compile Stage table                   | 
 |            [T\_APP\_ENV](broken-reference)           |                   compile Env Variables table                   | 
 |          [T\_APP\_VERSION](broken-reference)         |                  Compilation environment Version Information Table                  | 
 |              [T\_ATOM](broken-reference)             |                    Pipeline atom table                   | 
 |       [T\_ATOM\_APPROVE\_REL](broken-reference)      |                  Plugin toCheck link Table                  | 
 |     [T\_ATOM\_BUILD\_APP\_REL](broken-reference)     |              Table link relationship between Pipeline atomic build and compilation environment              | 
 |       [T\_ATOM\_BUILD\_INFO](broken-reference)       |                  Pipeline atomic build information table                 | 
 | [T\_ATOM\_DEV\_LANGUAGE\_ENV\_VAR](broken-reference) |                  Plugin Env Variables information table                  | 
 |        [T\_ATOM\_ENV\_INFO](broken-reference)        |                 Pipeline atomic execute Stage table                | 
 |         [T\_ATOM\_FEATURE](broken-reference)         |                  Atomic Plugin property information table                  | 
 |        [T\_ATOM\_LABEL\_REL](broken-reference)       |                  Atom and label link Table                 | 
 |         [T\_ATOM\_OFFLINE](broken-reference)         |                    atomic archive list                    | 
 |       [T\_ATOM\_OPERATE\_LOG](broken-reference)      |                  Pipeline atomic Log table                 | 
 |   [T\_ATOM\_PIPELINE\_BUILD\_REL](broken-reference)  |                 Pipeline atomic build link table                | 
 |      [T\_ATOM\_PIPELINE\_REL](broken-reference)      |                Pipeline atom and pipeline link table               | 
 |       [T\_ATOM\_VERSION\_LOG](broken-reference)      |                  Pipeline atomic ChangeLog table                 | 
 |        [T\_BUILD\_RESOURCE](broken-reference)        |                  Pipeline buildResource Information Table                 | 
 |        [T\_BUSINESS\_CONFIG](broken-reference)       |                  store Business Name setting table                 | 
 |            [T\_CATEGORY](broken-reference)           |                    category information table                    | 
 |            [T\_CLASSIFY](broken-reference)           |                  Pipeline atom Service Classification information table                 | 
 |           [T\_CONTAINER](broken-reference)           | Pipeline build container table (the container here is not the same concept as Docker, but an element in the pipeline model)| 
 |    [T\_CONTAINER\_RESOURCE\_REL](broken-reference)   |               Pipeline container and buildResource link table               | 
 |             [T\_IMAGE](broken-reference)             |                    mirror information table                    | 
 |       [T\_IMAGE\_AGENT\_TYPE](broken-reference)      |                  Image and machine type link table                 | 
 |      [T\_IMAGE\_CATEGORY\_REL](broken-reference)     |                  Mirror image and category link table                 | 
 |         [T\_IMAGE\_FEATURE](broken-reference)        |                    mirror property table                    | 
 |       [T\_IMAGE\_LABEL\_REL](broken-reference)       |                  Image and label link Table                 | 
 |      [T\_IMAGE\_VERSION\_LOG](broken-reference)      |                   Mirror ChangeLog Table                   | 
 |             [T\_LABEL](broken-reference)             |                   Atomic label information table                   | 
 |              [T\_LOGO](broken-reference)             |                  store logo information table                  | 
 |             [T\_REASON](broken-reference)            |                    Cause definition Table                    | 
 |          [T\_REASON\_REL](broken-reference)          |                  Reason and Components link                  | 
 |         [T\_STORE\_APPROVE](broken-reference)        |                     toCheck form                     | 
 |     [T\_STORE\_BUILD\_APP\_REL](broken-reference)    |              store build and compile environment link table              | 
 |       [T\_STORE\_BUILD\_INFO](broken-reference)      |                 store Components build information table                | 
 |         [T\_STORE\_COMMENT](broken-reference)        |                 store Components comment information table                | 
 |     [T\_STORE\_COMMENT\_PRAISE](broken-reference)    |                store Components comment like information table               | 
 |     [T\_STORE\_COMMENT\_REPLY](broken-reference)     |                store Components comment reply information table               | 
 |        [T\_STORE\_DEPT\_REL](broken-reference)       |                store Components and Organization link Table                | 
 |        [T\_STORE\_ENV\_VAR](broken-reference)        |                   Env Variables Information Table                   | 
 |       [T\_STORE\_MEDIA\_INFO](broken-reference)      |                    Media Information Table                    | 
 |         [T\_STORE\_MEMBER](broken-reference)         |                 store Components member information table                | 
 |        [T\_STORE\_OPT\_LOG](broken-reference)        |                  store Log table                 | 
 |  [T\_STORE\_PIPELINE\_BUILD\_REL](broken-reference)  |                 store Components build link table                 | 
 |      [T\_STORE\_PIPELINE\_REL](broken-reference)     |                store Components and Pipeline link Table               | 
 |      [T\_STORE\_PROJECT\_REL](broken-reference)      |                 store Components and project link Table                | 
 |         [T\_STORE\_RELEASE](broken-reference)        |                store Components Release upgrade information table               | 
 |     [T\_STORE\_SENSITIVE\_API](broken-reference)     |                  Sensitive API Information Table                 | 
 |     [T\_STORE\_SENSITIVE\_CONF](broken-reference)    |                  store Private setting table                 | 
 |       [T\_STORE\_STATISTICS](broken-reference)       |                  store statistics table                 | 
 |    [T\_STORE\_STATISTICS\_DAILY](broken-reference)   |                 store daily statistic information table                | 
 |    [T\_STORE\_STATISTICS\_TOTAL](broken-reference)   |                 Store All Statistics                | 
 |            [T\_TEMPLATE](broken-reference)           |                    Template Information Table                    | 
 |    [T\_TEMPLATE\_CATEGORY\_REL](broken-reference)    |                  Template and Category link Table                 | 
 |      [T\_TEMPLATE\_LABEL\_REL](broken-reference)     |                  Template and label link Table                 | 

**Table name:** T\_APPS

 **Description:** Compilation Stage table 

 **Data column:** 

 |  No. |     name    |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :-------: | :-----: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |     ID    |   int   |  10 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |    NAME   | varchar |  64 |  0  |   N  |  N  |     |   name   | 
 |  3  |     OS    | varchar |  32 |  0  |   N  |  N  |     |  The operating system| 
 |  4  | BIN\_PATH | varchar |  64 |  0  |   Y  |  N  |     | path where execute occurs| 

 **Table name:** T\_APP\_ENV 

 **Description:** Compilation Env Variables table 

 **Data column:** 

 |  No. |      name     |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |      ID     |   int   |  10 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |   APP\_ID   |   int   |  10 |  0  |   N  |  N  |     | Compile environment ID| 
 |  3  |     PATH    | varchar |  32 |  0  |   N  |  N  |     |   path   | 
 |  4  |     NAME    | varchar |  32 |  0  |   N  |  N  |     |   name   | 
 |  5  | DESCRIPTION | varchar |  64 |  0  |   N  |  N  |     |   description   | 

 **Table name:** T\_APP\_VERSION 

 **Description:** Compilation environment Version Information table 

 **Data column:** 

 |  No. |    name   |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :-----: | :-----: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |    ID   |   int   |  10 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  | APP\_ID |   int   |  10 |  0  |   N  |  N  |     | Compile environment ID| 
 |  3  | VERSION | varchar |  32 |  0  |   Y  |  N  |     |   versionNum| 

**Table name:** T\_ATOM

**Description:**   Pipeline atom table 

**Data column:** 

 |  No. |            name           |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |                  Description                  | 
 | :-: | :---------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----------------------------------: | 
 |  1  |            ID           |  varchar |   32  |  0  |   N  |  Y  |                    |                  primary key ID                 | 
 |  2  |           NAME          |  varchar |   64  |  0  |   N  |  N  |                    |                  name                  | 
 |  3  |        ATOM\_CODE       |  varchar |   64  |  0  |   N  |  N  |                    |                Unique identification of the Plugin               | 
 |  4  |       CLASS\_TYPE       |  varchar |   64  |  0  |   N  |  N  |                    |                 Plugin category                 | 
 |  5  |      SERVICE\_SCOPE     |  varchar |  256  |  0  |   N  |  N  |                    |                 Effective Range                 | 
 |  6  |        JOB\_TYPE        |  varchar |   20  |  0  |   Y  |  N  |                    | Applicable Job type, AGENT: Build environment, AGENT\_LESS: noEnv| 
 |  7  |            OS           |  varchar |  100  |  0  |   N  |  N  |                    |                 The operating system                 | 
 |  8  |       CLASSIFY\_ID      |  varchar |   32  |  0  |   N  |  N  |                    |                Service Classification ID                | 
 |  9  |        DOCS\_LINK       |  varchar |  256  |  0  |   Y  |  N  |                    |                The document location link                | 
 |  10 |        ATOM\_TYPE       |  tinyint |   4   |  0  |   N  |  N  |          1         |                 atomic type                 | 
 |  11 |       ATOM\_STATUS      |  tinyint |   4   |  0  |   N  |  N  |                    |                 atomic status                 | 
 |  12 |    ATOM\_STATUS\_MSG    |  varchar |  1024 |  0  |   Y  |  N  |                    |                Plugin status information                | 
 |  13 |         SUMMARY         |  varchar |  256  |  0  |   Y  |  N  |                    |                  summary                  | 
 |  14 |       DESCRIPTION       |   text   | 65535 |  0  |   Y  |  N  |                    |                  description                  | 
 |  15 |         CATEGROY        |  tinyint |   4   |  0  |   N  |  N  |          1         |                  category                  | 
 |  16 |         VERSION         |  varchar |   20  |  0  |   N  |  N  |                    |                  versionNum                 | 
 |  17 |        LOGO\_URL        |  varchar |  256  |  0  |   Y  |  N  |                    |               LOGOURL address              | 
 |  18 |           ICON          |   text   | 65535 |  0  |   Y  |  N  |                    |                 Plugin icon                 | 
 |  19 |      DEFAULT\_FLAG      |    bit   |   1   |  0  |   N  |  N  |        b'0'        |                Default Atom               | 
 |  20 |       LATEST\_FLAG      |    bit   |   1   |  0  |   N  |  N  |                    |               Is the The latest version of atom              | 
 |  21 |  BUILD\_LESS\_RUN\_FLAG |    bit   |   1   |  0  |   Y  |  N  |                    |         Can an atom without a build environment Run identity in a build environment        | 
 |  22 |   REPOSITORY\_HASH\_ID  |  varchar |   64  |  0  |   Y  |  N  |                    |                Code Repository Hash ID               | 
 |  23 |        CODE\_SRC        |  varchar |  256  |  0  |   Y  |  N  |                    |                 Code Repository link                | 
 |  24 |        PAY\_FLAG        |    bit   |   1   |  0  |   Y  |  N  |        b'1'        |                 Free of charge                 | 
 |  25 | HTML\_TEMPLATE\_VERSION |  varchar |   10  |  0  |   N  |  N  |         1.1        |               Front-end rendering templateVersion               | 
 |  26 |          PROPS          |   text   | 65535 |  0  |   Y  |  N  |                    |         JSON string of customize extension container front-end form property Field        | 
 |  27 |           DATA          |   text   | 65535 |  0  |   Y  |  N  |                    |                 reserved Field                 | 
 |  28 |        PUBLISHER        |  varchar |   50  |  0  |   N  |  N  |       system       |                 atomic publisher                | 
 |  29 |          WEIGHT         |    int   |   10  |  0  |   Y  |  N  |                    |                  weight value                  | 
 |  30 |         CREATOR         |  varchar |   50  |  0  |   N  |  N  |       system       |                  projectCreator                 | 
 |  31 |         MODIFIER        |  varchar |   50  |  0  |   N  |  N  |       system       |                  Updated by                 | 
 |  32 |       CREATE\_TIME      | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 creationTime                 | 
 |  33 |       UPDATE\_TIME      | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 updateTime                 | 
 |  34 |    VISIBILITY\_LEVEL    |    int   |   10  |  0  |   N  |  N  |          0         |                 visibleRange                 | 
 |  35 |        PUB\_TIME        | datetime |   19  |  0  |   Y  |  N  |                    |                 Release Time                 | 
 |  36 |     PRIVATE\_REASON     |  varchar |  256  |  0  |   Y  |  N  |                    |              Plugin Code Repository is not open source              | 
 |  37 |       DELETE\_FLAG      |    bit   |   1   |  0  |   Y  |  N  |        b'0'        |                 Delete                 | 

 **Table name:** T\_ATOM\_APPROVE\_REL 

 **Description:** Plugin toCheck link table 

**Data column:** 

 |  No. |          name         |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |    Description   | 
 | :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----: | 
 |  1  |          ID         |  varchar |  32 |  0  |   N  |  Y  |                    |    primary key ID  | 
 |  2  |      ATOM\_CODE     |  varchar |  64 |  0  |   N  |  N  |                    | Unique identification of the Plugin| 
 |  3  | TEST\_PROJECT\_CODE |  varchar |  32 |  0  |   N  |  N  |                    |  Debug project Code| 
 |  4  |     APPROVE\_ID     |  varchar |  32 |  0  |   N  |  N  |                    |   Approval ID| 
 |  5  |       CREATOR       |  varchar |  50 |  0  |   N  |  N  |       system       |   projectCreator   | 
 |  6  |       MODIFIER      |  varchar |  50 |  0  |   N  |  N  |       system       |  Updated by| 
 |  7  |     CREATE\_TIME    | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   creationTime| 
 |  8  |     UPDATE\_TIME    | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   updateTime| 

 **Table name:** T\_ATOM\_BUILD\_APP\_REL 

 **Description:** Table link association between Pipeline atomic build and compilation environment 

 **Data column:** 

 |  No. |        name        |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |               Description              | 
 | :-: | :--------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :---------------------------: | 
 |  1  |        ID        |  varchar |  32 |  0  |   N  |  Y  |                    |               primary key ID             | 
 |  2  |  BUILD\_INFO\_ID |  varchar |  32 |  0  |   N  |  N  |                    |             build Info Id            | 
 |  3  | APP\_VERSION\_ID |    int   |  10 |  0  |   Y  |  N  |                    | Compilation environment version Id(corresponding to T\_APP\_VERSION primary key )| 
 |  4  |      CREATOR     |  varchar |  50 |  0  |   N  |  N  |       system       |              projectCreator              | 
 |  5  |     MODIFIER     |  varchar |  50 |  0  |   N  |  N  |       system       |              Updated by              | 
 |  6  |   CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |              creationTime             | 
 |  7  |   UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |              updateTime             | 

 **Table name:** T\_ATOM\_BUILD\_INFO 

 **Description:** Pipeline atomic build information table 

 **Data column:** 

 |  No. |           name          |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |     Description     | 
 | :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--------: | 
 |  1  |           ID          |  varchar |   32  |  0  |   N  |  Y  |                    |     primary key ID    | 
 |  2  |        LANGUAGE       |  varchar |   64  |  0  |   Y  |  N  |                    |     Language     | 
 |  3  |         SCRIPT        |   text   | 65535 |  0  |   N  |  N  |                    |    Package Script    | 
 |  4  |        CREATOR        |  varchar |   50  |  0  |   N  |  N  |       system       |     projectCreator    | 
 |  5  |        MODIFIER       |  varchar |   50  |  0  |   N  |  N  |       system       |     Updated by    | 
 |  6  |      CREATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime    | 
 |  7  |      UPDATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime    | 
 |  8  |    REPOSITORY\_PATH   |  varchar |  500  |  0  |   Y  |  N  |                    |   Code storage path   | 
 |  9  | SAMPLE\_PROJECT\_PATH |  varchar |  500  |  0  |   N  |  N  |                    |   Sample Project path   | 
 |  10 |         ENABLE        |    bit   |   1   |  0  |   N  |  N  |        b'1'        | Enable 1 Enable 0 Disable| 

**Table name:** T\_ATOM\_DEV\_LANGUAGE\_ENV\_VAR

**Description:**   Plugin Env Variables information table 

**Data column:** 

 |  No. |         name        |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |                                Description                                | 
 | :-: | :---------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------------------------------------------------------------: | 
 |  1  |         ID        |  varchar |  32 |  0  |   N  |  Y  |                    |                                 primary key                                 | 
 |  2  |      LANGUAGE     |  varchar |  64 |  0  |   N  |  N  |                    |                              Develop Plugin language                              | 
 |  3  |      ENV\_KEY     |  varchar |  64 |  0  |   N  |  N  |                    |                             Env Variables key value                             | 
 |  4  |     ENV\_VALUE    |  varchar | 256 |  0  |   N  |  N  |                    |                            Env Variables value                            | 
 |  5  | BUILD\_HOST\_TYPE |  varchar |  32 |  0  |   N  |  N  |                    |              Applicable agent type PUBLIC: BK-CI hosted agent, THIRD: Self hosted agent, ALL: all             | 
 |  6  |  BUILD\_HOST\_OS  |  varchar |  32 |  0  |   N  |  N  |                    | Applicable to agent The operating system WINDOWS:windows build machine, LINUX:linux build machine, MAC\_OS:mac build machine, ALL: all| 
 |  7  |      CREATOR      |  varchar |  50 |  0  |   N  |  N  |       system       |                                creator                               | 
 |  8  |      MODIFIER     |  varchar |  50 |  0  |   N  |  N  |       system       |                               Updated by                              | 
 |  9  |    CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                               creationTime                               | 
 |  10 |    UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                               updateTime                               | 

 **Table name:** T\_ATOM\_ENV\_INFO 

 **Description:** Pipeline atomic execute Stage table 

 **Data column:** 

 |  No. |         name         |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |       Description      | 
 | :-: | :----------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-----------: | 
 |  1  |         ID         |  varchar |   32  |  0  |   N  |  Y  |                    |       primary key ID     | 
 |  2  |      ATOM\_ID      |  varchar |   32  |  0  |   N  |  N  |                    |      Plugin Id     | 
 |  3  |      PKG\_PATH     |  varchar |  1024 |  0  |   N  |  N  |                    |     install Package path     | 
 |  4  |      LANGUAGE      |  varchar |   64  |  0  |   Y  |  N  |                    |       Language      | 
 |  5  |    MIN\_VERSION    |  varchar |   20  |  0  |   Y  |  N  |                    | Minimum version of the Develop Plugin language supported| 
 |  6  |       TARGET       |  varchar |  256  |  0  |   N  |  N  |                    |     Plugin execute entry    | 
 |  7  |    SHA\_CONTENT    |  varchar |  1024 |  0  |   Y  |  N  |                    |    Plugin SHA signature string   | 
 |  8  |      PRE\_CMD      |   text   | 65535 |  0  |   Y  |  N  |                    |    Plugin execute pre-command   | 
 |  9  |       CREATOR      |  varchar |   50  |  0  |   N  |  N  |       system       |      projectCreator      | 
 |  10 |      MODIFIER      |  varchar |   50  |  0  |   N  |  N  |       system       |      Updated by      | 
 |  11 |    CREATE\_TIME    | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      creationTime     | 
 |  12 |    UPDATE\_TIME    | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      updateTime     | 
 |  13 |      PKG\_NAME     |  varchar |  256  |  0  |   Y  |  N  |                    |      Plugin package     | 
 |  14 | POST\_ENTRY\_PARAM |  varchar |   64  |  0  |   Y  |  N  |                    |      entry Parameter     | 
 |  15 |   POST\_CONDITION  |  varchar |  1024 |  0  |   Y  |  N  |                    |      execute condition     | 

**Table name:** T\_ATOM\_FEATURE

**Description:**   Atomic Plugin property information table 

**Data column:** 

 |  No. |         name        |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |     Description     | 
 | :-: | :---------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------: | 
 |  1  |         ID        |  varchar |  32 |  0  |   N  |  Y  |                    |     primary key ID    | 
 |  2  |     ATOM\_CODE    |  varchar |  64 |  0  |   N  |  N  |                    |   Unique identification of the Plugin| 
 |  3  | VISIBILITY\_LEVEL |    int   |  10 |  0  |   N  |  N  |          0         |    visibleRange    | 
 |  4  |      CREATOR      |  varchar |  50 |  0  |   N  |  N  |       system       |     projectCreator    | 
 |  5  |      MODIFIER     |  varchar |  50 |  0  |   N  |  N  |       system       |     Updated by    | 
 |  6  |    CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime    | 
 |  7  |    UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime    | 
 |  8  |  RECOMMEND\_FLAG  |    bit   |  1  |  0  |   Y  |  N  |        b'1'        |    Recommended    | 
 |  9  |  PRIVATE\_REASON  |  varchar | 256 |  0  |   Y  |  N  |                    | Plugin Code Repository is not open source| 
 |  10 |    DELETE\_FLAG   |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |    Delete    | 
 |  11 |     YAML\_FLAG    |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |  yaml available identification| 
 |  12 |   QUALITY\_FLAG   |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |  Gate Available Identification| 

 **Table name:** T\_ATOM\_LABEL\_REL 

 **Description:** Atom and label link Table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |  primary key ID | 
 |  2  |   LABEL\_ID  |  varchar |  32 |  0  |   N  |  N  |                    | label ID| 
 |  3  |   ATOM\_ID   |  varchar |  32 |  0  |   N  |  N  |                    | Plugin Id| 
 |  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |  projectCreator| 
 |  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  Updated by| 
 |  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

 **Table name:** T\_ATOM\_OFFLINE 

 **Description:** Atom archive Table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |    Description   | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    primary key ID  | 
 |  2  |  ATOM\_CODE  |  varchar |  64 |  0  |   N  |  N  |                    | Unique identification of the Plugin| 
 |  3  |  BUFFER\_DAY |  tinyint |  4  |  0  |   N  |  N  |                    |         | 
 |  4  | EXPIRE\_TIME | datetime |  19 |  0  |   N  |  N  |                    |   expireDate| 
 |  5  |    STATUS    |  tinyint |  4  |  0  |   N  |  N  |                    |    status   | 
 |  6  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   projectCreator   | 
 |  7  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |   Updated by   | 
 |  8  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   creationTime| 
 |  9  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   updateTime| 

**Table name:** T\_ATOM\_OPERATE\_LOG

**Description:**   Pipeline atomic Log table 

**Data column:** 

 |  No. |      name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  |      ID      |  varchar |   32  |  0  |   N  |  Y  |                    |  primary key ID | 
 |  2  |   ATOM\_ID   |  varchar |   32  |  0  |   N  |  N  |                    | Plugin Id| 
 |  3  |    CONTENT   |   text   | 65535 |  0  |   N  |  N  |                    | Log Content| 
 |  4  |    CREATOR   |  varchar |   50  |  0  |   N  |  N  |       system       |  projectCreator| 
 |  5  |   MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |  Updated by| 
 |  6  | CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  | UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

 **Table name:** T\_ATOM\_PIPELINE\_BUILD\_REL 

 **Description:** Pipeline atomic build link table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :---: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |   primary key ID | 
 |  2  |   ATOM\_ID   |  varchar |  32 |  0  |   N  |  N  |                    |  Plugin Id| 
 |  3  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |                    | pipelineId| 
 |  4  |   BUILD\_ID  |  varchar |  34 |  0  |   N  |  N  |                    |  build ID| 
 |  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |  projectCreator| 
 |  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  Updated by| 
 |  7  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  8  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

 **Table name:** T\_ATOM\_PIPELINE\_REL 

 **Description:** Pipeline atom and pipeline link table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |    Description   | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    primary key ID  | 
 |  2  |  ATOM\_CODE  |  varchar |  64 |  0  |   N  |  N  |                    | Unique identification of the Plugin| 
 |  3  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |                    |  pipelineId| 
 |  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   projectCreator   | 
 |  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |   Updated by   | 
 |  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   creationTime| 
 |  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   updateTime| 

**Table name:** T\_ATOM\_VERSION\_LOG

**Description:**   Pipeline atomic ChangeLog table 

**Data column:** 

 |  No. |       name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  |       ID      |  varchar |   32  |  0  |   N  |  Y  |                    |  primary key ID | 
 |  2  |    ATOM\_ID   |  varchar |   32  |  0  |   N  |  N  |                    | Plugin Id| 
 |  3  | RELEASE\_TYPE |  tinyint |   4   |  0  |   N  |  N  |                    | Release Type| 
 |  4  |    CONTENT    |   text   | 65535 |  0  |   N  |  N  |                    | Log Content| 
 |  5  |    CREATOR    |  varchar |   50  |  0  |   N  |  N  |       system       |  projectCreator| 
 |  6  |    MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |  Updated by| 
 |  7  |  CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  8  |  UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

 **Table name:** T\_BUILD\_RESOURCE 

 **Description:** Pipeline buildResource Information Table 

 **Data column:** 

 |  No. |           name          |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |    Description   | 
 | :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----: | 
 |  1  |           ID          |  varchar |  32 |  0  |   N  |  Y  |                    |    primary key ID  | 
 |  2  | BUILD\_RESOURCE\_CODE |  varchar |  30 |  0  |   N  |  N  |                    |  buildResource Code| 
 |  3  | BUILD\_RESOURCE\_NAME |  varchar |  45 |  0  |   N  |  N  |                    |  buildResource name| 
 |  4  |     DEFAULT\_FLAG     |    bit   |  1  |  0  |   N  |  N  |        b'0'        | Default Atom| 
 |  5  |        CREATOR        |  varchar |  50 |  0  |   N  |  N  |       system       |   projectCreator   | 
 |  6  |        MODIFIER       |  varchar |  50 |  0  |   N  |  N  |       system       |   Updated by   | 
 |  7  |      CREATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   creationTime| 
 |  8  |      UPDATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   updateTime| 

 **Table name:** T\_BUSINESS\_CONFIG 

 **Description:** store Business Name setting table 

 **Data column:** 

 |  No. |        name       |   Type Of Data  |   length  | decimal place | Allow Null |   primary key  | defaultValue |    Description    | 
 | :-: | :-------------: | :-----: | :---: | :-: | :--: | :-: | :-: | :------: | 
 |  1  |     BUSINESS    | varchar |   64  |  0  |   N  |  N  |     |   Business Name Name   | 
 |  2  |     FEATURE     | varchar |   64  |  0  |   N  |  N  |     | Feature to control| 
 |  3  | BUSINESS\_VALUE | varchar |  255  |  0  |   N  |  N  |     |   Business Name Access   | 
 |  4  |  CONFIG\_VALUE  |   text  | 65535 |  0  |   N  |  N  |     |    setting value   | 
 |  5  |   DESCRIPTION   | varchar |  255  |  0  |   Y  |  N  |     |   setting description   | 
 |  6  |        ID       |   int   |   10  |  0  |   N  |  Y  |     |    primary key ID   | 

**Table name:** T\_CATEGORY

**Description:**   category information table 

**Data column:** 

 |  No. |       name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
 | :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: | 
 |  1  |       ID       |  varchar |  32 |  0  |   N  |  Y  |                    |   primary key ID  | 
 |  2  | CATEGORY\_CODE |  varchar |  32 |  0  |   N  |  N  |                    |  category Code| 
 |  3  | CATEGORY\_NAME |  varchar |  32 |  0  |   N  |  N  |                    |  category name| 
 |  4  |    ICON\_URL   |  varchar | 256 |  0  |   Y  |  N  |                    | Category icon link| 
 |  5  |      TYPE      |  tinyint |  4  |  0  |   N  |  N  |          0         |   type   | 
 |  6  |     CREATOR    |  varchar |  50 |  0  |   N  |  N  |       system       |   projectCreator| 
 |  7  |    MODIFIER    |  varchar |  50 |  0  |   N  |  N  |       system       |   Updated by| 
 |  8  |  CREATE\_TIME  | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  9  |  UPDATE\_TIME  | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

 **Table name:** T\_CLASSIFY 

 **Description:** Pipeline atom Service Classification information table 

 **Data column:** 

 |  No. |       name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |    Description    | 
 | :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :------: | 
 |  1  |       ID       |  varchar |  32 |  0  |   N  |  Y  |                    |    primary key ID   | 
 |  2  | CLASSIFY\_CODE |  varchar |  32 |  0  |   N  |  N  |                    | Image Service Classification Code| 
 |  3  | CLASSIFY\_NAME |  varchar |  32 |  0  |   N  |  N  |                    | Image Service Classification name| 
 |  4  |     WEIGHT     |    int   |  10 |  0  |   Y  |  N  |                    |    weight value    | 
 |  5  |     CREATOR    |  varchar |  50 |  0  |   N  |  N  |       system       |    projectCreator   | 
 |  6  |    MODIFIER    |  varchar |  50 |  0  |   N  |  N  |       system       |    Updated by   | 
 |  7  |  CREATE\_TIME  | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   creationTime   | 
 |  8  |  UPDATE\_TIME  | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   updateTime   | 
 |  9  |      TYPE      |  tinyint |  4  |  0  |   N  |  N  |          0         |    type    | 

 **Table name:** T\_CONTAINER 

 **Description:** Pipeline build container table (the container here is not the same concept as Docker, but an element in the pipeline model) 

 **Data column:** 

 |  No. |           name          |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |           Description          | 
 | :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------------------: | 
 |  1  |           ID          |  varchar |   32  |  0  |   N  |  Y  |                    |           primary key ID         | 
 |  2  |          NAME         |  varchar |   45  |  0  |   N  |  N  |                    |           name          | 
 |  3  |          TYPE         |  varchar |   20  |  0  |   N  |  N  |                    |           type          | 
 |  4  |           OS          |  varchar |   15  |  0  |   N  |  N  |                    |          The operating system         | 
 |  5  |        REQUIRED       |  tinyint |   4   |  0  |   N  |  N  |          0         |          Must         | 
 |  6  |  MAX\_QUEUE\_MINUTES  |    int   |   10  |  0  |   Y  |  N  |         60         |         maximum QUEUE time        | 
 |  7  | MAX\_RUNNING\_MINUTES |    int   |   10  |  0  |   Y  |  N  |         600        |         maximum Run time        | 
 |  8  |         PROPS         |   text   | 65535 |  0  |   Y  |  N  |                    | JSON string of customize extension container front-end form property Field| 
 |  9  |        CREATOR        |  varchar |   50  |  0  |   N  |  N  |       system       |          projectCreator          | 
 |  10 |        MODIFIER       |  varchar |   50  |  0  |   N  |  N  |       system       |          Updated by          | 
 |  11 |      CREATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |          creationTime         | 
 |  12 |      UPDATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |          updateTime         | 

**Table name:** T\_CONTAINER\_RESOURCE\_REL

**Description:**   Pipeline container and buildResource link table 

**Data column:** 

 |  No. |       name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
 | :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: | 
 |  1  |       ID      |  varchar |  32 |  0  |   N  |  Y  |                    |   primary key ID  | 
 |  2  | CONTAINER\_ID |  varchar |  32 |  0  |   N  |  N  |                    | build Container ID| 
 |  3  |  RESOURCE\_ID |  varchar |  32 |  0  |   N  |  N  |                    |  Resource ID| 
 |  4  |    CREATOR    |  varchar |  50 |  0  |   N  |  N  |       system       |   projectCreator| 
 |  5  |    MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |   Updated by| 
 |  6  |  CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  |  UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

 **Table name:** T\_IMAGE 

 **Description:** Image information table 

 **Data column:** 

 |  No. |           name          |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |                  Description                  | 
 | :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----------------------------------: | 
 |  1  |           ID          |  varchar |   32  |  0  |   N  |  Y  |                    |                   primary key                   | 
 |  2  |      IMAGE\_NAME      |  varchar |   64  |  0  |   N  |  N  |                    |                 Image name                 | 
 |  3  |      IMAGE\_CODE      |  varchar |   64  |  0  |   N  |  N  |                    |                 mirror Code                 | 
 |  4  |      CLASSIFY\_ID     |  varchar |   32  |  0  |   N  |  N  |                    |                Service Classification ID                | 
 |  5  |        VERSION        |  varchar |   20  |  0  |   N  |  N  |                    |                  versionNum                 | 
 |  6  |  IMAGE\_SOURCE\_TYPE  |  varchar |   20  |  0  |   N  |  N  |      bkdevops      |      Image source, bkdevops: BK-CI source third: third-party source     | 
 |  7  |    IMAGE\_REPO\_URL   |  varchar |  256  |  0  |   Y  |  N  |                    |                imageRepo address                | 
 |  8  |   IMAGE\_REPO\_NAME   |  varchar |  256  |  0  |   N  |  N  |                    |                Image in repository name               | 
 |  9  |       TICKET\_ID      |  varchar |  256  |  0  |   Y  |  N  |                    |              Ticket ID              | 
 |  10 |     IMAGE\_STATUS     |  tinyint |   4   |  0  |   N  |  N  |                    |              Mirror status, 0: Initialize              | 
 |  11 |   IMAGE\_STATUS\_MSG  |  varchar |  1024 |  0  |   Y  |  N  |                    |            description corresponding to the status, such as the reason for listing failed           | 
 |  12 |      IMAGE\_SIZE      |  varchar |   20  |  0  |   N  |  N  |                    |                 Mirror size                 | 
 |  13 |       IMAGE\_TAG      |  varchar |  256  |  0  |   Y  |  N  |                    |                 mirrorTag                | 
 |  14 |       LOGO\_URL       |  varchar |  256  |  0  |   Y  |  N  |                    |                Logo address                | 
 |  15 |          ICON         |   text   | 65535 |  0  |   Y  |  N  |                    |            Mirror icon (BASE64 string)           | 
 |  16 |        SUMMARY        |  varchar |  256  |  0  |   Y  |  N  |                    |                 summary to Mirroring                 | 
 |  17 |      DESCRIPTION      |   text   | 65535 |  0  |   Y  |  N  |                    |                 Mirror description                 | 
 |  18 |       PUBLISHER       |  varchar |   50  |  0  |   N  |  N  |       system       |                 image publisher                | 
 |  19 |       PUB\_TIME       | datetime |   19  |  0  |   Y  |  N  |                    |                 Release Time                 | 
 |  20 |      LATEST\_FLAG     |    bit   |   1   |  0  |   N  |  N  |                    |      Whether the image is The latest version of, TRUE: Latest FALSE: Not Latest      | 
 |  21 |        CREATOR        |  varchar |   50  |  0  |   N  |  N  |       system       |                  creator                 | 
 |  22 |        MODIFIER       |  varchar |   50  |  0  |   N  |  N  |       system       |                 Updated by                | 
 |  23 |      CREATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 creationTime                 | 
 |  24 |      UPDATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 updateTime                 | 
 |  25 |   AGENT\_TYPE\_SCOPE  |  varchar |   64  |  0  |   N  |  N  |         \[]        |               Supported agent environment               | 
 |  26 |      DELETE\_FLAG     |    bit   |   1   |  0  |   Y  |  N  |        b'0'        |          delete ID true: Yes, false: No          | 
 |  27 |   DOCKER\_FILE\_TYPE  |  varchar |   32  |  0  |   N  |  N  |        INPUT       | dockerFile type (INPUT: fromHand,\*\_LINK: link)| 
 |  28 | DOCKER\_FILE\_CONTENT |   text   | 65535 |  0  |   Y  |  N  |                    |             dockerFile content             | 

**Table name:** T\_IMAGE\_AGENT\_TYPE

 **Description:** link table between image and machine type 

 **Data column:** 

 |  No. |      name     |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |                        Description                       | 
 | :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :---------------------------------------------: | 
 |  1  |      ID     | varchar |  32 |  0  |   N  |  Y  |     |                         primary key                        | 
 |  2  | IMAGE\_CODE | varchar |  64 |  0  |   N  |  N  |     |                       mirror Code                      | 
 |  3  | AGENT\_TYPE | varchar |  32 |  0  |   N  |  N  |     | Machine type PUBLIC\_DEVNET, PUBLIC\_IDC, PUBLIC\_DEVCLOUD| 

 **Table name:** T\_IMAGE\_CATEGORY\_REL 

 **Description:** Image and Category link Table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    primary key    | 
 |  2  | CATEGORY\_ID |  varchar |  32 |  0  |   N  |  N  |                    | Mirror Scope ID| 
 |  3  |   IMAGE\_ID  |  varchar |  32 |  0  |   N  |  N  |                    |  Image ID| 
 |  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   creator| 
 |  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  Updated by| 
 |  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

 **Table name:** T\_IMAGE\_FEATURE 

 **Description:** Image Feature Table 

 **Data column:** 

 |  No. |          name         |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |           Description           | 
 | :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------------------: | 
 |  1  |          ID         |  varchar |  32 |  0  |   N  |  Y  |                    |            primary key            | 
 |  2  |     IMAGE\_CODE     |  varchar | 256 |  0  |   N  |  N  |                    |          mirror Code          | 
 |  3  |     PUBLIC\_FLAG    |    bit   |  1  |  0  |   Y  |  N  |        b'0'        | publicImage, TRUE: Yes FALSE: No| 
 |  4  |   RECOMMEND\_FLAG   |    bit   |  1  |  0  |   Y  |  N  |        b'1'        |   Is it Recommended, TRUE: Yes FALSE: No, it's not| 
 |  5  |       CREATOR       |  varchar |  50 |  0  |   N  |  N  |       system       |           creator          | 
 |  6  |       MODIFIER      |  varchar |  50 |  0  |   N  |  N  |       system       |          Updated by         | 
 |  7  |     CREATE\_TIME    | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |          creationTime          | 
 |  8  |     UPDATE\_TIME    | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |          updateTime          | 
 |  9  | CERTIFICATION\_FLAG |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |  Is it officialCertification, TRUE: Yes FALSE: No| 
 |  10 |        WEIGHT       |    int   |  10 |  0  |   Y  |  N  |                    |     Weight (higher value means higher weight)     | 
 |  11 |     IMAGE\_TYPE     |  tinyint |  4  |  0  |   N  |  N  |          1         |    Image Type: 0: BlueKing Official, 1: third party   | 
 |  12 |     DELETE\_FLAG    |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |   delete ID true: Yes, false: No   | 

**Table name:** T\_IMAGE\_LABEL\_REL

 **Description:** Association between images and label 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    primary key    | 
 |  2  |   LABEL\_ID  |  varchar |  32 |  0  |   N  |  N  |                    | Template label ID| 
 |  3  |   IMAGE\_ID  |  varchar |  32 |  0  |   N  |  N  |                    |  Image ID| 
 |  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   creator| 
 |  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  Updated by| 
 |  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

 **Table name:** T\_IMAGE\_VERSION\_LOG 

 **Description:** Image ChangeLog table 

 **Data column:** 

 |  No. |       name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |                  Description                  | 
 | :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----------------------------------: | 
 |  1  |       ID      |  varchar |   32  |  0  |   N  |  Y  |                    |                   primary key                   | 
 |  2  |   IMAGE\_ID   |  varchar |   32  |  0  |   N  |  N  |                    |                 Image ID                 | 
 |  3  | RELEASE\_TYPE |  tinyint |   4   |  0  |   N  |  N  |                    | Release Type, 0: New listing 1: Non-Compatibility Upgrade 2: Compatibility Feature Update 3: Compatibility issues fixed| 
 |  4  |    CONTENT    |   text   | 65535 |  0  |   N  |  N  |                    |                Log Content                | 
 |  5  |    CREATOR    |  varchar |   50  |  0  |   N  |  N  |       system       |                  creator                 | 
 |  6  |    MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |                 Updated by                | 
 |  7  |  CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 creationTime                 | 
 |  8  |  UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 updateTime                 | 

 **Table name:** T\_LABEL 

 **Description:** Atom label information table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |   primary key ID  | 
 |  2  |  LABEL\_CODE |  varchar |  32 |  0  |   N  |  N  |                    | Mirror label Code| 
 |  3  |  LABEL\_NAME |  varchar |  32 |  0  |   N  |  N  |                    |  label name| 
 |  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   projectCreator| 
 |  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |   Updated by| 
 |  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 
 |  8  |     TYPE     |  tinyint |  4  |  0  |   N  |  N  |          0         |   type   | 

**Table name:** T\_LOGO

 **Description:** store logo information table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |     primary key ID   | 
 |  2  |     TYPE     |  varchar |  16 |  0  |   N  |  N  |                    |     type    | 
 |  3  |   LOGO\_URL  |  varchar | 512 |  0  |   N  |  N  |                    | LOGOURL address| 
 |  4  |     LINK     |  varchar | 512 |  0  |   Y  |  N  |                    |    location link   | 
 |  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |    projectCreator    | 
 |  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |    Updated by    | 
 |  7  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 
 |  8  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    Change the time   | 
 |  9  |     ORDER    |    int   |  10 |  0  |   N  |  N  |          0         |    Display order   | 

 **Table name:** T\_REASON 

 **Description:** Reason definition Table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :---: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    primary key   | 
 |  2  |     TYPE     |  varchar |  32 |  0  |   N  |  N  |                    |   type| 
 |  3  |    CONTENT   |  varchar | 512 |  0  |   N  |  N  |                    |  Log Content| 
 |  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |  creator| 
 |  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       | Updated by| 
 |  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 
 |  8  |    ENABLE    |    bit   |  1  |  0  |   N  |  N  |        b'1'        |  Enable| 
 |  9  |     ORDER    |    int   |  10 |  0  |   N  |  N  |          0         |  Display order| 

 **Table name:** T\_REASON\_REL 

 **Description:** Reason and Components link 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |      ID      |  varchar |   32  |  0  |   N  |  Y  |                    |      primary key     | 
 |  2  |     TYPE     |  varchar |   32  |  0  |   N  |  N  |                    |     type    | 
 |  3  |  STORE\_CODE |  varchar |   64  |  0  |   N  |  N  |                    | store Components code| 
 |  4  |  STORE\_TYPE |  tinyint |   4   |  0  |   N  |  N  |          0         | store Components type| 
 |  5  |  REASON\_ID  |  varchar |   32  |  0  |   N  |  N  |                    |    Cause ID   | 
 |  6  |     NOTE     |   text   | 65535 |  0  |   Y  |  N  |                    |    Reason Description   | 
 |  7  |    CREATOR   |  varchar |   50  |  0  |   N  |  N  |       system       |    creator    | 
 |  8  | CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 

**Table name:** T\_STORE\_APPROVE

 **Description:** toCheck Form 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |      ID      |  varchar |   32  |  0  |   N  |  Y  |                    |     primary key ID   | 
 |  2  |  STORE\_CODE |  varchar |   64  |  0  |   N  |  N  |                    | store Components code| 
 |  3  |  STORE\_TYPE |  tinyint |   4   |  0  |   N  |  N  |          0         | store Components type| 
 |  4  |    CONTENT   |   text   | 65535 |  0  |   N  |  N  |                    |    Log Content   | 
 |  5  |   APPLICANT  |  varchar |   50  |  0  |   N  |  N  |                    |    Applicant    | 
 |  6  |     TYPE     |  varchar |   64  |  0  |   Y  |  N  |                    |     type    | 
 |  7  |    STATUS    |  varchar |   64  |  0  |   Y  |  N  |                    |     status    | 
 |  8  |   APPROVER   |  varchar |   50  |  0  |   Y  |  N  |                    |    Approved by    | 
 |  9  | APPROVE\_MSG |  varchar |  256  |  0  |   Y  |  N  |                    |    Approval Information   | 
 |  10 |    CREATOR   |  varchar |   50  |  0  |   N  |  N  |       system       |    projectCreator    | 
 |  11 |   MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |   Updated by   | 
 |  12 | CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 
 |  13 | UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime   | 

 **Table name:** T\_STORE\_BUILD\_APP\_REL 

 **Description:** Relationship between store build and compilation environment 

 **Data column:** 

 |  No. |        name        |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |                 Description                | 
 | :-: | :--------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------------------------------: | 
 |  1  |        ID        |  varchar |  32 |  0  |   N  |  Y  |                    |                  primary key                 | 
 |  2  |  BUILD\_INFO\_ID |  varchar |  32 |  0  |   N  |  N  |                    | build Info Id(corresponding to T\_STORE\_BUILD\_INFO primary key )| 
 |  3  | APP\_VERSION\_ID |    int   |  10 |  0  |   Y  |  N  |                    |   Compilation environment version Id(corresponding to T\_APP\_VERSION primary key )   | 
 |  4  |      CREATOR     |  varchar |  50 |  0  |   N  |  N  |       system       |                creator                | 
 |  5  |     MODIFIER     |  varchar |  50 |  0  |   N  |  N  |       system       |               Updated by               | 
 |  6  |   CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                creationTime               | 
 |  7  |   UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                updateTime               | 

 **Table name:** T\_STORE\_BUILD\_INFO 

 **Description:** Information table for building store components 

 **Data column:** 

 |  No. |           name          |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |                 Description                | 
 | :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------------------------------: | 
 |  1  |           ID          |  varchar |   32  |  0  |   N  |  Y  |                    |                  primary key                 | 
 |  2  |        LANGUAGE       |  varchar |   64  |  0  |   Y  |  N  |                    |                Development language               | 
 |  3  |         SCRIPT        |   text   | 65535 |  0  |   N  |  N  |                    |                Package Script               | 
 |  4  |        CREATOR        |  varchar |   50  |  0  |   N  |  N  |       system       |                creator                | 
 |  5  |        MODIFIER       |  varchar |   50  |  0  |   N  |  N  |       system       |               Updated by               | 
 |  6  |      CREATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                creationTime               | 
 |  7  |      UPDATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                updateTime               | 
 |  8  |    REPOSITORY\_PATH   |  varchar |  500  |  0  |   Y  |  N  |                    |               Code storage path              | 
 |  9  |         ENABLE        |    bit   |   1   |  0  |   N  |  N  |        b'1'        |             Enable 1 Enable 0 Disable            | 
 |  10 | SAMPLE\_PROJECT\_PATH |  varchar |  500  |  0  |   N  |  N  |                    |               Sample Project path              | 
 |  11 |      STORE\_TYPE      |  tinyint |   4   |  0  |   N  |  N  |          0         | store Components type 0: Plugin 1: Template 2: Image 3: IDE Plugin 4: micro-expansion| 

**Table name:** T\_STORE\_COMMENT

 **Description:** Store Components comment information table 

 **Data column:** 

 |  No. |        name        |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |     Description     | 
 | :-: | :--------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--------: | 
 |  1  |        ID        |  varchar |   32  |  0  |   N  |  Y  |                    |     primary key ID    | 
 |  2  |     STORE\_ID    |  varchar |   32  |  0  |   N  |  N  |                    |   store Component ID   | 
 |  3  |    STORE\_CODE   |  varchar |   64  |  0  |   N  |  N  |                    |  store Components code| 
 |  4  | COMMENT\_CONTENT |   text   | 65535 |  0  |   N  |  N  |                    |    content    | 
 |  5  |  COMMENTER\_DEPT |  varchar |  200  |  0  |   N  |  N  |                    |  Reviewer architecture Information| 
 |  6  |       SCORE      |    int   |   10  |  0  |   N  |  N  |                    |     Score     | 
 |  7  |   PRAISE\_COUNT  |    int   |   10  |  0  |   Y  |  N  |          0         |    Count of likes    | 
 |  8  |   PROFILE\_URL   |  varchar |  256  |  0  |   Y  |  N  |                    | Commenter avatar url address| 
 |  9  |    STORE\_TYPE   |  tinyint |   4   |  0  |   N  |  N  |          0         |  store Components type| 
 |  10 |      CREATOR     |  varchar |   50  |  0  |   N  |  N  |       system       |     projectCreator    | 
 |  11 |     MODIFIER     |  varchar |   50  |  0  |   N  |  N  |       system       |     Updated by    | 
 |  12 |   CREATE\_TIME   | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime    | 
 |  13 |   UPDATE\_TIME   | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime    | 

 **Table name:** T\_STORE\_COMMENT\_PRAISE 

 **Description:** Store Components comment and like information table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |  primary key ID | 
 |  2  |  COMMENT\_ID |  varchar |  32 |  0  |   N  |  N  |                    | Comment ID| 
 |  3  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |  projectCreator| 
 |  4  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  Updated by| 
 |  5  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  6  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

 **Table name:** T\_STORE\_COMMENT\_REPLY 

 **Description:** store Components comment reply information table 

 **Data column:** 

 |  No. |        name       |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |     Description     | 
 | :-: | :-------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--------: | 
 |  1  |        ID       |  varchar |   32  |  0  |   N  |  Y  |                    |     primary key ID    | 
 |  2  |   COMMENT\_ID   |  varchar |   32  |  0  |   N  |  N  |                    |    Comment ID    | 
 |  3  |  REPLY\_CONTENT |   text   | 65535 |  0  |   Y  |  N  |                    |    Reply content    | 
 |  4  |   PROFILE\_URL  |  varchar |  256  |  0  |   Y  |  N  |                    | Commenter avatar url address| 
 |  5  | REPLY\_TO\_USER |  varchar |   50  |  0  |   Y  |  N  |                    |    Respondent    | 
 |  6  |  REPLYER\_DEPT  |  varchar |  200  |  0  |   N  |  N  |                    |  Respondent architecture| 
 |  7  |     CREATOR     |  varchar |   50  |  0  |   N  |  N  |       system       |     projectCreator    | 
 |  8  |     MODIFIER    |  varchar |   50  |  0  |   N  |  N  |       system       |     Updated by    | 
 |  9  |   CREATE\_TIME  | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime    | 
 |  10 |   UPDATE\_TIME  | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime    | 

**Table name:** T\_STORE\_DEPT\_REL

 **Description:** Relationship between store Components and organizations 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length  | decimal place | Allow Null |   primary key  |         defaultValue        |     Description     | 
 | :-: | :----------: | :------: | :--: | :-: | :--: | :-: | :----------------: | :--------: | 
 |  1  |      ID      |  varchar |  32  |  0  |   N  |  Y  |                    |     primary key ID    | 
 |  2  |  STORE\_CODE |  varchar |  64  |  0  |   N  |  N  |                    |  store Components code| 
 |  3  |   DEPT\_ID   |    int   |  10  |  0  |   N  |  N  |                    | ID of secondary institution of the project| 
 |  4  |  DEPT\_NAME  |  varchar | 1024 |  0  |   N  |  N  |                    | Name of secondary institution of the project| 
 |  5  |    STATUS    |  tinyint |   4  |  0  |   N  |  N  |          0         |     status     | 
 |  6  |    COMMENT   |  varchar |  256 |  0  |   Y  |  N  |                    |     Commentary     | 
 |  7  |    CREATOR   |  varchar |  50  |  0  |   N  |  N  |       system       |     projectCreator    | 
 |  8  |   MODIFIER   |  varchar |  50  |  0  |   N  |  N  |       system       |     Updated by    | 
 |  9  | CREATE\_TIME | datetime |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime    | 
 |  10 | UPDATE\_TIME | datetime |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime    | 
 |  11 |  STORE\_TYPE |  tinyint |   4  |  0  |   N  |  N  |          0         |  store Components type| 

 **Table name:** T\_STORE\_ENV\_VAR 

 **Description:** Env Variables information table 

 **Data column:** 

 |  No. |       name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |              Description              | 
 | :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--------------------------: | 
 |  1  |       ID      |  varchar |   32  |  0  |   N  |  Y  |                    |               primary key               | 
 |  2  |  STORE\_CODE  |  varchar |   64  |  0  |   N  |  N  |                    |             Components coding             | 
 |  3  |  STORE\_TYPE  |  tinyint |   4   |  0  |   N  |  N  |          0         | Components type 0: Plugin 1: Template 2: Image 3: IDE Plugin 4: Microextensions| 
 |  4  |   VAR\_NAME   |  varchar |   64  |  0  |   N  |  N  |                    |              Name             | 
 |  5  |   VAR\_VALUE  |   text   | 65535 |  0  |   N  |  N  |                    |              value             | 
 |  6  |   VAR\_DESC   |   text   | 65535 |  0  |   Y  |  N  |                    |              description              | 
 |  7  |     SCOPE     |  varchar |   16  |  0  |   N  |  N  |                    |    Effective Range TEST: Test PRD: Officially ALL: all   | 
 |  8  | ENCRYPT\_FLAG |    bit   |   1   |  0  |   Y  |  N  |        b'0'        |      Whether to encryption, TRUE: Yes FALSE: No      | 
 |  9  |    VERSION    |    int   |   10  |  0  |   N  |  N  |          1         |              versionNum             | 
 |  10 |    CREATOR    |  varchar |   50  |  0  |   N  |  N  |       system       |              creator             | 
 |  11 |    MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |             Updated by            | 
 |  12 |  CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |             creationTime             | 
 |  13 |  UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |             updateTime             | 

 **Table name:** T\_STORE\_MEDIA\_INFO 

 **Description:** Media Information Table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |          defaultValue          |                 Description                | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :-------------------------------: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                       |                  primary key                 | 
 |  2  |  STORE\_CODE |  varchar |  64 |  0  |   N  |  N  |                       |             store Components identification             | 
 |  3  |  MEDIA\_URL  |  varchar | 256 |  0  |   N  |  N  |                       |               Media resources link              | 
 |  4  |  MEDIA\_TYPE |  varchar |  32 |  0  |   N  |  N  |                       |      Media Resource type PICTURE: Picture VIDEO: Video     | 
 |  5  |  STORE\_TYPE |  tinyint |  4  |  0  |   N  |  N  |           0           | store Components type 0: Plugin 1: Template 2: Image 3: IDE Plugin 4: micro-expansion| 
 |  6  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |         system        |                creator                | 
 |  7  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |         system        |               Updated by               | 
 |  8  | CREATE\_TIME | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |                creationTime               | 
 |  9  | UPDATE\_TIME | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |                updateTime               | 

**Table name:** T\_STORE\_MEMBER

 **Description:** store Components member information table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |     primary key ID   | 
 |  2  |  STORE\_CODE |  varchar |  64 |  0  |   N  |  N  |                    | store Components code| 
 |  3  |   USERNAME   |  varchar |  64 |  0  |   N  |  N  |                    |    user name   | 
 |  4  |     TYPE     |  tinyint |  4  |  0  |   N  |  N  |                    |     type    | 
 |  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |    projectCreator    | 
 |  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |    Updated by    | 
 |  7  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 
 |  8  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime   | 
 |  9  |  STORE\_TYPE |  tinyint |  4  |  0  |   N  |  N  |          0         | store Components type| 

 **Table name:** T\_STORE\_OPT\_LOG 

 **Description:** store Log table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |     primary key ID   | 
 |  2  |  STORE\_CODE |  varchar |  64 |  0  |   N  |  N  |                    | store Components code| 
 |  3  |  STORE\_TYPE |  tinyint |  4  |  0  |   N  |  N  |          0         | store Components type| 
 |  4  |   OPT\_TYPE  |  varchar |  64 |  0  |   N  |  N  |                    |    Type   | 
 |  5  |   OPT\_DESC  |  varchar | 512 |  0  |   N  |  N  |                    |    Operation content   | 
 |  6  |   OPT\_USER  |  varchar |  64 |  0  |   N  |  N  |                    |    Operation user   | 
 |  7  |   OPT\_TIME  | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    operateTime   | 
 |  8  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |    projectCreator    | 
 |  9  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 

 **Table name:** T\_STORE\_PIPELINE\_BUILD\_REL 

 **Description:** store Components build link relation table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    primary key    | 
 |  2  |   STORE\_ID  |  varchar |  32 |  0  |   N  |  N  |                    | store Component ID| 
 |  3  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |                    |  pipelineId| 
 |  4  |   BUILD\_ID  |  varchar |  34 |  0  |   N  |  N  |                    |  build ID| 
 |  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   creator| 
 |  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  Updated by| 
 |  7  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  8  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

**Table name:** T\_STORE\_PIPELINE\_REL

 **Description:** Relationship between store Components and Pipeline 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |             Description            | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----------------------: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |              primary key             | 
 |  2  |  STORE\_CODE |  varchar |  64 |  0  |   N  |  N  |                    |           store Components Code          | 
 |  3  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |                    |           pipelineId           | 
 |  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |            creator            | 
 |  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |           Updated by           | 
 |  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |            creationTime           | 
 |  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |            updateTime           | 
 |  8  |  STORE\_TYPE |  tinyint |  4  |  0  |   N  |  N  |          0         | store Components type 0: Plugin 1: Template 2: Image 3: IDE Plugin| 

 **Table name:** T\_STORE\_PROJECT\_REL 

 **Description:** link relationship between store Components and project 

 **Data column:** 

 |  No. |       name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |       ID      |  varchar |  32 |  0  |   N  |  Y  |                    |     primary key ID   | 
 |  2  |  STORE\_CODE  |  varchar |  64 |  0  |   N  |  N  |                    | store Components code| 
 |  3  | PROJECT\_CODE |  varchar |  32 |  0  |   N  |  N  |                    |  userGroup Project| 
 |  4  |      TYPE     |  tinyint |  4  |  0  |   N  |  N  |                    |     type    | 
 |  5  |    CREATOR    |  varchar |  50 |  0  |   N  |  N  |       system       |    projectCreator    | 
 |  6  |    MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |    Updated by    | 
 |  7  |  CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 
 |  8  |  UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime   | 
 |  9  |  STORE\_TYPE  |  tinyint |  4  |  0  |   N  |  N  |          0         | store Components type| 

 **Table name:** T\_STORE\_RELEASE 

 **Description:** Information table for Release upgrading store components 

 **Data column:** 

 |  No. |           name          |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |              Description              | 
 | :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------------------------: | 
 |  1  |           ID          |  varchar |  32 |  0  |   N  |  Y  |                    |               primary key               | 
 |  2  |      STORE\_CODE      |  varchar |  64 |  0  |   N  |  N  |                    |           store Components Code          | 
 |  3  |  FIRST\_PUB\_CREATOR  |  varchar |  64 |  0  |   N  |  N  |                    |             First Publisher            | 
 |  4  |    FIRST\_PUB\_TIME   | datetime |  19 |  0  |   N  |  N  |                    |            First Release Time            | 
 |  5  |    LATEST\_UPGRADER   |  varchar |  64 |  0  |   N  |  N  |                    |             Recent Promoted By            | 
 |  6  | LATEST\_UPGRADE\_TIME | datetime |  19 |  0  |   N  |  N  |                    |            Recent Upgrade time            | 
 |  7  |      STORE\_TYPE      |  tinyint |  4  |  0  |   N  |  N  |          0         | store Components type 0: Plugin 1: Template 2: Image 3: IDE Plugin| 
 |  8  |        CREATOR        |  varchar |  64 |  0  |   N  |  N  |       system       |              creator             | 
 |  9  |        MODIFIER       |  varchar |  64 |  0  |   N  |  N  |       system       |             Updated by            | 
 |  10 |      CREATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |             creationTime             | 
 |  11 |      UPDATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |             updateTime             | 

 **Table name:** T\_STORE\_SENSITIVE\_API 

 **Description:** Sensitive API Information Table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length  | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :----------: | :------: | :--: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |      ID      |  varchar |  32  |  0  |   N  |  Y  |                    |     primary key ID   | 
 |  2  |  STORE\_CODE |  varchar |  64  |  0  |   N  |  N  |                    | store Components code| 
 |  3  |  STORE\_TYPE |  tinyint |   4  |  0  |   N  |  N  |          0         | store Components type| 
 |  4  |   API\_NAME  |  varchar |  64  |  0  |   N  |  N  |                    |   APIname   | 
 |  5  |  ALIAS\_NAME |  varchar |  64  |  0  |   N  |  N  |                    |     aliasName    | 
 |  6  |  API\_STATUS |  varchar |  64  |  0  |   N  |  N  |                    |   API status   | 
 |  7  |  API\_LEVEL  |  varchar |  64  |  0  |   N  |  N  |                    |   API grade   | 
 |  8  |  APPLY\_DESC |  varchar | 1024 |  0  |   Y  |  N  |                    |    apply Description   | 
 |  9  | APPROVE\_MSG |  varchar | 1024 |  0  |   Y  |  N  |                    |    Approval Information   | 
 |  10 |    CREATOR   |  varchar |  50  |  0  |   N  |  N  |                    |    projectCreator    | 
 |  11 |   MODIFIER   |  varchar |  50  |  0  |   N  |  N  |                    |    Updated by    | 
 |  12 | CREATE\_TIME | datetime |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 
 |  13 | UPDATE\_TIME | datetime |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime   | 

 **Table name:** T\_STORE\_SENSITIVE\_CONF 

 **Description:** store Private setting table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |      ID      |  varchar |   32  |  0  |   N  |  Y  |                    |     primary key ID   | 
 |  2  |  STORE\_CODE |  varchar |   64  |  0  |   N  |  N  |                    | store Components code| 
 |  3  |  STORE\_TYPE |  tinyint |   4   |  0  |   N  |  N  |          0         | store Components type| 
 |  4  |  FIELD\_NAME |  varchar |   64  |  0  |   N  |  N  |                    |    Field name   | 
 |  5  | FIELD\_VALUE |   text   | 65535 |  0  |   N  |  N  |                    |    Field value    | 
 |  6  |  FIELD\_DESC |   text   | 65535 |  0  |   Y  |  N  |                    |    Field description   | 
 |  7  |    CREATOR   |  varchar |   50  |  0  |   N  |  N  |       system       |    projectCreator    | 
 |  8  |   MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |    Updated by    | 
 |  9  | CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 
 |  10 | UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime   | 
 |  11 |  FIELD\_TYPE |  varchar |   16  |  0  |   Y  |  N  |       BACKEND      |    Type   | 

 **Table name:** T\_STORE\_STATISTICS 

 **Description:** store statistics table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |     primary key ID   | 
 |  2  |   STORE\_ID  |  varchar |  32 |  0  |   N  |  N  |                    |   store Component ID| 
 |  3  |  STORE\_CODE |  varchar |  64 |  0  |   N  |  N  |                    | store Components code| 
 |  4  |   DOWNLOADS  |    int   |  10 |  0  |   Y  |  N  |                    |    download    | 
 |  5  |    COMMITS   |    int   |  10 |  0  |   Y  |  N  |                    |    Quantity of comments   | 
 |  6  |     SCORE    |    int   |  10 |  0  |   Y  |  N  |                    |     Score    | 
 |  7  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |    projectCreator    | 
 |  8  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |    Updated by    | 
 |  9  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 
 |  10 | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime   | 
 |  11 |  STORE\_TYPE |  tinyint |  4  |  0  |   N  |  N  |          0         | store Components type| 

 **Table name:** T\_STORE\_STATISTICS\_DAILY 

 **Description:** Daily statistics of store 

 **Data column:** 

 |  No. |          name         |   Type Of Data   |  length  | decimal place | Allow Null |   primary key  |          defaultValue          |    Description    | 
 | :-: | :-----------------: | :------: | :--: | :-: | :--: | :-: | :-------------------: | :------: | 
 |  1  |          ID         |  varchar |  32  |  0  |   N  |  Y  |                       |     primary key     | 
 |  2  |     STORE\_CODE     |  varchar |  64  |  0  |   N  |  N  |                       |   Components coding   | 
 |  3  |     STORE\_TYPE     |  tinyint |   4  |  0  |   N  |  N  |           0           |   Components type   | 
 |  4  |   TOTAL\_DOWNLOADS  |    int   |  10  |  0  |   Y  |  N  |           0           |   Total download   | 
 |  5  |   DAILY\_DOWNLOADS  |    int   |  10  |  0  |   Y  |  N  |           0           |   Daily download| 
 |  6  | DAILY\_SUCCESS\_NUM |    int   |  10  |  0  |   Y  |  N  |           0           |  Number of SUCCEED per day| 
 |  7  |   DAILY\_FAIL\_NUM  |    int   |  10  |  0  |   Y  |  N  |           0           | total number fail per Day| 
 |  8  | DAILY\_FAIL\_DETAIL |  varchar | 4096 |  0  |   Y  |  N  |                       | Daily fail detail| 
 |  9  |   STATISTICS\_TIME  | datetime |  23  |  0  |   N  |  N  |                       |   statistical time   | 
 |  10 |     CREATE\_TIME    | datetime |  23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   creationTime   | 
 |  11 |     UPDATE\_TIME    | datetime |  23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   updateTime   | 

 **Table name:** T\_STORE\_STATISTICS\_TOTAL 

 **Description:** All statistics 

 **Data column:** 

 |  No. |          name          |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :------------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |          ID          |  varchar |  32 |  0  |   N  |  Y  |                    |     primary key ID   | 
 |  2  |      STORE\_CODE     |  varchar |  64 |  0  |   N  |  N  |                    | store Components code| 
 |  3  |      STORE\_TYPE     |  tinyint |  4  |  0  |   N  |  N  |          0         | store Components type| 
 |  4  |       DOWNLOADS      |    int   |  10 |  0  |   Y  |  N  |          0         |    download    | 
 |  5  |        COMMITS       |    int   |  10 |  0  |   Y  |  N  |          0         |    Quantity of comments   | 
 |  6  |         SCORE        |    int   |  10 |  0  |   Y  |  N  |          0         |     Score    | 
 |  7  |    SCORE\_AVERAGE    |  decimal |  4  |  1  |   Y  |  N  |         0.0        |    Comments are equally divided   | 
 |  8  |     PIPELINE\_NUM    |    int   |  10 |  0  |   Y  |  N  |          0         |   Quantity of Pipeline   | 
 |  9  | RECENT\_EXECUTE\_NUM |    int   |  10 |  0  |   Y  |  N  |          0         |   latestExec| 
 |  10 |     CREATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 
 |  11 |     UPDATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime   | 

 **Table name:** T\_TEMPLATE 

 **Description:** Template Info Table 

 **Data column:** 

 |  No. |           name          |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
 | :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------: | 
 |  1  |           ID          |  varchar |   32  |  0  |   N  |  Y  |                    |     primary key ID   | 
 |  2  |     TEMPLATE\_NAME    |  varchar |  200  |  0  |   N  |  N  |                    |    Template name   | 
 |  3  |     TEMPLATE\_CODE    |  varchar |   32  |  0  |   N  |  N  |                    |    template Code   | 
 |  4  |      CLASSIFY\_ID     |  varchar |   32  |  0  |   N  |  N  |                    |   Service Classification ID| 
 |  5  |        VERSION        |  varchar |   20  |  0  |   N  |  N  |                    |    versionNum    | 
 |  6  |     TEMPLATE\_TYPE    |  tinyint |   4   |  0  |   N  |  N  |          1         |    Template type   | 
 |  7  |   TEMPLATE\_RD\_TYPE  |  tinyint |   4   |  0  |   N  |  N  |          1         |   Template R & D type| 
 |  8  |    TEMPLATE\_STATUS   |  tinyint |   4   |  0  |   N  |  N  |                    |    Template status   | 
 |  9  | TEMPLATE\_STATUS\_MSG |  varchar |  1024 |  0  |   Y  |  N  |                    |   Template status information| 
 |  10 |       LOGO\_URL       |  varchar |  256  |  0  |   Y  |  N  |                    | LOGOURL address| 
 |  11 |        SUMMARY        |  varchar |  256  |  0  |   Y  |  N  |                    |     summary    | 
 |  12 |      DESCRIPTION      |   text   | 65535 |  0  |   Y  |  N  |                    |     description    | 
 |  13 |       PUBLISHER       |  varchar |   50  |  0  |   N  |  N  |       system       |   atomic publisher   | 
 |  14 |    PUB\_DESCRIPTION   |   text   | 65535 |  0  |   Y  |  N  |                    |    Release Description   | 
 |  15 |      PUBLIC\_FLAG     |    bit   |   1   |  0  |   N  |  N  |        b'0'        |  Is it a publicImage| 
 |  16 |      LATEST\_FLAG     |    bit   |   1   |  0  |   N  |  N  |                    | Is the The latest version of atom| 
 |  17 |        CREATOR        |  varchar |   50  |  0  |   N  |  N  |       system       |    projectCreator    | 
 |  18 |        MODIFIER       |  varchar |   50  |  0  |   N  |  N  |       system       |    Updated by    | 
 |  19 |      CREATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 
 |  20 |      UPDATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime   | 
 |  21 |       PUB\_TIME       | datetime |   19  |  0  |   Y  |  N  |                    |    Release Time   | 

 **Table name:** T\_TEMPLATE\_CATEGORY\_REL 

 **Description:** Template and Category link Table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |   primary key ID  | 
 |  2  | CATEGORY\_ID |  varchar |  32 |  0  |   N  |  N  |                    | Mirror Scope ID| 
 |  3  | TEMPLATE\_ID |  varchar |  32 |  0  |   N  |  N  |                    |  Template ID| 
 |  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   projectCreator| 
 |  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |   Updated by| 
 |  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

 **Table name:** T\_TEMPLATE\_LABEL\_REL 

 **Description:** Template and label link Table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |  primary key ID | 
 |  2  |   LABEL\_ID  |  varchar |  32 |  0  |   N  |  N  |                    | label ID| 
 |  3  | TEMPLATE\_ID |  varchar |  32 |  0  |   N  |  N  |                    | Template ID| 
 |  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |  projectCreator| 
 |  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  Updated by| 
 |  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 
