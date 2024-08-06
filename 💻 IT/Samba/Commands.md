#                  Copy file from this PC to a remote one

```shell
smbclient                                          \
    -U xREMOTE_USERNAMEx%xPASSWORDx                \
    -W xDOMAINx                                    \
    -I xDO.MAIN.RUx //xSERVER.RUx/xSHARED/FOLDERx/  \
    -c '
        cd      "/xFOLDER/ON/REMOTE/PCx/";
        lcd     "/xFOLDER/ON/THIS/PC0x";
        prompt;
        mput    "Xstart of the name of files to copyX"*
    '
```









#                  See files in folder on remote PC

```shell
smbclient \
    -U xREMOTE_USERNAMEx%xPASSWORDx         \
    -W xDOMAIN_NAMEx                        \
    -I xSERVER.RUx //Xserver.ru/somethigX/  \
    -c '\
        ls "Xfolder/on/remote/pcX/"
    '
```