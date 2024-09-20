# Get BlueKing user identity

When accessing the cloud API, if you authenticate the user and verify the user's identity, you need to provide information representing the user's identity.

Currently, the BlueKing user identity information supported by the gateway is as follows:
- User login status: After the user logs in to BlueKing, the user login credentials stored in the browser cookies are generally valid for no more than 24 hours.

## User login status

After the user logs in to BlueKing, the user's login credentials will be stored in the browser cookies. This login credentials can represent the user's identity.

The login status information of BlueKing users is as follows:

| Request parameter fields | Cookies field | Description |
|----------|--------------|------|
| bk_token | bk_token | User login status |