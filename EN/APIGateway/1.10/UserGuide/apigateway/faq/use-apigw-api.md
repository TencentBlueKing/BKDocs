# Call gateway API FAQ

### The backend interface relies on the user login status in Cookies to authenticate users and whether they can access the gateway.
Browser cookies contain sensitive user information, so the gateway will not pass cookies to the backend interface.
The backend interface cannot authenticate users through Cookies. You can refer to [Gateway Authentication Scheme](../reference/authorization.md) to parse `X-Bkapi-JWT` to obtain the current user.