 # Voucher var 

 During Pipeline runs, Sensitive data such as password, token, appId/secretKey, etc. are often used to access auth resources. 

 If these Sensitive data are written directly into Pipeline, there is a Safety risk and it is easy to leak. 

 Sensitive data can be managed centrally approve BK-CI credentialManage service. 

 ticket can be used in Pipeline, usually in the following ways: 

 ## How to use ticket in Pipeline? 

 ### Select or Fill In a ticket name in Pipeline Plugin 

 In this Scene, the Plugin backend encapsulates the logic for obtaining the ticket content, and the user only needs to select or Fill In the credential name when arranging Pipeline. 

 ###Reference ticket content in Pipeline Plugin input parameters 
 This Scene is typically using a Script Plugin, such as Bash, or a plug-in that does not encapsulate ticket content fetching.  At this point, you can refer to specific ticket content approve the settings context. 

 Example: 

 ``` 
 Prerequisite: A ticket with name a and type password is create under credentialManage service 

 The Pipeline input parameter approve ${{ settings.a.password }} to get the password 
 ``` 

 approve Expression `${{ settings.  <var-name>.  <property-name>}}`Access the content of credentials setting under the Credential service. 
 - `<var-name>` is the user credential key under ticket Manage 
 - `<property-name>` varies by ticket type 

 |  attribute name   | Description| 
 |  ----  | ----  | 
 | `${{ settings.  <key>.password }}`  |Password when type=PASSWORD| 
 | `${{ settings.  <key>.access_token }}`  |access_token when type=accessToken| 
 | `${{ settings.  <key>.username}}`  |username when type=USERNAME_PASSWORD| 
 | `${{ settings.  <key>.password}}`  |password when type=USERNAME_PASSWORD| 
 | `${{ settings.  <key>.secretKey}}`  |secretKey when type=SECRETKEY| 
 | `${{ settings.  <key>.appId}}`  |appId when type=appId_secretKey| 
 | `${{ settings.  <key>.secretKey}}`  |secretKey when type=appId_SECRETKEY| 
 | `${{ settings.  <key>.privateKey}}`  |privateKey when type=SSH_PRIVATEKEY| 
 | `${{ settings.  <key>.passphrase}}`  |Type=SSH_PRIVATEKEY| 
 | `${{ settings.  <key>.token}}`  |token when type=TOKEN_SSH_PRIVATEKEY| 
 | `${{ settings.  <key>.username}}`  |username when type=TOKEN_SSH_PRIVATEKEY| 
 | `${{ settings.  <key>.password}} 	 `  |password when type=TOKEN_SSH_PRIVATEKEY 	 | 
 | `${{ settings.  <key>.password}}`  |password when type=MULTI_LINE_PASSWORD| 

 When the Pipeline runs, the Expression in the input parameter is auto Replace with the actual ticket value. 

 ### Use ticket content in script file Start Up in Script Plugin 
 When you use the Script Plugin to Run specified scripts such as sh and py, the Code content of these scripts is not in the plug-in input parameters, and Expression references cannot be directly used in the code. 

 In this case, the recommended usage is to set the credentials to the Env Variables for the Current step before Start Up the Script file, from which the script file obtains the credentials. 

 Example: 

 The bash Plugin input parameter is: Set the ticket content to the Env Variables 

 ``` 
 echo "settings.a.password is ${{ settings.a.password }}" 

 # Set the Env Variables first (only the current step is valid) 
 export GITHUB_PWD="${{ settings.a.password }}" 

 # execute the Script file 
 ./  use_ticket.sh 
 ``` 

 The use_ticket.sh Code is: Reference ticket content from Env Variables 

 ``` 
 #!/  bin/bash 

 echo $GITHUB_PWD 
 ``` 
 ## Precautions 
 log desensitized 

 When the ticket content is printed in the log, it will be displayed ******, not in clearText 

 Note that only the display in the log is affected, and the real value in the var is still affected 