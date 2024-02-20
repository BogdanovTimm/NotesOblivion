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
    CREATE TABLE work.copying_errors2 AS
		SELECT
			/*
			DATEPART(task_copy_started_dt)
				FORMAT = YYMMDD10.                       AS start_date,
			TIMEPART(task_copy_started_dt)
				FORMAT = TIME.                           AS start_time,
			DATEPART(task_copy_finished_dt)
				FORMAT = YYMMDD10.                       AS finish_date,
			TIMEPART(task_copy_finished_dt)
				FORMAT = TIME.                           AS finish_time,
			task_status                                  AS status_of_copying,
			*/
			error_details                                AS log,
			source_host_user                             AS from_user,
			source_host                                  AS from_host,
			source_libname                               AS from_library,
			remote_user                                  AS to_user,
			remote_host                                  AS to_host,
			remote_path                                  AS to_scheme,
			target_memname                               AS table_to_copy
		FROM gpscheme.cpy_tasks_sas
		WHERE
			task_status IN ('TRN_SYS_ERROR')
				AND (DATEPART(task_copy_started_dt) >= TODAY() - 2
					OR
					DATEPART(task_copy_finished_dt) >= TODAY() - 2
					)
		ORDER BY
			/*
			status_of_copying DESC,
			start_date,
			start_time,
			*/
			from_host,
			to_host
			/*
			finish_date,
			finish_time
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
