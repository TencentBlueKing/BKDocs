# Deploy SaaS to test/official environment

## Create test environment and official environment database

Prepare MySQL Server, create test environment and official environment database, and ensure that the `appt` and `appt` servers configured in `install.config` can access the DB

And modify `config/prod.py` and `stag.py`

## Submit code to the repository

- Install [Git](https://www.git-scm.com/download/win)

- Use `Git Bash` to right-click and open the project root directory

![Open directory with git](../assets/%E4%BD%BF%E7%94%A8git%E6%89%93%E5%BC%80%E7%9B%AE%E5%BD%95.png)

- Submit the project to the repository

```bash
git init
git remote add origin {GIT_Repository_URL}
git add .
git commit -m "add blueking framework2.0"
git push -u origin master
```

## Deploy to the test environment and the official environment in the developer center

- Deployment in the test environment

`Developer Center` - `My Application` - `Deployment` - `One-click deployment in the test environment`

- Deployment in the official environment

`Developer Center` - `My Application` - `Deployment` - `One-click deployment in the official environment`