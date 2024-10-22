#  Installation

## '-------- 0. (Optional) Set Wi-Fi

1) `iwctl` - now you are in the iwctl-interactive-prompt:
    1) `device list` - show your Wireless-Devices
    2) `device xDEVICE_NAMEx set-property Powered on`
    3) `station xDEVICE_NAMEx scan` - find allowable Wi-Fi Networks
    4) `station xDEVICE_NAMEx get-networks` - display found Wi-Fi Networks
    5) `station xDEVICE_NAMEx connect "xWi-Fi Network Namex (SSID)"`
2) `ping archlinux.org` - enshure that everything is OK
6) `timedatectl` - make shure that your time is OK




## '-------- 1. Partitioning

1) `cat /sys/firmware/efi/fw_platform_size` - first of all, you need to find whether your PC is 32, 64 bit and whether it support UEFI. If this command shows:
    - 64 - it is x64 and support UEFI
    - 32 - it is x32 and support UEFI (only 2 bootloaders you may use is systemd-boot and GRUB)
    - nothing/file does not exist - this system may be booted in BIOS or CSMmode
2) `fdisk -l` - shows all connected HDDs, SSDs and USBs
3) Find needed HardDrive
4) `parted /dev/xSDAx` - now you are in Parted:
    1) `mklabel gpt` - create a new GUID Partition Table
    2) `mkpart "EFI system partition" fat32 1MiB 1025MiB`   - create Partition with Partition-Type-GUID = fat32. (Do not use it if your PC does not support UEFI)
    3) `set 1 esp on`                                       - change Partition-Type-GUID from fat32 to C12A7328-F81F-11D2-BA4B-00A0C93EC93B (Do not use it if your PC does not support UEFI)
    4) `mkpart "swap partition" linux-swap 1025MiB 5121MiB` - create Partition with Partition-Type-GUID = 0657FD6D-A4AB-43C4-84E5-0933C84B4F4F
    5) `mkpart "root partition" ext4 512MiB 100%`           - create Partition with Partition-Type-GUID = ext4.
    6) `type 3 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709`        - change Partition-Type-GUID from EXT4  to 'Linux x86-64 root (/)'




## '-------- 2. Creating of File-Systems on Partitions

1) `mkfs.fat -F 32 /dev/xSDA1x`
2) `mkswap         /dev/xSDA2x`
2) `mkfs.ext4      /dev/xSDA3x`




## '-------- 3. Mount Partitions to the folders:

1) `mount --mkdir /dev/xSDA1x /mnt/boot`
2) `swapon        /dev/xSDA2x`
3) `mount         /dev/xSDA3x /mnt`




## '-------- 4. Install Linux-Kernel

1) `pacstrap -K /mnt base linux linux-firmware` - install base, Linux-Kernel and firmware for common hardware




## '-------- 5. Generation of fstab (automount) file

1) `genfstab -U /mnt >> /mnt/etc/fstab` - create fstab file that contains which partitions must be mounted during each boot.




## '-------- 6. Change which folder Linux treat as the root-folder (Root-Jailing)

1) `arch-chroot /mnt` - change where Linux will see `/` folder. Now it will be `/mnt/`, so users can't access bootloaders and others




## '-------- 7. Set time

1) `ln -sf /usr/share/zoneinfo/xREGIONx/xCITYx /etc/localtime` - set the Time-Zone
2) `hwclock --systohc`




## '-------- 8. Locales (System-Language and Input Language)

1) `vim /etc/locale.gen` - uncomment `en_US.UTF-8 UTF-8` and other needed UTF-8 locales.
2) `locale-gen` - Generate the locales
3) `vim /etc/locale.conf` - write `LANG=en_US.UTF-8` (or other, idk)
4) `vim /etc/vconsole.conf` - and write `KEYMAP=de-latin1` (or other, idk)




## '-------- 9. Name your PC

1) `vim /etc/hostname`  - write your `xHOSTNAMEx`




## '-------- 10. Set Root-User Password

1) `passwd` - sets the root-user password




## '-------- 11. Install Boot-Loader

1) `pacman -S grub efibootmgr`
2) `grub-install --target=x86_64-efi --efi-directory=/mnt/boot --bootloader-id=GRUB`
3) `grub-mkconfig -o /boot/grub/grub.cfg`




## '-------- 12. Restart the PC

1) `exit` - exit from `chroot`
2) `reboot` - now your Arch-Linux is installed!