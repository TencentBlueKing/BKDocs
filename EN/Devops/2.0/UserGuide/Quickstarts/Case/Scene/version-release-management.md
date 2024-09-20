 # Release Manage of Internal Beta Version on Mobile 


 ## Keywords: Mobile download, unified Version Management channel<a id="&#x51C6;&#x5907;&#x4E8B;&#x9879;"></a> 

 ## Business Name Challenges 

 When the Business Name Enter the Test Stage, a large number of New version will be Output from different Branch, and students with different functions such as Develop, planning and art are required to carry out version testing.  However, not only do various version for internal Test rely on engineers to manual build and download and distribute, which is labor-intensive, but also different Branch and versions of client packages are spread approve large groups within the company, increasing information Safety and Version Management risks. 

 ## Advantages of BK-CI 

 approve One "mobile experience" feature that can be embedded in major IM tools, manual upload and Release Operation are replaced by auto Plugin and integrated into Pipeline.  The new version package will be Automatic update to the WeCom Apply after the build is complete, and the rtxNotice will be sent to all personnel with Test auth, which saves manpower investment, and the unified Version Management approach also reduces the risk of leakage and management Cost of the version during the testing period.  Its features are: 

 ● download and view version packages with auth protection to reduce version Safety risks 

 ● One-click delivery in WeCom that can be Operation by planning and art, reducing engineer investment and communication Cost 

 ● Unified version Manage channel to avoid version confusion and wrong distribution 

 ● Notification of build process sent to WeCom 


 ## Solution 

 Deploy Prerequisites 

 ● One domain name and certificate complete filing. 

 ● One 2-Core 4G service. 

 ● One Tencent Cloud COS bucket, which Storage Apply and provided download. 

 ● One Tencent Cloud CLB provided front-end access, Load Balancer, Anti-DDoS, and other capabilities. 

 ● Currently only support WeCom 

 1. setting BK-CI Pipeline 

 ![&#x56FE;1](../../../assets/scene-version-release-management-a.png) 

 setting ipa/apk install package 

 path of install package to be upload: 

 ● select the install package to upload from the path of this build. 

 ● Support ipa file, apk files and Compressed package. 

 setting Application Information 

 ● App name: The name of the application displayed on the experience.  When The configItem is empty, the Plugin will auto obtain the Apply name built in the ipa/apk package. 

 ● Version Number: The version number displayed on the experience.  When The configItem is empty, the Plugin will auto obtain the versionNum built into the ipa/apk package. 

 Apply description: A detailed description of The experience version.  It can be completely customize by the Business Name party.  Starred description include: a summary to the Apply; version of the changeLog and so on. 

 ● Product Maintainers: Support Pull address book from WeCom, and support multiple choices. 

 setting Experience Scope 

 End date: After this date, the experience will auto expire and can no longer be download. 

 select Relative Time or absolute time 

 ● Relative Time: The current build time of Pipeline plus the relative time, unit days, is the end date of the experience. 

 ● Absolute time: the date select is the end date of the experience        。 

  Experienced personnel: 

 ● Support the select of individual personnel. 

 ● Support to select experiencers by part. 

 setting noticeType 

 ● complete experience is Release, send a notification approve the Apply number. 

 ● Notify the personnel to support the App service personnel or experience personnel. 

 2. select the "experience" Apply from the WeCom workbench 

 ![&#x56FE;1](../../../assets/scene-version-release-management-b.png) 

 3. select the Apply you want to experience, click "download" to quickly download the application, ipa will prompt location safari to download 

 ![&#x56FE;1](../../../assets/scene-version-release-management-c.png) 