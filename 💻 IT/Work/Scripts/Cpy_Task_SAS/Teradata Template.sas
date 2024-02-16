/* libname this '.'; */

options sastrace=',,,d';

/* Allows you to use SQL */
proc sql noerrorstop;
    connect to teradata (server="0411td-prod.pv.mts.ru" 
                         user=TECH_MIS_PROBE 
                         password="$tdwallet(TECH_MIS_PROBE)"
    );
    
    CREATE TABLE freespace AS /* will be same */
        SELECT * 
        FROM connection to teradata (
            SELECT
                   DATABASENAME,
                   CAST(SUM(MAXPERM) AS NUMERIC(18)),
                   CAST(SUM(CURRENTPERM) AS NUMERIC(18)),
                   CAST((MAX(CURRENTPERM) * (HASHAMP() + 1)) AS NUMERIC(18))                AS SPACE,
                   CAST(SUM(MAXPERM) - SUM(CURRENTPERM) AS NUMERIC(18))                     AS PERM_FREE,
                   CAST(SUM(MAXPERM) - (MAX(CURRENTPERM) * (HASHAMP() + 1)) AS NUMERIC(18)) AS SPACE_FREE,
                   CAST(CAST((SUM(MAXPERM) - 
                                (MAX(CURRENTPERM) * (HASHAMP() + 1))) AS DECIMAL(18,2)
                            ) / SUM(MAXPERM) * 100.0 AS DECIMAL(8,2))                       AS SF_PERC
            FROM DBC.DISKSPACEV
            WHERE CURRENTPERM <> 0
                /*and ( DATABASENAME like any ('UAT_%', 'PRD_%', 'DBC', 'PDCRDATA') )*/
                AND (DATABASENAME LIKE any ('DBC', 
                                             'PDCRDATA',
                                             'PRD_ITGC',
                                             'PRD_C360%',
                                             'PRD_T1K%',
                                             'PRD_SBX_GENERAL',
                                             'UAT_T%',
                                             'PRD_ONLN%'
                                           )
                    )
            GROUP BY 1
            ORDER BY 1;
    );

    disconnect from teradata;
quit;

options
    linesize=max 
    pagesize=max 
    nocenter 
    nolabel 
    nonumber 
    nodate
;

title;

data freespacefmt;
    set freespace;
    format sum_maxperm_ sum_currentperm_ space perm_free space_free comma20.0 sf_perc comma6.2 ;
    drop space sum_currentperm_;
run;

proc print data=freespacefmt 
    noobs
    width=min;
run;
