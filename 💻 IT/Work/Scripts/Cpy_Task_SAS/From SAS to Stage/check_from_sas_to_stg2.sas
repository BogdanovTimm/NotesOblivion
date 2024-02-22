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
    CREATE TABLE work.from_sas_to_stg AS
        SELECT
            /*
            INTCK('HOUR', task_copy_started_dt, DATETIME()) AS hours_between,
            task_copy_started_dt,
            DATETIME() 
                FORMAT DATETIME. AS current_time,
            */
            CASE
                WHEN task_status = 'TRN_RUN'
                    AND INTCK('HOUR', task_copy_started_dt, DATETIME()) > 24 
                THEN 
                    'RUNNING_24+_HOURS'

                WHEN task_status = 'TRN_RUN'
                    AND INTCK('HOUR', task_copy_started_dt, DATETIME()) > 10
                THEN 
                    'RUNNING_10-24_HOURS'
                WHEN task_status = 'TRN_RUN'  
                THEN 
                    'RUNNING_0-10_HOURS'

                WHEN task_status = 'ADDED'
                    AND INTCK('HOUR', task_add_dt, DATETIME()) > 24 
                THEN 
                    'PENDING_24+_HOURS'

                WHEN task_status = 'ADDED'
                    AND INTCK('HOUR', task_add_dt, DATETIME()) > 10 
                THEN 
                    'PENDING_10-24_HOURS'
                WHEN task_status = 'ADDED' 
                THEN 
                    'PENDING_0-10_HOURS'
                ELSE
                    '???'
            END AS current_status,
            COUNT(*) AS current_number
        FROM uat_meta.cpy_tasks_sas
        WHERE task_status = 'TRN_RUN'
            OR task_status = 'ADDED'
        GROUP BY current_status
        ORDER BY current_status DESC
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
