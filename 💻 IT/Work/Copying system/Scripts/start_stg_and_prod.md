#                  What it is?

Starts copying from SAS to GreenPlum









#                  Sequence

1. `start_stg_and_prod.sh` runs `sas_to_stg_cycle.sh`, `stg_to_prod_cycle.sh`, `add_copy_tasks_gp.sh` and `copy_formats_gp.sh`:
2. And then:
    - `sas_to_stg_cycle` checks number of processes `run_sas_to_stg.sh` every minute (in while-loop)
    - `add_copy_tasks_gp.sh` checks `sas_to_stg_cycle.sh` and `stg_to_prod_cycle.sh` and outputs list of **PID**s