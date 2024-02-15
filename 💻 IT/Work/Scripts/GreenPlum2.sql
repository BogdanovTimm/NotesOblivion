SELECT /*pid,*/
    usename, 
    client_addr,
    state_change::timestamp(0) without time zone AS state_change, 
    current_timestamp - state_change as time_query, 
    state, 
    waiting_reason AS wr  , 
    substr(query, 1,2750) AS substr, 
    'SELECT gpadmin.terminate_backend('||pid||');' sql_stop_process  --запрос на убивание запроса, если вдруг он завис, берём запрос как есть в этом столбце и выполняем в бобре
    , 
    application_name, 
    rsgname, 
    rsgqueueduration, 
    waiting
    FROM gpadmin.pg_stat_activity_allusers 
    Where
        usename  in('prd_etl_usr') 
        and
        state <> 'idle'
        --and
        --query  like '%%"'
    order by
        usename desc, 
        wr, 
        substr
;
