# System Maintenance 

The PaaS3.0 platform provides basic maintenance methods, allowing the administrator to perform simple maintenance operation based on WEB page. 

Access URL: `{PaaS3.0 Developer Center Access Address}/backend/admin42/`

Description: 
1. Initially, only the `admin` account can access the management backend. 
2. Must first open and login to the PaaS3.0 Developer Center before you can normally open and access the backend background. 


If you do not have an `admin` account after connecting the custom login, you can enter the `bkpaas3-apiserver-web` pod and execute the following command to append another administrator account: 

``` 
from bkpaas_auth.core.constants import ProviderType 
from bkpaas_auth.models import user_id_encoder 
from paasng.accounts.models import UserProfile 
username="your_name" 
user_id = user_id_encoder.encode(ProviderType.BK.value, username) 
UserProfile.objects.update_or_create(user=user_id, defaults={'role':4, 'enable_regions':'default'}) 
``` 

### User List 

Add users that can access the management backend here 

Note: The user type is : BK and the user role is: Super User 


### Apply Cluster Management 
Here you can revise the Apply Cluster setting and add a new application cluster. After the configuration is changed, the Deploy the application to take effect. 

For more parameter description, see [Initialize Cluster Setting](../../../../OperationGuide/PaaS3/docs/configure_initial_cluster.md) 
 
### Apply Resource Management 
Developers can view the resource allocation limit of the application process on the App Engine - Processes page. 


If you need to adjust the resource allocation limit of an application process, you can filter out specific applications in "Platform Management"-"Application List" in "Manage Background", go to the "App Engine"-"Processes" page of the application, and click "Revise Resource Scheme" of the corresponding process. You can: 

1. Select an existing resource schema 
2. Add a new resource schema 
 
### Apply Env Variable Management 
Developers can append and revise Env variables in the App Engine's "Env Configs", but they cannot add them. Env variables are prefixed with `BK_`, `BKPAAS_`, etc. 

If you need to add such Env variables under special circumstances, the administrator can filter out specific applications in the "Platform Management"-"Application List" in the management background, enter the "App Engine"-"Environment Variable Management" page of the application. 

 
Manage Background also includes application runtime management, add-ons management, and other functions, and can view all application information on the Application List page.
