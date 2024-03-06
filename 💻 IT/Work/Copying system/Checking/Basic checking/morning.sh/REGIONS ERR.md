#                  How to find it:

1. Run `/sas/utils/morning.sh`
2. `<<<< REGIONS >>>>` has `ERR`









#                  How to fix it

1. Remember letters from the right of the `ERR`:
    - If `^letters_from_the_right_of_the_ERR^` = `cdic`:
        1. cd /sas/sheduler/spool/status`
        2. `view ^letters_from_the_right_of_the_ERR^` - check log:
            - If SAS MTS_LOGS table was blocked:
                1. `/sas/home/apchuykin/main.sh` - check MR of the server on which error occurred
                2. `cd /sas/dwh/inbox/mr^REGION_NUMBER_from_column1^` and check if there is a file
                    - `sh /sas/utils/set_loads_ba_status.sh cdic` - if file exists
    - If `^letters_from_the_right_of_the_ERR^` != `cdic` - ask









#                  Rerun process

1. Go to server on which error occurred
2. `sudo -iu sas`
3. `cd /sas/sheduler/spool/status`
4. `view ^letters_from_the_right_of_the_ERR^` - check log:
    - If some SAS table was locked:
        1. `cd /sas/isystemf94/logs_data`
        2. `fuser ^locked_table_name^` - check if file is still locked:
            - If it is not locked:
                1. `cd /sas/sheduler/spool/status`
                2. `rm ^letters_from_the_right_of_the_ERR^.error`
                3. `ps -ef | grep ^letters_from_the_right_of_the_ERR^` - check whether process started