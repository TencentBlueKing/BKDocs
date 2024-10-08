[toc]

## Authentication

### Concept

- **Application authentication**: BlueKing PaaS platform will assign a unique `bk_app_code` and corresponding `bk_app_secret` to each application for application authentication; if the API has `application authentication` enabled, the caller needs to provide a valid `bk_app_code/bk_app_secret` in the request header, and the gateway will verify whether the application is legitimate
- **User authentication**: BlueKing unified login will assign a unique login state `bk_token` (in the cookie) to each logged-in user for user authentication; if the API has `user authentication` enabled, the caller needs to provide a valid `bk_token` in the request header, and the gateway will verify whether the user is legitimate
- **Access verification**: Some APIs have `access verification` enabled, so the application developer needs to apply for the permission for the application to call the API** at the BlueKing Developer Center. After approval, the BlueKing application can call the API, otherwise it will return no permission; Note: `Verify access rights` requires that the API has `application authentication` enabled. The gateway needs to use `bk_app_code` that has passed `application authentication` for permission verification
- **access_token**: BlueKing's bkauth (old version of ssm) and other services provide `access_token` issuance, supporting the issuance of `application identity access_token` (representing an authenticated application) and `application + user identity access_token` (representing an authenticated application + authenticated user); In scenarios where the gateway API is called without user login/scheduled tasks/scripts, `access_token` can be used instead of `bk_app_code/bk_app_secret/bk_token`

### Authentication Header

```
X-Bkapi-Authorization: {}
```

Example:

```
# Call target API to enable: application authentication + user authentication
X-Bkapi-Authorization: {"bk_app_code": "x", "bk_app_secret": "y", "bk_token": "z"}

# Call target API to enable: application authentication
X-Bkapi-Authorization: {"bk_app_code": "x", "bk_app_secret": "y"}

# Call target API to enable: user authentication
X-Bkapi-Authorization: {"bk_token": "z"}

# Use access_token
X-Bkapi-Authorization: {"access_token": "z"}

# Use jwt + access_toen, mainly used to solve: user -> apigwA -> backend -> apigwB middle backend access apigwB user authentication problem
X-Bkapi-Authorization: {"jwt":"xxxx", "access_token": "z"}

```

`curl` request example:

```
curl 'http://bkapi.example.com/prod/users/'
-H 'X-Bkapi-Authorization: {"bk_app_code": "x", "bk_app_secret": "y", "bk_token": "z"}'
```

## FAQ

### 1. If bk_app_code+bk_app_secret+bk_token+access_token are passed at the same time, which one will take effect?

> Such mixed use is prohibited. Access_token can only be used alone. Do not use access_tokens of unknown origin or reuse access_tokens generated by other platforms.

Example: `X-Bkapi-Authorization: {"bk_app_code": "app1", "bk_app_secret": "xxx", "bk_token": "yyy", "access_token": "zzz"`, bk_token corresponds to the user `user1`, access_token issued by `app_code=app2`/`bk_username=user2`

At this time, the application **app2** that issued this `access_token = zzz` and the user **user2** passed in when issuing it are effective, instead of the application **app1 ** in the request header + the `bk_token` in the request header corresponding to the user **user1**;

So at this time, it may appear

1. Error: application `app2` has no permission (because it is app2 that is effective)

2. The returned data is the data of `user2` (because the effective one is user2)