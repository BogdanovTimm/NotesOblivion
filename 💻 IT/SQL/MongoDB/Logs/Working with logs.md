#                  See last logs

1. `mongosh` - open Mongo DB shell
2. `show logs` - shows all group of logs
3. You may either:
    - `show log ^log_group_name_from_show_logs^`
    - `db.admonCommand({getLog:'^log_group_name_from_show_logs^'})`