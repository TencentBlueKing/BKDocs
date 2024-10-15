# IP whitelist

Since the business in the job platform is logically isolated, that is, users can only execute scripts/jobs or hosts associated with the specified business, resources or targets are not allowed to be cross-business; but when the user is in the platform business maintenance scenario, it is required To transfer files/execute tasks across businesses, this is achieved by adding hosts outside the business to the IP whitelist. (This function will be provided by configuring the "business set" of the platform in the future. At that time, the IP whitelist function will be removed after migration)

![image-20211019145440672](media/image-20211019145440672.png)

## New IP whitelist

- Target business

   The business scope in which the whitelist takes effect (multiple choice)

- cloud area

   Select the corresponding cloud region

-IP

   Enter a list of IPs for the whitelist

- Remark

   Provide a description of the purpose of the record

- Valid scope

   Select the effective scope of the operation of this record, that is, the atomic capabilities of the operating platform: `script execution` and `file distribution`

![image-20211019145613262](media/image-20211019145613262.png)