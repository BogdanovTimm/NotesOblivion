LIBNAME gpscheme
    GREENPLM
    SERVER = 'gp-mis-dwh.pv.mts.ru'
    PORT = 5432
    USER ='tabogdanov'
    PASSWORD = 'yssw"i"#ZnJ0'
    DATABASE = 'dwh'
    SCHEMA = 'uat_etl_meta'
    CONNECTION = global
;

PROC SQL;
    CREATE TABLE work.from_sas_to_stg AS
		SELECT
			DATEPART(task_copy_started_dt)
				FORMAT = YYMMDD10.                       AS start_date,
            /*
			TIMEPART(task_copy_started_dt)
				FORMAT = TIME.                           AS start_time,
            */
			task_status                                  AS status_of_copying,
			source_host_user                             AS from_user,
			source_host                                  AS from_host,
			source_libname                               AS from_library,
		    /* 
            remote_user                                  AS to_user,
		    remote_host                                  AS to_host,
            */
			remote_path                                  AS to_scheme,
			target_memname                               AS table_to_copy
		FROM gpscheme.cpy_tasks_sas
		WHERE
			task_status IN ('ADDED', 'TRN_RUN')
				AND (DATEPART(task_copy_started_dt) <= TODAY() - 1)
        
        ORDER BY
            start_date DESC,
            /*
            start_time,
            */
			status_of_copying DESC,
			from_library,
			table_to_copy
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
    DATA = work.from_sas_to_stg 
    NOOBS
    WIDTH = MIN;
RUN;
