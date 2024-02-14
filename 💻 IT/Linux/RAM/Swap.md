# What it is?

When you don't have 

# Can there be more than 1 swap file?

Yes

# Swappiness

swappiness = 0 избегать выгрузки процессов из физической памяти как можно дольше
swappiness = 100 говорит ядру агрессивно выгружать процессы из физической памяти и перемещать их в кеш подкачки

# Get information about swap

`swapon`

It gives you:
- NAME - path to swap file
- SIZE - size of a swap file

# Create new Swap file

1. `sudo dd if=/dev/zero of=/path/to/new/swapFile bs=1M count=4096 status=progress` - where:
	- bs - size of 1 block
	- count - amount of blocks. So, because 1 block = 1 Mb, 1Mb \* 4096 = 4Gb
	- status=progress - it is for you to see how swap creates
2. `sudo chmod 600 /path/to/new/swapFile`
3. `sudo mkswap /path/to/new/swapFile` - now it is created
4. `sudo swapon /path/to/new/swapFile` - enable swap file
5. `swapon` - now your new swap file should be visible. But after rebooting, it will be deleted. But we can work it out.
6. `sudo nano /etc/fstab`
7. You need to add this to the `/etc/fastab` file:
```bash
/path/to/new/swapFile none swap sw 0 0
```
8. Now everything is done and your swap file will be saved forever

# Stop swap

`sudo swapoff /path/to/swapFile`

# Enable swap file

`sudo swapon /path/to/swapFile`

# Delete swap file

1. `sudo swapoff /path/to/swapFile`
2. `sudo rm /path/to/swapFile`









# Which files get into swap

Old files are placed into swap, so swap will be full, although there may be a lot of RAM