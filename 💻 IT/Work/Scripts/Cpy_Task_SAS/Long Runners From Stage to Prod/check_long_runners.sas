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
    CREATE TABLE work.long_runners2 AS
		SELECT
			task_copy_started_dt  AS start_date,
			task_copy_finished_dt AS finish_date,
		    source_database       AS from_database,
			source_table          AS from_table,
			target_database       AS to_database
			target_table          AS to_table,
			status
		FROM gpscheme.DDLControlTable
		WHERE
			task_status IN ('RUNNING', 'PENDING')
				AND (DATEPART(task_copy_started_dt) <= TODAY() -1 )
		ORDER BY
			status DESC,
			start_date
	;
QUIT;

OPTIONS
    LINESIZE = MAX 
    PAGESIZE = MAX
    NOCENTER 
    NOLABEL
    NONUMBER 
    NODATA
;

PROC PRINT
    DATA = work.long_runners2 
    NOOBS
    WIDTH = MIN;
RUN;
