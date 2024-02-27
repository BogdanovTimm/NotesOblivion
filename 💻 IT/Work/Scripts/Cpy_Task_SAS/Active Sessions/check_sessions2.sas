LIBNAME gpadmin
    GREENPLM
    SERVER = 'gp-mis-dwh.pv.mts.ru' 
    PORT = 5432 
    USER = 'tabogdanov' 
    PASSWORD = 'yssw"i"#ZnJ0' 
    DATABASE = 'dwh' 
    SCHEMA = 'gpadmin' 
    CONNECTION = global
;

PROC SQL;
    CREATE TABLE work.active_sessions AS
		SELECT UNIQUE
            CASE
                WHEN INTCK('HOUR', INPUT(state_change, DATETIME.), DATETIME()) > 72
                THEN 
                    '72+_HOURS'

                WHEN INTCK('HOUR', INPUT(state_change, DATETIME.), DATETIME()) > 24
                THEN 
                    '24+_HOURS'

                WHEN INTCK('HOUR', INPUT(state_change, DATETIME.), DATETIME()) <= 24
                THEN 
                    '0-24_HOURS'

                ELSE
                    '???'
            END                                               AS time_in_hours,
            state                                                             ,
            CASE
                WHEN SUBSTR(application_name, 12, 3) = 'sas'
                THEN
                    'SAS_TO_UAT_T_STG'
                WHEN SUBSTR(application_name, 12, 3) = 'stg'
                THEN
                    'UAT_T_STG_TO_UAT_T_BASE'
                WHEN SUBSTR(application_name, 12, 3) IS NULL
                THEN
                    '???'
            END                                               AS type         ,
            COUNT(*) AS number_of_sessions
        FROM
            gpadmin.pg_stat_activity_allusers 
        WHERE
            usename IN ('prd_etl_usr') 
                AND
                    state <> 'idle'
        GROUP BY
            state,
			time_in_hours,
			type
        ORDER BY
            state
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
    DATA = work.active_sessions 
    NOOBS
    WIDTH = MIN;
RUN;
