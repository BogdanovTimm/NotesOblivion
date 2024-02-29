LIBNAME uat_meta
    GREENPLM
    SERVER = 'gp-mis-dwh.pv.mts.ru'
    PORT = 5432
    USER ='tabogdanov'
    PASSWORD = 'yssw"i"#ZnJ0'
    DATABASE = 'dwh'
    SCHEMA = 'uat_etl_meta'
    CONNECTION = global
;

PROC sql;
    CREATE TABLE work.copying_errors2 AS
		SELECT
			datepart(task_copy_finished_dt)
				FORMAT = YYMMDD10.          AS error_date,
			/*source_host_user                             AS from_user,*/
			source_host                     AS from_host,
			count(*)                        AS number_of_errors
			/*
			source_libname                               AS from_library,
			remote_user                                  AS to_user,
			remote_host                                  AS to_host,
			remote_path                                  AS to_scheme,
			target_memname                               AS table_to_copy
			*/
		FROM uat_meta.CPY_TASKS_SAS
		WHERE
			task_status IN ('TRN_SYS_ERROR')
				AND datepart(task_copy_finished_dt) > DATE() - 2
		GROUP BY
			from_host,
			error_date
		ORDER BY
			error_date DESC
			/*
			to_host
			*/
    ;
QUIT;


OPTIONS
    LINESIZE = MAX 
    PAGESIZE = MAX
    NOCENTER 
    NOLABEL
    NONUMBER 
    NODATE
;

PROC PRINT
    DATA = work.copying_errors2 
    NOOBS
    WIDTH = MIN;
RUN;
