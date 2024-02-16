#                  What it is?

Copies from SAS to `UAT_T_STG` GreenPlum Scheme










#                  Uses

- `CPY_TASKS_SAS`
- `DDLTables`
- `DDLSasTables`
- `UAT_T_STG.^sas_tablename^`
- `UAT_T_STG.EXT_^sas_tablename^`
- `DDL_Renamed_columns`
- `Gpfdist_Ports`
- `Gpfdist_Transform`









#                  Sequence

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
		5. Use this name to find a row in `DDLTables`. Is it there?
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
