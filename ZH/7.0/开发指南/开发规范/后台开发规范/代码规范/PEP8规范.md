## 【必须】PEP 8 规范

PEP 8 python 编码规范：<https://www.python.org/dev/peps/pep-0008/>

- Eclipse 中配置 PEP 8 代码提示

    将 PyDev 升级到高于 2.3.0 版本，打开 `Window > Preferences > PyDev > Editor > Code Analysis > pep8.py` 设置即可

- PyCharm 配置 PEP 8 代码提示

    直接在右下角调整 Highlighting Level 为 Inspections 就能自动 PEP 8 提示

    ![PEP 8 代码提示](media/d1aeaac81c790a1692ba66c6367cdaa1.png)

- 建议修改在使用的 IDE 中修改 PEP8 的每行字数不超 79 字符规范，可修改为 Django 建议的 119 字符

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
