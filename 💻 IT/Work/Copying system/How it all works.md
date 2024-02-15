#                   Sequences

Sequence 1:
1. On **miscopy1**-server, `cron` runs `add_copy_tasks_gp.sh` every 2 hours
2. `add_copy_tasks_gp.sh` runs `./incoming/add_copy_tasks_gp.sas`

Sequence 2:
1. On **miscopy1**-server, `cron` runs `copy_formats_gp.sh` on 11:00 AM and 23:00
2. `copy_formats_gp.sh` runs `./incoming/copy_formats_gp.sas`

Sequence 3:
1. `start_stg_and_prod.sh` runs `sas_to_stg_cycle.sh`, `stg_to_prod_cycle.sh`, `add_copy_tasks_gp.sh` and `copy_formats_gp.sh`:
2. And then:
    - `sas_to_stg_cycle` checks number of processes `run_sas_to_stg.sh` every minute (in while-loop)
    - `add_copy_tasks_gp.sh` checks `sas_to_stg_cycle.sh` and `stg_to_prod_cycle.sh` and outputs list of **PID**s

Sequence 4:
1. On **miscopy1**-server, `cron` runs `sync_app_srvp_sas_online.sh` every 4 hours
2. `sync_app_srvp_sas_online.sh` runs `./incoming/sync_app_srvp_sas_onln.sas`
3. `./incoming/sync_app_srvp_sas_onln.sas` - synchronizing of table **dsrvp** and **dapp_app** with SAS Online.

Unknown time:
- `run_sas_to_stg.sh` - controls number of processes at the moment. Also it runs `./incoming/transport_worker_mpp.sas`
- `kill_stg_and_prod.sh` - kills process from `sas_to_stg_cycle.sh` (+ `run_sas_to_stg.sh`) and `stg_to_prod_cycle.sh` (+ `run_stg_to_prod.sh)










#                   Folders

- `pids` - **ID**s of a current processes:
  - **unix_sas_stg_ro_prd**  - IDs of the last processes of copying data from **uat_t_stg** into **uat_t_base** from script `./incoming/move_stg_to_prod.sas`
  - **unix_sas_trn.pid** - IDs of the last transport processes from script `./incoming/transport_worker_mpp.sas`
- **sql** - contains sql scripts:
  - cpy_lists_sas_20221122.sql - содержит данные для мета таблицы CPY_LISTS_SAS
  - ddl_renamed_columns_20221122.sql - содержит данные для мета таблицы DDL_RENAMED_COLUMNS
  - ddl_uat_etl_meta.sql - содержит ddl таблиц из схемы uat_etl_meta
  - ddl_uat_t_base.sql - содержит ddl таблиц из схемы uat_t_base. кроме таблиц форматов sas_fmt_*
  - ddl_uat_v_base.sql - содержит ddl вьюшек из схемы uat_v_base
  - ddl_uat_v_base_sec.sql - содержит ddl вьюшек из схемы uat_v_base_sec
  - ddl_uat_v_cmptbl.sql - содержит ddl вьюшек из схемы uat_v_cmptbl
  - ddllookups_20221122.sql - содержит данные для мета таблицы DDLLOOKUPS
  - ddltables_20221122.sql - содержит данные для мета таблицы DDLTABLES
  - etl_sas_libnames_20221122.sql - содержит данные для мета таблицы ETL_SAS_LIBNAMES
  - sas_fmt_meta_20221122.sql - содержит данные для мета таблицы SAS_FMT_META
  - sasviewsfmt_20221122.sql - содержит данные для мета таблицы SasViewsFmt
- logs - logs. Logs older than 7 days go into logs/old
- imcoming - SAS scripts






#                 Questions

- Why there written that `cron` runs `add_copy_tasks_gps.sh`, and `start_stg_and_prod.sh` also runs it?