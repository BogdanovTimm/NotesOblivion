LIBNAME dskquota
    GREENPLM
    SERVER = 'gp-mis-dwh.pv.mts.ru'
    PORT = 5432
    USER ='tabogdanov'
    PASSWORD = 'yssw"i"#ZnJ0'
    DATABASE = 'dwh'
    SCHEMA = 'diskquota'
    CONNECTION = global
;

PROC SQL;
    CREATE TABLE work.diskquota AS
        SELECT
		    schema_name                                            AS schema            ,
            (nspsize_in_bytes / 10000000) / (quota_in_mb / 1000)
                    FORMAT = 3.                                    AS used_procent,
			nspsize_in_bytes / 1000000000
			        FORMAT = 10.                                   AS used_gb     ,
			(quota_in_mb / 1000) - (nspsize_in_bytes / 1000000000)
                    FORMAT = 10.                                   AS free_gb      ,
		    quota_in_mb / 1000                                     AS allowed_gb
		FROM 
		    dskquota.show_fast_schema_quota_view
		WHERE
		    schema_name IN ('uat_etl_meta',
		                    'uat_t_stg'   ,
		                    'uat_t_base'
		                   )
		ORDER BY
		    schema_name
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
    DATA = work.diskquota 
    NOOBS
    WIDTH = MIN;
RUN;
