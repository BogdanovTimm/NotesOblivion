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

PROC SQL;
    CREATE TABLE work.from_stg_to_prod AS
        SELECT
            /*
            INTCK('HOUR', task_copy_started_dt, DATETIME()) AS hours_between,
            task_copy_started_dt,
            DATETIME() 
                FORMAT DATETIME. AS current_time,
            */
            CASE
                WHEN status = 'RUNNING'
                    AND INTCK('HOUR', task_copy_started_dt, DATETIME()) > 72 
                THEN 
                    'RUNNING_72+_HOURS'

                WHEN status = 'RUNNING'
                    AND INTCK('HOUR', task_copy_started_dt, DATETIME()) > 24
                THEN 
                    'RUNNING_24+_HOURS'
                
                WHEN status = 'RUNNING'
                    AND INTCK('HOUR', task_copy_started_dt, DATETIME()) <= 24
                THEN 
                    'RUNNING_0-24_HOURS'

                WHEN status = 'PENDING'
                    AND INTCK('HOUR', task_copy_started_dt, DATETIME()) > 72
                THEN 
                    'PENDING_72+_HOURS'

                WHEN status = 'PENDING 0-10 HOURS'
                    AND INTCK('HOUR', task_copy_started_dt, DATETIME()) > 24 
                THEN 
                    'PENDING_24+_HOURS'
                
                WHEN status = 'PENDING'
                    AND INTCK('HOUR', task_copy_started_dt, DATETIME()) <= 24
                THEN 
                    'PENDING_0-24_HOURS'
                
                ELSE
                    '???'
            END AS current_status,
            COUNT(*) AS current_number
        FROM
            uat_meta.DDLControlTable
        WHERE
            status IN ('RUNNING', 'PENDING')
        GROUP BY current_status
        ORDER BY current_status
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
