# Why is there only one "online" version of the script in the job platform

The script version management design idea of the job platform is roughly similar to that of developers using Github to manage versions when writing code. The purpose of the new version change is to improve or optimize the processing logic/performance of the old version. Essentially, every new version should be ** Backward compatible**.

But the only difference is that the script itself is oriented to a specific requirement scenario. If the addition of new features makes it incompatible with backwards, it means that the original mission of the script has changed. The way we recommend is , by creating a new script to manage; in this way, the original script can still maintain the ability of the demand scenario it solves, and secondly, the script can be managed more clearly. We don’t want to be in the script version management The function is too complicated or the user has a heavy management burden.

> Small Tips: The `Copy and Create` version can be edited and modified repeatedly, and no redundant draft version will be generated until the version goes online.