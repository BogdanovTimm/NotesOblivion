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
		SELECT DISTINCT
			MAX(DATEPART(task_copy_started_dt))
				FORMAT = YYMMDD10.                                   AS last_start_date,
			MAX(task_status)                                         AS status,
            source_host_user                                         AS from_user,
			source_host                                              AS from_host,
			source_libname                                           AS from_library,
			target_memname                                           AS table_to_copy,
            COUNT(table_to_copy) -1                                  AS number_of_duplicates
		FROM gpscheme.cpy_tasks_sas
		WHERE
			task_status IN ('ADDED', 'TRN_RUN')
				AND (
                    (DATEPART(task_copy_started_dt) <= TODAY() - 1)
                    OR
                    (DATEPART(task_add_dt) <= TODAY() - 1)
                )

        GROUP BY
            table_to_copy
        ORDER BY
            last_start_date DESC,
			status DESC,
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
