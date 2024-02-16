#                  What is is?

Add rows into `UAT_ETL_META.CPY_TASK_SAS` in GreenPlum.

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










#                  Uses

- `CPY_TASK_SAS`
- `DDL_TABLES`
- `CPY_LIST_SAS`