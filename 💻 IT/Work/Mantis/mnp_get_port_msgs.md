#                  What it is?

There is an invalid XML file

#                  What to do with it?

1. Go to SAS ETL 1
2. Open Mantis
3. Find line and column of an error. Also, copy `^/path/to/log^.log`
4. `vim ^/path/to/log^.log` - find `^/path/to/xml^.xml`
5. Open `^/path/to/xml^.xml` file
6. Find errors using:
    1. `Shift +;`
    2. `^\s\+[a-z,A-Z]*>`
7. `vim /sas/dwh/other/mnp/incoming/mnp_get_port_msgs.sas`
8. Comment:
   ```SAS
   %if %sysfunc(attrn(&mvTableId,nlobs)) > 0 %then %do;
           %let rc = %sysfunc(fetch(&mvTableId));
           %do %while(&rc = 0);
               %let mvFileName = %sysfunc(getvarc(&mvTableId, &mvVarNum));
               /* 
               x "cd &DWL_DATAPATH";
               x "lftp -e 'set xfer:clobber true ; cd /CHANGES/&mvStream._LIST/; get &mvFileName.; quit' -u esbftp,tc,ang230 -p 666 sftp://&host ";
               %if %DWL_NOT_OK %then %goto EXIT;
               */
               %mLoad&mvStream.(&mvFileName);
   ```
9. `brequeue -e 508290`
10. `bjobs - w 508290` - check status of a job:
    - If it `DONE` - uncomment lines in `/sas/dwh/other/mnp/incoming/mnp_get_port_msgs.sas`
    - If it `EXIT` - go to 2.