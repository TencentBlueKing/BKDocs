# Account management

The account management function allows users to store and manage different types of OS execution accounts according to different businesses; of course, if there is a corresponding "account management system" (such as the Iron General system) within the enterprise, then the account here needs to be configured by the user according to the actual situation Use; because the operating platform itself is not directly related to the account authentication module on the server operating system, only account configuration maintenance management is provided here.

![image-20211009174612946](media/image-20211009174612946.png)

## Create an account

Click the "**New**" button above the form to create a new server account:

![image-20211009174702681](media/image-20211009174702681.png)

- purpose

   Select the corresponding account to use, such as `system account` `database account`

- type

   According to different objects, select the corresponding account type

   - Supported types of system accounts: `Linux` `Windows`
   - Supported types of database accounts: `MySQL` `Oracle` `DB2`

- name

   The actual name of the account, that is, the real name on the server operating system, such as `root` `user00`

- alias

   The alias of the account, it is more necessary in the case of an account with the same name

- password

   The password of the server account, such as the Administrator password of the Windows operating system

- Confirm Password

   Confirm the password twice

- describe

   Fill in the description of the applicable scenarios or application objects of the account