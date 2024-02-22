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
		SELECT
            waiting,
            SUBSTR(state_change, 1, 10) AS query_start_date,
            SUBSTR(state_change, 12, 8) AS query_start_time,
            state,
            client_addr,
            pid,
            /*
            application_name,
            */
            rsgname,
            /*rsgqueueduration,*/
            waiting_reason
            
        FROM
            gpadmin.pg_stat_activity_allusers 
        Where
            usename IN ('prd_etl_usr') 
                AND
                    state <> 'idle'
                        /*AND query  LIKE '%%"'*/
        ORDER BY
            state,
            query_start_date DESC,
            query_start_time DESC
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
