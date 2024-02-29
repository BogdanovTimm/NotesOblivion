1. Go to sasetl1 server
2. `/sas/utils/morning.sh`:
    - If `<<<< REGIONS >>>>` has `ERR`:
        1. Remember letters from the right of the `ERR`
        2. `ssh tabogdanov@^server.address.ru^`
        3. `sudo -iu sas`
        4. `cd /sas/sheduler/spool/status`
        5. `view ^letters_from_the_right_of_the_ERR^` - check log:
            - If some SAS table was locked:
                1. `cd /sas/isystemf94/logs_data`
                2. `fuser ^locked_table_name^` - check if file is still locked:
                    - If it is not locked:
                        1. `cd /sas/sheduler/pool/status`
                        2. `ls -lah | grep ^letters_from_the_right_of_the_ERR^` - it will be something like `acab.error`
                        3. `rm ^letters_from_the_right_of_the_ERR^.error`
                        4. `ps -ef | grep ^letters_from_the_right_of_the_ERR^` - check whether process started
        6. View `<<< JOBS SASETL1 >>>`  and `<<< JOBS SASETL1 >>>`:
            - If there is a red lines:
                1. Remember 1st number
                2. `ssh tabogdanov@sasetls^1^.pv.mts.ru`
                3. `bjdepinfo -l ^1st_number^ | gawk '$3 != "DONE" {print $0}'` - remember `PARENT` of it
                4. `bjobs -w ^PARENT^` - Remember `JOB_NAME` of it
                5. Go to Mantis and find logs for this job by its `JOB_NAME`:
                    - If error is clear from Mantis, then you may:
                        1. `brequeue -e ^PARENT^`
                        2. `bjobs -w ^PARENT^`
                        3. `bjobs -w ^1st_number^`
                    - If error is not clear:
                        1. Find its log in mantis (path after **LOG**)
                        2. `view ^path_from_LOG_in_mantis^`:
                            - If it is a problem with connection - check `gpfdist` logs in `/sas/bin/gpfdist/log`
                            - If it is not clear - ask somebody to help