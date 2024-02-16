#                  What it is?

Syncronize SAS Online with SAS tables










#                  Uses

- `dsrvp`
- `dapp_app`









#                  Sequence 4

1. On **miscopy1**-server, `cron` runs `sync_app_srvp_sas_online.sh` every 4 hours
2. `sync_app_srvp_sas_online.sh` runs `./incoming/sync_app_srvp_sas_onln.sas`
3. `./incoming/sync_app_srvp_sas_onln.sas` - synchronizing of table **dsrvp** and **dapp_app** with SAS Online.