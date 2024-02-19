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

PROC sql;
	SELECT
		task_copy_started_dt                         AS start_date,
		task_copy_finished_dt                        AS finish_date,
		task_copy_finished_dt - task_copy_started_dt
            FORMAT=time.                             AS time_of_copying,
		/*task_add_dt                                  AS creating_of_task_date,*/
		task_status                                  AS status_of_copying,
		source_host_user || '@' || source_host       AS user_host_sas,
		source_libname || '.' || target_memname      AS libname_table_sas,
		'-->'                                        AS direction_of_copying,
		remote_user || '@' || remote_host            AS user_host_greenplum,
		remote_path || '.' || target_memname         AS scheme_table_greenplum,
		TODAY() - 1 AS yesterday,
        TODAY() AS today
	FROM gpscheme.CPY_TASKS_SAS
	WHERE
		task_status IN ('ADDED', 'TRN_RUN')
			AND (DATEPART(task_add_dt) < TODAY()
				 OR task_copy_started_dt IS NULL
			)
		/*
		source_libname  like '%A_APP%'
		target_memname like '%SRVP_MR%' 
		*/
	ORDER BY
		task_status DESC,
		table_priority,
		source_host,
		source_host_user,
		copy_task_id DESC
	;
QUIT;
