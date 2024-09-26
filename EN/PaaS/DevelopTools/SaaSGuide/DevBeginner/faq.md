# FAQ
## What are the recommended IDEs

For example, `Visio Studio Code`
![Visio_Studio_Code](../assets/Visio_Studio_Code.png)

- Set the language to Chinese
- macOS: `Command+Shift+P` Select `Configure Display Language`
- Windows: `Ctrl+Shift+P` Select `Configure Display Language`

- Remember the git account

```bash
git config --global credential.helper store
```

## How to isolate multiple development environments

Use [pipenv](https://zhuanlan.zhihu.com/p/37581807) to isolate multiple development environments locally
![pipenv](../assets/pipenv.png)

- What to do if the user environment variables are not loaded when entering the `pipenv` environment?

You can modify the `activate` file that is prompted when entering the virtual environment through `pipenv shell`, and append the corresponding command to the file.

For example, add the following line, and use `ll` to view the file list.

```bash
alias ll="ls -lh"
```

For detailed solutions, please refer to [python multi-environment development solution](../DevBasics/PYTHON2_3.md).