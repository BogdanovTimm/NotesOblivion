LIBNAME uat_meta
    GREENPLM
    SERVER = 'gp-mis-dwh.pv.mts.ru'
    PORT = 5432
    USER ='tabogdanov'
    PASSWORD = 'yssw"i"#ZnJ0'
    DATABASE = 'dwh'
    SCHEMA = 'uat_v_base'
    CONNECTION = global
;

PROC SQL;
    CREATE TABLE work.from_stg_to_prod AS
        SELECT
            /*
            INTCK('HOUR', createddt, DATETIME()) AS hours_between,
            createddt,
            DATETIME() 
                FORMAT DATETIME. AS current_time,
            */
            CASE
                WHEN load_status = ''
                    AND INTCK('HOUR', createddt, DATETIME()) > 72 
                THEN 
                    'RUNNING_OR_PENDING_72+_HOURS'

                WHEN load_status = ''
                    AND INTCK('HOUR', createddt, DATETIME()) > 24
                THEN 
                    'RUNNING_OR_PENDING_24+_HOURS'
                
                WHEN load_status = ''
                    AND INTCK('HOUR', createddt, DATETIME()) <= 24
                THEN 
                    'RUNNING_OR_PENDING_0-24_HOURS'

                WHEN load_status = 'CANCEL'
                    AND DATEPART(createddt) <= DATE() - 2
                THEN 
                    'CANCELLED_EARLIER_ON_THIS_WEEK'

                WHEN load_status = 'CANCEL'
                    AND DATEPART(createddt) = DATE() - 1 
                THEN 
                    'CANCELLED_YESTERDAY'
                
                WHEN load_status = 'CANCEL'
                    AND DATEPART(createddt) = DATE()
                THEN 
                    'CANCELLED_TODAY'
                
                ELSE
                    '???'
            END AS current_load_status,
            COUNT(*) AS current_number
        FROM
            uat_meta.load_status_tables
        WHERE
            load_status NOT IN ('FINISHED', 'CANCEL')
            OR (
            load_status IS NULL
            )
            OR (
            load_status  IN ('CANCEL')
                AND DATEPART(createddt) >= DATE() - 7
            )
        GROUP BY current_load_status
        ORDER BY current_load_status DESC
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
