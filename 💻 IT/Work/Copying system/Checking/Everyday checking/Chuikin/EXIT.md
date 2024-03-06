#                  How to find it

After running `/sas/home/apchuikin/main.sh` there are 

#                  How to fix it

1. `/sas/home/apchuikin/viewpend.sh` - run it. Gives you ID for other `lsf` commands and lsf-job name. Yellow lines are processes that failed. White lines under yellow ones - processes that depends on failed yellow ones.
2. If error is:
    - `cdtl_unpack` - ignore it!
    - `cdic`:
        1. Check Mantis:
            - If error is because of a lock of a MTS_LOG:
                1. `ls -lah /sas/dwh/inbox/mr03/cdic*` - check date
                2. Run script that works with cdic
    - If other error:
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

