LIBNAME gpscheme
    GREENPLM
    SERVER = 'gp-mis-dwh.pv.mts.ru' 
    PORT = 5432 
    USER = 'tabogdanov' 
    PASSWORD = 'yssw"i"#ZnJ0' 
    DATABASE = 'dwh' 
    SCHEMA = 'uat_etl_meta' 
    CONNECTION = global
;

PROC SQL;
    CREATE TABLE work.from_stg_to_prod AS
		SELECT DISTINCT
            MAX(status)                         AS status,
			MAX(DATEPART(task_copy_started_dt))
                FORMAT = YYMMDD10.              AS last_start_date,
			source_table                        AS table_in_uat_t_stg,
			target_table                        AS table_in_uat_t_base,
            COUNT(table_in_uat_t_stg) -1        AS number_of_duplicates
		FROM gpscheme.DDLControlTable
		WHERE
			status IN ('RUNNING', 'PENDING')
				AND (DATEPART(task_copy_started_dt) <= TODAY() - 1 )
        GROUP BY
		    table_in_uat_t_stg
        ORDER BY
			status DESC,
			last_start_date DESC,
            table_in_uat_t_stg
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
