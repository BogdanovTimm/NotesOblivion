SELECT
    DATE(createddt)           AS uat_t_stg_loadingd_date,
    load_status                                         ,
    libname || '.' || memname AS sas_library_table_name ,
    tablename                 AS uat_t_stg_table_name   ,
    targetname                AS uat_t_base_table_name  ,
    DATE(load_date_sas)       AS last_sas_change_date   ,
    DATE(load_date)           AS finish_date            ,
    DATE(rowupdatedt)
FROM
    uat_v_base.load_status_tables
WHERE 
    createddt >= current_date - 2
ORDER BY
    load_status,
    uat_t_stg_loadingd_date DESC