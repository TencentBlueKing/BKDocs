 # Build and host One CI image 

 BK-CI provided a default Ubuntu image, but it may not meet all compilation Scene. You can make a customizeImage based on the default image approve this article. 

 - Default image: [bkci/ci:latest](https://github.com/TencentBlueKing/ci-base-images/blob/master/ci-build/Dockerfile) 

 ## Preparing Materials 

 - [docker build](https://docs.docker.com/engine/reference/commandline/build/) Related knowledge 
 - One linux agent 
 - One Dockerfile project that can Success build an image on the machine 

 ## Customize CI Images 

 1. signIn the agent, synchronize the Dockerfile project to the builder, and Enter the Dockerfile project directory 

 - **Dockerfile example 1 (Base on BK-CI default image):** 

 ```CMD 
 FROM BK-CI/ci:latest 

 RUN yum install -y mysql-devel 
 ``` 

 - **Dockerfile example 2 (If the default image of BK-CI is not used as the Base image, the basic requirements for the image environment are as follows):** 

 ```CMD 
 # ============= BK-CI Base environment =============== 
 FROM openjdk:8-jre-slim 
 RUN apt update && apt upgrade && apt autoremove -y 
 RUN apt install -y curl wget 
 RUN wget -q https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk16/1.46/bcprov-jdk16-1.46.jar -O $JAVA_HOME/lib/ext/bcprov-jdk16-1.46.jar 
 RUN ln -sf $JAVA_HOME /usr/local/jre 

 # ============= customize environment =============== 
 # RUN whatever you want 
 RUN apt install -y git python-pip 

 ``` 

 > **IMPORTANT NOTE**: 
 > 
 > -Because the container in Pipeline is Start Up approve CMD and/bin/sh, it Must be guaranteed that/bin/sh and curl commands (used to download agents) exist in the image. 
 > -Do not Set ENTRYPOINT 
 > -Make sure it is a 64-bit mirror 
 > -Use root as user. If you need a Normal user, you can switch in bash, otherwise Pipeline Task cannot be Start Up. 
 > -Pipeline Plugin may be Develop using python or nodejs. It is recommended to prepare a plug-in execute environment: 
 <br/>[Python Plugin execute environment](../../../Developer/plugins/plugin-dev-env/prepare-python.md) 
 <br/>[NodeJS Plugin execute environment](../../../Developer/plugins/plugin-dev-env//prepare-node.md) 

 2. Docker Build 

 ```CMD 
 docker build -t XXX.com/XXX/YYY:latest -f Dockerfile . 
 ``` 

 3. execute login 

 ```CMD 
 docker login XXX.com 
 ``` 

 4. Docker Push 

 ```CMD 
 docker push XXX.com/XXX/YYY:latest 
 ``` 

 ## Next you may need 

 - [Release One container image](release-new-image.md) 