# Gateway authentication scheme

API Gateway supports authentication of request sources, including: **BlueKing Application Authentication** and **User Authentication**.

When requesting the gateway API, if the gateway API requires authentication application, but the authentication application fails, or requires user authentication, but authentication user fails, the gateway will directly respond with an error and will not request the backend interface;
Otherwise, the gateway will request the backend interface and pass the authentication information to the backend interface so that the backend interface can obtain the currently requested BlueKing application or user.

## Authentication request source

Sources of gateway authentication requests include **BlueKing Application Authentication** and **User Authentication**. When requesting the gateway API, the authentication information should be placed in the request header `X-Bkapi-Authorization`, and the value is a JSON format string, for example:
```
X-Bkapi-Authorization: {"bk_app_code": "x", "bk_app_secret": "y", "bk_token": "z"}
```

## BlueKing Application Certification

Plans supported by BlueKing App Certification:
- bk_app_code + bk_app_secret: directly use the BlueKing application account to authenticate the application. Please refer to [Get BlueKing App Account](../use-api/bk-app.md)


## User Authentication

Plans supported by BlueKing user authentication:
- bk_token: Use the user login state to authenticate the user. For details, please refer to [Get BlueKing User Identity] (../use-api/bk-user.md).

## Authentication information sent to the backend interface

The API gateway assigns a different pair of public keys and private keys to each gateway. When the gateway requests the back-end interface, the currently requested BlueKing application and user information are
Use the gateway private key to sign, generate an encrypted string in JWT format and put it in the request header `X-Bkapi-JWT`.

The backend interface can use the gateway public key to decrypt the request header `X-Bkapi-JWT`. If the decryption is successful, then
- The backend interface can be verified and the request must come from the API gateway
- The backend interface can obtain the currently requested BlueKing application and user information from the parsing results.

The gateway public key can be viewed on the gateway management page, the **Basic Information** page under the menu **Basic Settings**, and can be viewed through **Copy** or** after **API Public Key (Fingerprint)** Download**Get.

The sample after X-Bkapi-JWT content parsing is as follows:
```json
{
     "app": { # BlueKing application information
         "version": 1,
         "app_code": "app-test", # BlueKing application ID, that is, bk_app_code. When the authentication fails, the value may be an empty string.
         "verified": true # Whether the BlueKing application has passed the certification, true means it has passed the certification, false means it has not passed the certification.
     },
     "user": { # BlueKing user information
         "version": 1,
         "username": "admin", # Username. When authentication is not passed, the value may be an empty string.
         "verified": true # Whether the BlueKing user has passed the authentication, true means passed the authentication, false means not passed the authentication
     },
     ...
}
```