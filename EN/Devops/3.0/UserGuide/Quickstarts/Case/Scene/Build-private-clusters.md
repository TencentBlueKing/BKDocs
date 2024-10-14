 # Create a Private build cluster 

 ## Keywords: Private, cluster 

 ## Business Name Challenges 

 if multiple single agent are use all that time, and different Pipeline are artificially assigned to different build machines, not only the maintenance of the build machine itself will become a burden, but more importantly, the use Efficiency of the build machine is low. 

 ## Advantages of BK-CI 

 BK-CI Pools can integrate multiple single agent into a build cluster to improve overall resources utilization Efficiency 

 ## Solution 

 1. Open BK-CI and select "Pools" 

 ![&#x56FE;1](../../../assets/scene-Build-private-clusters-a.png) 

 2."new" environment, select the build node 

 ![&#x56FE;1](../../../assets/scene-Build-private-clusters-b.png) 

 ![&#x56FE;1](../../../assets/scene-Build-private-clusters-c.png) 

 3. In the Pipeline Stage setting, select Private: build cluster uses 

 ![&#x56FE;1](../../../assets/scene-Build-private-clusters-d.png) 

 After the cluster is formed, the Algorithm for Job to find the construction node is as follows: 

 ![&#x56FE;1](../../../assets/scene-Build-private-clusters-e.png) 