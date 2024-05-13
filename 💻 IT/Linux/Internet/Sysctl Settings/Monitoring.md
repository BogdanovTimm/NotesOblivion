Queues:
- `ethtool -l nic_card_name` - check number of queues.
  `ethtool -L nic_card_name queue_name 228` - Change number of queues (must be equal to number of cores in CPU). Системы с несколькими сетевыми картами, каждая из которых поддерживает несколько очередей, могут оказаться в ситуации, когда на один CPU зарегистрировано несколько NAPI-структур. Обработка данных всех структур на одном CPU «оплачивается» из одного и того же бюджета.
- `ethtool -g nic_card_name` - check the size of each queue from `ethtool -l nic_card_name`. 
  `ethtool -G nic_card_name queue_name 228` - set size of  from `ethtool -l nic_card_name`

Ntuple filtering (Intel Ethernet Flow Director):
- `ethtool -k nic_card_name | grep ntuple-filters\:` - check whether ntuple is enabled
  `ethtool -u nic_card_name` - check rules for a given NIC
  `ethtool -U nic_card_name flow-type tcp4 dst-port 80 action 2` - example of a ntuple rule

Detailed information:
- `ethtool -S nic_card_name | grep " rx_"` - detailed information about received
- `ethtool -S nic_card_name | grep " tx_"` - detailed information about sent

GRO:
- `ethtool -k nic_card_name | grep generic-receive-offload` - whether it is enabled
  `ethtool -K nic_card_name gro on` - enable GRO