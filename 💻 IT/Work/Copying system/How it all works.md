#                   Sequences

##                  Sequence 1

1. On **miscopy1**-server, `cron` runs `add_copy_tasks_gp.sh` every 2 hours
2. `add_copy_tasks_gp.sh` runs `./incoming/add_copy_tasks_gp.sas`
3. `./incoming/add_copy_tasks_gp.sas`:
	1. Saves information about SAS libraries and their tables from `etl_sas_libnames` *(using `rsubmit` in SAS)* into `SAS_Dict_tables`:
		- `sas@miscopy1`
		- `sas_ra@micsopy1`
		- `sas@sasusers`
	2. Deletes tables that were not changed in last 7 days. Now there only ones that were changes.
	3. Deletes tables that already in `CPY_TASK_SAS` with same date of change and status = `ADDED`
	4. Gets table from `DDLTables` (`tname`) with `is_disabled = 0`
	5. Gets `table_priority` from `CPY_LIST_SAS`.
	6. Deletes tables for **MR99**
	7. Adds remaining tables into `CPY_TASK_SAS`









##                  Sequence 2

1. On **miscopy1**-server, `cron` runs `copy_formats_gp.sh` on 11:00 AM and 23:00
2. `copy_formats_gp.sh` runs `./incoming/copy_formats_gp.sas`
3. `./incoming/copy_formats_gp.sas`:
	1. Get list of formats to copy from .csv `/sas/dwh/other/cpy_system/copy_lists/formats/fmt_upload_tasks.csv` `WHERE copy_group=daily_common.to_teradata`
	2. Adds all formats to `UAT_T_STG.SAS_FORMATS` through 8085 port. If fails - through 8086.
	3. Clears (?) and then add last versions of formats into `UAT_T_BASE.SAS_FORMATS`
	4. Deletes tables and views which are not in `SAS_FMT_META`, but in `UAT_T_BASE`, `UAT_V_BASE` or `UAT_V_FMT` and their name starts with `sas_fmt%` or `is_disabled = 1`
	5. Runs SAS function `%m_DDL_PREPARE_SAS_FMT_TABLE`









##                  Sequence 3

1. `start_stg_and_prod.sh` runs `sas_to_stg_cycle.sh`, `stg_to_prod_cycle.sh`, `add_copy_tasks_gp.sh` and `copy_formats_gp.sh`:
2. And then:
    - `sas_to_stg_cycle` checks number of processes `run_sas_to_stg.sh` every minute (in while-loop)
    - `add_copy_tasks_gp.sh` checks `sas_to_stg_cycle.sh` and `stg_to_prod_cycle.sh` and outputs list of **PID**s









##                  Sequence 4

1. On **miscopy1**-server, `cron` runs `sync_app_srvp_sas_online.sh` every 4 hours
2. `sync_app_srvp_sas_online.sh` runs `./incoming/sync_app_srvp_sas_onln.sas`
3. `./incoming/sync_app_srvp_sas_onln.sas` - synchronizing of table **dsrvp** and **dapp_app** with SAS Online.









##                  Sequence 5

