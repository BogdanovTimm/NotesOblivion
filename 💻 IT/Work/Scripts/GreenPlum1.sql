select
    task_copy_started_dt,
    task_copy_finished_dt,
    task_copy_finished_dt - task_copy_started_dt AS t,  
    *
from uat_etl_meta.CPY_TASKS_SAS
where
    task_status not in('SKIPPED') /* <--- Original one */
    --and(source_size <50000000000) and table_priority >2
    --and source_libname  like '%A_APP%'
    --and target_memname like '%SRVP_MR%'
    --and task_status in('ADDED','TRN_RUN') /* <--- Original one */
    --source_nobs > 1000000000 /*and task_status ='TRN_DONE'*/
    --(error_details is not null and error_details <> '')
    and (task_copy_started_dt > current_date -  interval '1 day' or task_copy_started_dt is null) /* <--- Original one*/
    --and target_mtime  > current_date -  interval '4 day'
order by
    task_status desc,
    table_priority,
    source_host,
    source_host_user,
    copy_task_id desc;
