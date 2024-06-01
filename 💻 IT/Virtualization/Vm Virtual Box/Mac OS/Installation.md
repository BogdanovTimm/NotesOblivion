1. Download Mac OS.iso
2. Download Boot.vmdk file
3. Enable Invidia Virtualization or AMD Virtualizatin in BIOS
4. Create new Virtual OS in VirtualBox, but don not run it
5. Change motherboard chipset to PIIX 3
6. Change Virtual Video Memory to 128
7. Change Boot Order by removing everything except Hard Disk
8. Go to Storage
9. Click on hard disk and choose your Boot.vmdk
10. Close Virtual Box
11. Run this commands:
    ```shell
    cd "C:/Program Files/Oracle/VirtualBox/" # Folder where Virtual Box is installed
    ./VBoxManage.exe modifyvm     "xVIRTUAL MACHINE NAMEx" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
    ./VBoxManage.exe setextradata "xVIRTUAL MACHINE NAMEx" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
    ./VBoxManage.exe setextradata "xVIRTUAL MACHINE NAMEx" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
    ./VBoxManage.exe setextradata "xVIRTUAL MACHINE NAMEx" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
    ./VBoxManage.exe setextradata "xVIRTUAL MACHINE NAMEx" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
    ./VBoxManage.exe setextradata "xVIRTUAL MACHINE NAMEx" VBoxInternal2/EfiGraphicsResolution 1920x1080
    ./VBoxManage.exe modifyvm     "xVIRTUAL MACHINE NAMEx" --vram 256
    ```
12. Open Virtual Box
13. Start installation
14. Wait for GUI to appear
15. Choose **Disk Utility**
16. Choose **VBOX HARDDISK Media**
17. Click on format