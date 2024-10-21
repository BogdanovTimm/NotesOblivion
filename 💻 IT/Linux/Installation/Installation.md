# Installation

## '-------- 1. Partitioning

1) `fdisk -l` - shows all connected HDDs, SSDs and USBs
2) Find needed HardDrive
3) `parted /dev/xSDAx` - now you are in Parted:
    1) `mklabel gpt` - create a new GUID Partition Table
    2) `mkpart "EFI system partition" fat32 1MiB 1025MiB` - create simple Partition with Partition-Type-GUID = fat32.
    3) `set 1 esp on` - change Partition-Type-GUID from fat32 to the C12A7328-F81F-11D2-BA4B-00A0C93EC93B
    4) `mkpart "swap partition" linux-swap 1025MiB 5121MiB` - create Parition with Partition-Type-GUID = 0657FD6D-A4AB-43C4-84E5-0933C84B4F4F
    5) `mkpart "root partition" ext4 512MiB 100%` - create Partition with Partition-Type-GUID = ext4. This is where your Linux will be stored
    6) `type 3 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709` - change Partition-Type-GUID from EXT4 to 'Linux x86-64 root (/)'
4) Create File-Systems on the previously created Partitions:
    1) `mkfs.fat -F 32 /dev/xSDA1x`
    2) `mkswap /dev/xSDA2x`
    2) `mkfs.ext4 /dev/xSDA3x`
5) Mount Partitions to the folders:
    1) `mount --mkdir /dev/xSDA1x /mnt/boot`
    2) `swapon        /dev/xSDA2x`
    3) `mount         /dev/xSDA3x /mnt`
6) `pacstrap -K /mnt base linux linux-firmware` - install base, Linux-Kernel and firmware for common hardware
7) `genfstab -U /mnt >> /mnt/etc/fstab` - create fstab file that contains which partitions must be mounted during each boot.
8) `arch-chroot /mnt` - change where Linux will see `/` folder. Now it will be `/mnt/`, so users can't access bootloaders and others
9) `ln -sf /usr/share/zoneinfo/xREGIONx/xCITYx /etc/localtime` - set the Time-Zone
10) `hwclock --systohc`
11) Set Locales:
    1) `vim /etc/locale.gen` - uncomment `en_US.UTF-8 UTF-8` and other needed UTF-8 locales.
    2) `locale-gen` - Generate the locales
    3) `vim /etc/locale.conf` - write `LANG=en_US.UTF-8` (or other, idk)
    4) `vim /etc/vconsole.conf` - and write `KEYMAP=de-latin1` (or other, idk)
12) `vim /etc/hostname`  - write your `xHOSTNAMEx`
13) `passwd` - sets the root-user password
14) Install Bootloader...
15) `exit` - exit from `chroot`
16) `reboot` - now your Arch-Linux is installed!
17) 