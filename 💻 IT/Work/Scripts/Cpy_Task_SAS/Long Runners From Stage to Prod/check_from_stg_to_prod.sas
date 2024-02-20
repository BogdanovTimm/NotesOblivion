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
    CREATE TABLE work.from_stg_to_prod AS
		SELECT
            status,
			DATEPART(task_copy_started_dt)
                FORMAT = YYMMDD10.          AS start_date,
		    source_database                 AS from_database,
			source_table                    AS from_table,
			target_database                 AS to_database,
			target_table                    AS to_table
		FROM gpscheme.DDLControlTable
		WHERE
			status IN ('RUNNING', 'PENDING')
				AND (DATEPART(task_copy_started_dt) <= TODAY() -1 )
		ORDER BY
			status DESC,
			start_date DESC
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
    DATA = work.from_stg_to_prod 
    NOOBS
    WIDTH = MIN;
RUN;
