# Installation

## '-------- 1. Partitioning

1) `fdisk -l` - shows all connected HDDs, SSDs and USBs
2) Find needed HardDrive
3) `parted /dev/xSDAx` - now you are in Parted:
    1) `mklabel gpt` - create a new GUID Partition Table
    2) 