1. `run_sas_to_stg.sh` - controls number of processes at the moment. Also it runs `./incoming/transport_worker_mpp.sas`
2. `./incoming/transport_worker_mpp.sas`:
	1. Runs SAS function `%mEtlGetCpyTaskId` that changes task's status from `TRN_RUN` to `ADDED` if tasks is in `TRN_RUN` for 12 hours or it is not in list of active sessions
	2. Gets tasks from `CPY_TASTS_SAS`
	3. Deletes tasks with status `ADDED` if for these table there are already tasks with status `TRN_RUN` 
	4. Check if task's status = `ADDED`
	5. Change task's status to `TRN_RUN`
	6. If there is another task with same tablename with status = `ADDED`, then change status to `SKIPPED`
	7. Runs SAS function `%mUploadTableToGP`:
		1. Runs SAS function `%mGetServerParams` that gets parameters of connection to `rsubmit`
		2. Runs SAS function `%mCachedConnectToServ` connects to server where SAS table is
		3. Use mask from SAS table. If this is BOPOS then skip
		4. Changes date and load_id in tablename from SAS to symbols. Deletes MP numbers. Changes DSR_NTWK_MMDD_n_MR to NTWK_ACTV
		7. Use this name to find a row in `DDLTables`. Is it there?
			- No:  If it is not here, then check maybe SAS table name will work with mask from column `FULLNAME_MASK` from `DDLTables`. Is it there?
				- No - goes to next
				- Yes - Changes tablename from `FULLNAME_MASK` to `replace_mask`. Deletes numbers from new tablename
			- Yes:
				1. If DSR_NTWK_MMDD_n_MR - then changes to NTWK_ACTV
				2. Deletes tables from `UAT_T_STG.^sas_tablename^` and `UAT_T_STG.^EXT_sas_tablename^`
				3. Creates empty table with `LIKE` for new table in GreenPlum
				4. Gets columns for renaming from `DDL_Rename_Columns` 
				5. Go to server where SAS table is with `rsubmit`
				6. Run `Proc append` through `gpfdist`
				7. 3 Port numbers are get from Gpfdist_Ports (Port_name + MP). 3 Ports needs for 3 tries to copy table.
				8. Check in `Gpfdist_Transform` whether to transform and BL_QUOTE
				9. Check number of rows in `UAT_T_STG`. For NTWK_AKTV deletes table from SAS. Was it successfull?
					- Yes: adds new row to `DDLSASTABLES`
					- No: deletes empty table from `UAT_T_STG` and from `EXT_`
	8. Was an error?
		- Yes:
			1. Change status to `TRN_SYS_ERROR`
			2. Saves error message to `error_details`
			3. Clears error flags in SAS
		- No:
			1. Change status to `TRN_DONE`









##                  Sequence 6

1. `run_stg_to_prod.sh` runs `./incoming/move_stg_to_prod.sas`
2. `./incoming/move_stg_to_prod.sas`:
	1. 








##                  Unknown

- `kill_stg_and_prod.sh` - kills process from `sas_to_stg_cycle.sh` (+ `run_sas_to_stg.sh`) and `stg_to_prod_cycle.sh` (+ `run_stg_to_prod.sh)









#                   Folders

- **/pids** - **ID**s of a current processes:
  - **unix_sas_stg_ro_prd**  - IDs of the last processes of copying data from **uat_t_stg** into **uat_t_base** from script `./incoming/move_stg_to_prod.sas`
  - **unix_sas_trn.pid** - IDs of the last transport processes from script `./incoming/transport_worker_mpp.sas`
- **/sql** - contains sql scripts:
  - `cpy_lists_sas_20221122.sql` - содержит данные для мета таблицы CPY_LISTS_SAS
  - `ddl_renamed_columns_20221122.sql` - содержит данные для мета таблицы DDL_RENAMED_COLUMNS
  - `ddl_uat_etl_meta.sql` - содержит ddl таблиц из схемы uat_etl_meta
  - `ddl_uat_t_base.sql` - содержит ddl таблиц из схемы uat_t_base. кроме таблиц форматов sas_fmt_*
  - `ddl_uat_v_base.sql` - содержит ddl вьюшек из схемы uat_v_base
  - `ddl_uat_v_base_sec.sql` - содержит ddl вьюшек из схемы uat_v_base_sec
  - `ddl_uat_v_cmptbl.sql` - содержит ddl вьюшек из схемы uat_v_cmptbl
  - `ddllookups_20221122.sql` - содержит данные для мета таблицы DDLLOOKUPS
  - `ddltables_20221122.sql` - содержит данные для мета таблицы DDLTABLES
  - `etl_sas_libnames_20221122.sql` - содержит данные для мета таблицы ETL_SAS_LIBNAMES
  - `sas_fmt_meta_20221122.sql` - содержит данные для мета таблицы SAS_FMT_META
  - `sasviewsfmt_20221122.sql` - содержит данные для мета таблицы SasViewsFmt
- **/logs** - logs. Logs older than 7 days go into logs/old
- **/incoming** - SAS scripts








#                 Questions

- Why there written that `cron` runs `add_copy_tasks_gps.sh`, and `start_stg_and_prod.sh` also runs it?
- Where `etl_sas_libnames` from:
	- SAS or Greenplum?
	- Scheme?
- **MR99** is a server?
- Where is list of active sessions?
- Where is `DDL_Rename_Columns`?
- Where is `DDLTables`?
- Does mythic error is the error that Alexander did show me before?
- What is **BL_QUOTE**?
- In Sequence 5.2.7.7.Yes.9 is written that `UAT_T_STG` is a table. Is it true? Or is it a mistake and `UAT_T_STG` is a scheme?