#                  What it is?

GreenPlum table that keepds tasks of tables that are copied fromm SAS to GreenPlum.










#                  Used by

- `add_copy_tasks_gp.sh`
- `transport_worker_mpp`
- `move_stg_to_prod.sas`




#                  Columns

- copy_task_id - just an id
- task_status - status of a task {ADDED, TRN_RUN, TRN_DONE, TRN_SYS_ERROR, SKIPPED}
- error_details - text of an error
- source_libname - SAS libname from which to copy
- target_memname - tablename in both SAS and in `uat_t_stg` Greenplum
- source_size - size of original SAS table in bytes
- source_nobs - number of rows in the original SAS table
- task_add_dt - date of creating of a task
- table_priority
- remote_host - host to which to copy
- remote_user - user on host to which to copy
- remote_path - scheme name {`UAT_T_STG` | `UAT_T_BASE`}
- source_host - host from which to copy
- source_host_user - user from which to copy
- task_copy_started_dt - date of starting of a copying to GreenPlum
- task_copy_finished_dt - date of a finishind of a copying to GreenPlum
- source_bl_host - BL_Host for SAS keyword `proc append` (BulkLoad)