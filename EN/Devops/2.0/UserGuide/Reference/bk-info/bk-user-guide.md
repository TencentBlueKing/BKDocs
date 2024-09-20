 # Getting Started with BlueKing The document 

 ## 1. create One user 
 Add, delete, change and check the user information related to the BlueKing environment can be Operation in "userManage".  As shown below: 

 ![](../../assets/image-reference-bkuserguide-1.png) 


 ### 1.1 append user 
 ![](../../assets/image-reference-bkuserguide-2.png) 

 ![](../../assets/image-reference-bkuserguide-3.png) 

 ### 1.2 Revise user Information 

 ![](../../assets/image-reference-bkuserguide-4.png) 

 Related learning materials: 
 - The document: https://bk.tencent.com/docs/document/6.0/146/7330 (The document is the community version, and the functions are basically the same as those of the enterprise version) 

 - Video: ke.qq.com/course/3101748?  taid=10600778153546804 

 ## 2. create One Business Name 

 Enter the "Configuration System", where you can Manage "Business Name-Host 

 ![](../../assets/image-reference-bkuserguide-5.png) 

 ### 2.1 create a Business Name 

 ![](../../assets/image-reference-bkuserguide-6.png) 

 ![](../../assets/image-reference-bkuserguide-7.png) 

 ![](../../assets/image-reference-bkuserguide-8.png) 

 ![](../../assets/image-reference-bkuserguide-9.png) 

 ![](../../assets/image-reference-bkuserguide-10.png) 

 ### 2.2 view Business Name module and Host 

 ![](../../assets/image-reference-bkuserguide-11.png) 

 ![](../../assets/image-reference-bkuserguide-12.png) 

 If you do not see the newly create Business Name, click "reflash Apply" in the lower left corner of the page, and then repeat "Step 2" and "Step 3" 
 Then we see the information about the Business Name we just create. 

 ![](../../assets/image-reference-bkuserguide-13.png) 


 ## 3. create One auth group to link the Operation permissions of user and Business Name in the platform 

 Here, the admin account is required to append auth to the Business Name. To facilitate subsequent Operation related to The business, it is recommended to use "create Permission Group" and then link "user" to "Permission Group". 

 ![](../../assets/image-reference-bkuserguide-14.png) 


 ### 3.1 create One Business Name auth Configuration System Template 

 ![](../../assets/image-reference-bkuserguide-15.png) 

 After switching identities, Enter the Super Administrator mode. Only the Super Admin can create a Business Name Permission Group with a high Permission Level. 

 ![](../../assets/image-reference-bkuserguide-16.png) 

 ![](../../assets/image-reference-bkuserguide-17.png) 

 ![](../../assets/image-reference-bkuserguide-18.png) 

 The corresponding Role (such as: OPS, Develop) Recommended Default setting "version, the current version needs to be checked manual 
 Then associate the corresponding "resources instance" for the "auth" just select 


 ![](../../assets/image-reference-bkuserguide-19.png) 

 ![](../../assets/image-reference-bkuserguide-20.png) 

 ![](../../assets/image-reference-bkuserguide-21.png) 

 ![](../../assets/image-reference-bkuserguide-22.png) 

 ![](../../assets/image-reference-bkuserguide-23.png) 

 ![](../../assets/image-reference-bkuserguide-24.png) 


 ### 3.2 create One Business Name auth Group

 ![](../../assets/image-reference-bkuserguide-25.png) 

 ![](../../assets/image-reference-bkuserguide-26.png) 

 ![](../../assets/image-reference-bkuserguide-27.png) 

 ![](../../assets/image-reference-bkuserguide-28.png) 

 ![](../../assets/image-reference-bkuserguide-29.png) 


 ## 4. append One host for Business Name 

 Enter the Home and click "NodeMan". 

 ![](../../assets/image-reference-bkuserguide-30.png) 

 ![](../../assets/image-reference-bkuserguide-31.png) 

 ![](../../assets/image-reference-bkuserguide-32.png) 

 ![](../../assets/image-reference-bkuserguide-33.png) 

 ![](../../assets/image-reference-bkuserguide-34.png) 


 ## 5. Manage Host in Configuration System

 Next, we will Deploy One service called "dataserver" on the newly added Host.  To facilitate subsequent Manage, we first create some information on the Configuration System. 

 ### 5.1 create One set (cluster) and module (module)

 ![](../../assets/image-reference-bkuserguide-35.png) 

 ![](../../assets/image-reference-bkuserguide-36.png) 

 ![](../../assets/image-reference-bkuserguide-37.png) 

 ![](../../assets/image-reference-bkuserguide-38.png) 


 ### 5.2 Move Host to module and Revise CVM Information 

 ![](../../assets/image-reference-bkuserguide-39.png) 

 ![](../../assets/image-reference-bkuserguide-40.png) 

 ![](../../assets/image-reference-bkuserguide-41.png) 

 ![](../../assets/image-reference-bkuserguide-42.png) 

 ![](../../assets/image-reference-bkuserguide-43.png) 

 ![](../../assets/image-reference-bkuserguide-44.png) 



 ## 6. Deploy the dataserver service using the Job System 

 ![](../../assets/image-reference-bkuserguide-45.png) 

 ### 6.1 upload Local file to Host 

 https://www.python.org/ftp/python/3.9.4/Python-3.9.4.tgz 

 ![](../../assets/image-reference-bkuserguide-46.png) 

 ![](../../assets/image-reference-bkuserguide-47.png) 

 ![](../../assets/image-reference-bkuserguide-48.png) 

 ![](../../assets/image-reference-bkuserguide-49.png) 


 ### 6.2 Deploy service with Script execute 

 ![](../../assets/image-reference-bkuserguide-50.png) 

 ![](../../assets/image-reference-bkuserguide-51.png) 

    
    cd /data 
    yum install -y gcc python39-devel bzip2-devel sqlite-devel openssl-devel readline-devel xz-devel tk-devel gdbm-devel 

    mkdir -p /data/corefile 
    chmod 777 /data/corefile 
    echo 'ulimit -c unlimited' >> /etc/profile 
    sed -i "/^kernel.core_pattern =/d" /etc/sysctl.conf 
    echo 'kernel.core_pattern = /data/corefile/core_%e_%t' >> /etc/sysctl.conf 
    sysctl -p /etc/sysctl.conf 

    tar zxvf Python-3.9.4.tgz 
    cd Python-3.9.4 
    ./  configure 
    make && make install 
    make clean && make distclean 

    mkdir -p /data/app 
    pip3 install Flask 
    pip3 freeze > /data/app/requirements.txt 
    cat > /data/app/app.py <<EOF 
    from flask import Flask 
    app = Flask(__name__) 

    @app.route('/') 
    def hello_world(): 
        return 'Hello, World' 
    EOF 

    cd /data/app 
    nohup python3 -m flask run >/dev/null 2>&1 & 


 ## 7. Monitor Host and processes using the Monitor 

 ### 7.1 Information about create a process in "Configuration System"

 ![](../../assets/image-reference-bkuserguide-52.png) 

 ![](../../assets/image-reference-bkuserguide-53.png) 


 ### 7.2 Monitor setting Alert 
 ![](../../assets/image-reference-bkuserguide-54.png) 

 ![](../../assets/image-reference-bkuserguide-55.png) 

 ![](../../assets/image-reference-bkuserguide-56.png) 

 ![](../../assets/image-reference-bkuserguide-57.png) 

 ![](../../assets/image-reference-bkuserguide-58.png) 



