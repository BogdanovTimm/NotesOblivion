#                  What it is?

Keeps track which tables are copied to `UAT_T_STG`, and which are copied to `UAD_T_BASE` and deleted from `UAST_T_STG`.
Maybe also it keeps track of which table in GreenPlum equal to which table in SAS.











#                  Used by

- `transport_worker_mpp.sas`
- `move_stg_to_prod.sas`