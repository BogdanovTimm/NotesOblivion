1. Login to GitLab.
2. Go to Preferences -> Access Token
3. Create new Access Token
4. Save given text somewhere, it will be needed later
5. Open project from which you want to download a file and copy its Project Id
6. Get path from the root of your project to a file you want to download and change every '/' to '%2F'

```shell
curl                                                                                                                            \
--insecure                                                                                                                      \
--header "PRIVATE-TOKEN: xACCESS_TOKENx"                                                                                        \
--request GET "https://xGITLAB.COMx/api/v4/projects/xPROJECT_IDx/repository/files/xPATHx%2FxTOx%2xFFILEx/raw?ref=xYOUR_BRANCHx" \
> ./filename.txt
```