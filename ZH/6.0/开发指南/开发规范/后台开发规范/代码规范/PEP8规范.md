## 【必须】PEP 8规范

PEP 8 python编码规范：<https://www.python.org/dev/peps/pep-0008/>

- Eclipse 中配置PEP 8 代码提示

    将PyDev 升级到高于2.3.0版本，打开 `Window > Preferences > PyDev > Editor > Code Analysis > pep8.py` 设置即可

- PyCharm 配置PEP 8 代码提示

    直接在右下角调整Highlighting Level 为 Inspections 就能自动PEP 8提示

    ![PEP 8 代码提示](media/d1aeaac81c790a1692ba66c6367cdaa1.png)

- 建议修改在使用的IDE中修改PEP8的每行字数不超79字符规范，可修改为Django建议的119字符

## Flake8 推荐配置

```ini
[flake8]
ignore =
    ;W503 line break before binary operator
    W503,

max-line-length = 120
max-complexity = 25

; exclude file
exclude =
    .tox,
    .git,
    __pycache__,
    build,
    dist,
    *.pyc,
    *.egg-info,
    .cache,
    .eggs
```
