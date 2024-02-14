#                  What it is?
 
 It is a script for monitoring





# /asa/dwh/mr${mrid}/logs/ofus_cdtl_idp-* 




#                  How it works

1. Calls `/sas/utils/region_status.sh` - this script shows how many scripts working or gave an error on 5 central servers: goes into each of them via SSH and checks names of files in `/sas/scheduler/spool/status`
2. Calls `/sas/util/trees_dates.sh` - Checks `/sas/dwh/mr%all%/logs/automation/tree.dwl_today`
3. Calls `bjobs -wp -u all | grep -B 1 never | grep sasetl` - cehcks bjobs on every mr server
4. Calls `/sas/utils/old_jobs.sh` - checks whether there are long-running jobs in `lsf`
5. Calls `/sas/utils/check_idp_health.sh` - check whether there is a line that starts with `ERROR` in /sas/dwh/mr%mr number%/logs/ofus_cdtl_idp-%something else%
6. Calls `/sas/utils/check_arpu_month.sh` - check whether `/sas/dwh/mr%all%/etl_data/ofgen/arpu_%mr_number%_%current year previous month%_mr%all%.sas7bat` file exist.
7. Calls `/sas/utils/check_crontabs.sh` - checks whether crontab configuration on each server has more than 20 lines
8. Calls `/sas/utils/td_basespace.sh` - runs `/sas/utils/td_basespace.sas` using `sas` that goes into Teradata, create table `freespace` 
9. Calls `/sas/utils/td_copy_check.sh` - runs `/sas/utils/td_copy_check.sas` using `sas` that goes into Teradata, create table `copyjobs`