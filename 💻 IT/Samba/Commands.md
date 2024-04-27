#                  Copy file from this PC to a remote one

```
smbclient \
    -U Xusername_on_remote_pcX%XpasswordX \
    -W XDOMAIN_NAMEX \
    -I Xserver.ruX //Xserver.ru/somethigX/  \
    -c '
        cd
            "Xfolder/on/remote/pcX/"
        ;
        lcd
            "/Xfolder/on/this/pcX/"
        ;
        prompt
        ;
        mput
            "Xstart of the name of files to copyX"*
    '
```

#                  See files in folder on remote PC

```
smbclient \
    -U Xusername_on_remote_pcX%XpasswordX \
    -W XDOMAIN_NAMEX \
    -I Xserver.ruX //Xserver.ru/somethigX/  \
    -c '\
        ls
            "Xfolder/on/remote/pcX/"
    '
```