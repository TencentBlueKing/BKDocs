 # Run BK-CI Learning environment with One-Docker 

 We provided a single container Deploy solution for [BK-CI](https://hub.docker.com/r/blueking/bk-ci) for demonstration only. 

 create a container named bkci-demo and pass port 80 of the Host to port 80 in the container: 

 ```text 
 docker run -p 80:80 --name bkci-demo -dit blueking/BK-CI 
 ``` 

 Observe the container Start Up log Output: 

 ```text 
 docker logs -f bkci-demo 
 ``` 

 When all service Start succeeded, an access prompt will be Output: 

 service Start Up Success. You can access BK-CI by Input [http://devops.bktencent.com](http://devops.bktencent.com/) in your browser. \(Please setting DNS or hosts in advance\) 