libname gpscheme
    greenplm 
    server='gp-mis-dwh.pv.mts.ru' 
    port=5432 
    user='tabogdanov' 
    password='yssw"i"#ZnJ0' 
    database='dwh' 
    schema='uat_etl_meta' 
    connection=global
;

*data output_table;
*    set gpscheme.CPY_TASKS_SAS;
*run;

PROC sql;
    SELECT
	    task_copy_started_dt                         AS start_date,
	    task_copy_finished_dt                        AS finish_date,
	    task_copy_finished_dt - task_copy_started_dt AS time_of_copying,
	    task_status,
	    source_host_user || '@' || source_host       AS user_host_sas,
	    source_libname || '.' || target_memname      AS libname_table_sas,
	    remote_user || '@' || remote_host            AS user_host_greenplum,
	    remote_path || '.' || target_memname         AS greenplum_scheme
	FROM uat_etl_meta.CPY_TASKS_SAS
	WHERE
	    task_status IN (/*'ADDED',*/ 'TRN_RUN')
	        AND (task_copy_started_dt > current_date -  interval '1 day'
	             OR 
	             task_copy_started_dt IS NULL
	            )
	ORDER BY
	    task_status DESC,
	    table_priority,
	    source_host,
	    source_host_user,
	    copy_task_id DESC
    ;
QUIT;