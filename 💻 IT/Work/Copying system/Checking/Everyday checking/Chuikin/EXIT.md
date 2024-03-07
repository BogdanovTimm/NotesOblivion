#                  How to find it

After running `/sas/home/apchuikin/main.sh` there are 
Gives you ID for other `lsf` commands and lsf-job name. 
Yellow lines are processes that failed. 
White lines under yellow ones - processes that depends on failed yellow ones.    

#                  How to fix it

1. Open Mantis
    - Because of lock:
        1. Copy SAS library name
        2. `view ^/path/to/log/from/mantis^`
        3. Search for library and find its Hard Disk path
        4. `cd /hard/disk/path/of/library`
        5. `ls -1 | grep ^table_name^`
        6. `fuser ^table_name^` - if it gives you:
            - nothing - then no one uses this table now:
                1. `brequeue -e ^lsf_job_id^` - restart lsf-job
                2. `bjobs -w ^lsf_job_id^` - check lsf-job status
            - something - somebody uses this table right now:
                1. Ask for help
    - If it is a problem with connection:
        1. `cd /sas/bin/gpfdist/log` - check `gpfdist` logs in 
    - If it is something else - ask for help
