#                  What it is?

GreenPlum table that keepds tasks of tables that are copied fromm SAS to GreenPlum.









#                  Columns

- copy_task_id - just an id
- task_status - status of a task
- error_details - text of an error
- source_libname - SAS libname from which to copy
- target_memname - tablename in both SAS and in uat_t_stg Greenplum
- 