 # Code Pull + BK-Repo upload download 

 * click the Code Repository (for detail of the code base, see the [Code Base] directory). 

 ![](../../../assets/image-20211212214606792.png) 

 * select the link Gitlab Code Repository 

 ![](../../../assets/image-20211205163725597.png) 

 * click new to auto location to credentialManage--addCredential, obtain accessToken on gitlab to Fill In, and click determine&#x20; 

 ![](../../../assets/image-20211205164052362.png) 

 * Go back to the Code Repository, select "demo" as the codelibCredential, and determine 

 ![](../../../assets/image-20211205164627965.png) 

 * createPipeline 

 ![](../../../assets/image-20211213100550657.png) 

 append a new stage 

 ![](../../../assets/image-20211213100650213.png) 

 append checkout gitlab Plugin, link OK create Code Repository, and Pull branchLabel 

 ![](../../../assets/image-20211205170423284.png) 

 append RunScript Plugin, view the current workspace and the Pull Code directory, and package the code 

 ![](../../../assets/image-20211209202103728.png) 

 save the ShortUrl.zip file of the current workspace to the BK-Repo, you can use the upload artifacts Plugin 

 Note: In the case of using multiple agent type (BK-CI hosted agent + Self hosted agent or multiple different private builders), when different builders need to rely on the use of building products (not limited to the Pull Code), you can upload the file/folder to the BK-Repo, and download the file corresponding to the artifact library from the Job that needs to use The file. 

 * append upload artifacts Plugin 

 ![](../../../assets/image-20211209202425994.png) 

 *   download artifacts Plugin---download file from the BK-Repo to the workspace under the current Job 

    insertStage 

 ![](../../../assets/image-20211209202505648.png) 

 append the Download artifacts Plugin, which will auto find the source path of the BK-Repo according to OK Fill In content, and then download it to the current workspace 

 ![](../../../assets/image-20211209203143751.png) 