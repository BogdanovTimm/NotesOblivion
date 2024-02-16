#                  What it is?

Deals with all formats










#                  Uses

- UAT_T_STG.SAS_FORMATS
- UAT_T_BASE.SAS_FORMATS
- SAS_FMT_META
- UAT_T_BASE
- UAT_V_BASE
- UAT_V_FMT










#                  Sequence

1. On **miscopy1**-server, `cron` runs `copy_formats_gp.sh` on 11:00 AM and 23:00
2. `copy_formats_gp.sh` runs `./incoming/copy_formats_gp.sas`
3. `./incoming/copy_formats_gp.sas`:
	1. Get list of formats to copy from .csv `/sas/dwh/other/cpy_system/copy_lists/formats/fmt_upload_tasks.csv` `WHERE copy_group=daily_common.to_teradata`
	2. Adds all formats to `UAT_T_STG.SAS_FORMATS` through 8085 port. If fails - through 8086.
	3. Clears (?) and then add last versions of formats into `UAT_T_BASE.SAS_FORMATS`
	4. Deletes tables and views which are not in `SAS_FMT_META`, but in `UAT_T_BASE`, `UAT_V_BASE` or `UAT_V_FMT` and their name starts with `sas_fmt%` or `is_disabled = 1`
	5. Runs SAS function `%m_DDL_PREPARE_SAS_FMT_TABLE`