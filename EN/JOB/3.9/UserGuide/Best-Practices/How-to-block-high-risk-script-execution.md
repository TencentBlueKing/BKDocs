# How to intercept script execution tasks of high-risk statements

In the industry, `rm -rf /` delete database and escape incidents are not uncommon. While strengthening the operational security awareness training of business operators, enterprises must also improve the security assurance capabilities of the operating platform; in the context of the trend of gradually removing consoles in the future, If high-risk statements can be checked for user input instructions on the operating platform/system, it can largely avoid operational failures in which data is deleted due to misoperation.

The "high-risk statement interception" capability of the BlueKing operating platform supports the scanning of high-risk statements on web pages and API execution instructions through regular expressions, and can realize real-time interception and log recording, helping enterprise security teams to better guarantee the safety of business operations.

### 1. Create a "high-risk statement rule"

![image-20221012115447289](media/image-20221012115447289.png)

This rule indicates that when the keyword `Hill Hydra` exists in the script command executed by the user, the platform will intercept the operation and give a prompt `! ! ! . . . . . bold! `

### 2. Execute the script and enter `echo "Hill Hydra"` to test

![image-20221012115648434](media/image-20221012115648434.png)

![image-20221012115713499](media/image-20221012115713499.png)

When a high-risk sentence rule is detected in the script editor, the icon prompt of the skull will be displayed in real time; at the same time, if the user calls and enters a high-risk sentence through the API, the request will be rejected and a specific error message will be returned.

![image-20221012121158453](media/image-20221012121158453.png)