---
layout: page
title: Velo DiagOS Installer Output
---

```Text
                             GNU GRUB  version 2.02

 +----------------------------------------------------------------------------+
 |*VEP1400 DiagOS Install                                                     |
 |                                                                            |
 |                                                                            |
 |                                                                            |
 |                                                                            |
 |                                                                            |
 |                                                                            |
 |                                                                            |
 |                                                                            |
 |                                                                            |
 |                                                                            |
 |                                                                            |
 +----------------------------------------------------------------------------+

      Use the ^ and v keys to select which entry is highlighted.
      Press enter to boot the selected OS, `e' to edit the commands
      before booting or `c' for a command-line.
Platform  : x86_64-dellemc_vep1400_c3538-r0
Version   : 3.43.3.81-27
Build Date: 2022-12-08T01:14-08:00
Info: Mounting kernel filesystems... done.
starting to install vep1400 DiagOS
discover: Rescue mode detected. No discover stopped.
[   13.780626] sd 6:0:0:0: [sdb] No Caching mode page found
[   13.786096] sd 6:0:0:0: [sdb] Assuming drive cache: write through
ONIE: Executing installer: /diag-installer-x86_64-dellemc_vep1400_c3538-r0-3.43.3.81-27-2022-12-08.bin
Ignoring Verifying image checksum ... OK.
cur_dir / archive_path /var/tmp/installer tmp_dir /tmp/tmp.tAAkeh
Preparing image archive ...sed -e '1,/^exit_marker$/d' /var/tmp/installer | tar xf - OK.
Diag-OS Installer: platform: x86_64-dellemc_vep1400_c3538-r0
platform found vep1400
platform vep1400 is supported.
console port ttyS0

****************************
Select Installation Device
****************************
1.SSD
2.USB Disk
3.eMMC
0.Quit
---------------------------
Please select the device type that DIAG OS will be install on : 3
Install Diag OS on eMMC
Checking device /dev/mmcblk0 size...
ok
ls: /boot/efi/EFI/*: No such file or directory

EDA-DIAG Partiton not found on mmc device /dev/mmcblk0.
Diag OS Installer Mode : INSTALL


Installing diag-os on mmc device
Checking mmc device presence...
ok
Initializing mmc device
Clearing GPT and MBR data structures
GPT data structures destroyed! You may now partition the disk using fdisk or
other utilities.
Clearing GPT and MBR data structures...ok

creating GPT disk label
Creating new GPT entries.
The operation has completed successfully.
creating GPT disk label...ok

Creating ESP on partition 1. size 128MB with label EFI System
Creating ESP on partition...ok

Creating file-system(vfat) on esp device /dev/mmcblk0p1 with label EFI System
mkfs.fat: warning - lowercase labels might not work properly with DOS or Windows
mkfs.fat 3.0.26 (2014-03-07)
Creating file-system(vfat) on esp...ok

Creating diags partition 2 size 2048MB with label EDA-DIAG
Creating diags partition...ok
Creating file-system on diags partition
mke2fs 1.42.13 (17-May-2015)
Discarding device blocks: done
Creating filesystem with 524288 4k blocks and 131072 inodes
Filesystem UUID: 286c218e-ab48-47f1-ab31-98a25bcdb555
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

Creating file-system on diags partition...ok

Mounted /dev/mmcblk0p2 on /tmp/tmp.EZfsLO

Preparing /dev/mmcblk0p2 EDA-DIAG for rootfs install
untaring into /tmp/tmp.EZfsLO

rootfs copy done
Success: Support tarball created: /tmp/tmp.EZfsLO/onie-support-dellemc_vep1400_c3538.tar.bz2
Updating diag-os ver in system-eeprom
Diagos ver 3.43.3.81-27
Deleting TLV 0x2e: Diag Version
Adding   TLV 0x2e: Diag Version
Programming passed.
TlvInfo Header:
   Id String:    TlvInfo
   Version:      1
   Total Length: 179
TLV Name             Code Len Value
-------------------- ---- --- -----
Product Name         0x21   9 EDGE640VN
Part Number          0x22   6 07071K
Serial Number        0x23  20 XXXXXXXXXXXXXXXXXXXX
Base MAC Address     0x24   6 XX:XX:XX:XX:XX:XX
Manufacture Date     0x25  19 08/14/2021 08:37:35
Device Version       0x26   1 1
Label Revision       0x27   3 A00
Platform Name        0x28  22 x86_64-dellemc_edge640
MAC Addresses        0x2A   2 64
Manufacturer         0x2B   5 DNG00
Country Code         0x2C   2 TW
Vendor Name          0x2D   8 Dell EMC
Service Tag          0x2F   7 XXXXXXX
Vendor Extension     0xFD  21  0x00 0x00 0x02 0xA2 0x20 0x78 0x7C 0xE0 0x15 0xA8 0xAA 0x45 0x3F 0x96 0x16 0x65 0x05 0x35 0xD3 0x49 0xC2
Diag Version         0x2E  12 3.43.3.81-27
CRC-32               0xFE   4 0x9495B6ED
Checksum is valid.
[VEP1400-X] Board ID : 0x0a
rootfs install ok

Mounted /dev/mmcblk0p1 on /tmp/tmp.qyptLr

Installing grub for diag-os
done
Updating EFI NVRAM Boot variables...
done

Updating Grub Cfg /dev/mmcblk0p2
clean up..done

INSTALLER DONE...
Please uninstall your USB disk out of box, wait 2 sec
Removing /tmp/tmp.tAAkeh
ONIE: NOS install successful: /diag-installer-x86_64-dellemc_vep1400_c3538-r0-3.43.3.81-27-2022-12-08.bin
ONIE: Rebooting...
This should be not reachable unless something wrong is there!!!!!
Info: BIOS mode: UEFI
Info: Using eth0 MAC address: XX:XX:XX:XX:XX:XX
Info: eth0:  Checking link... down.
ONIE: eth0: link down.  Skipping configuration.
ONIE: Failed to configure eth0 interface
Starting: klogd... done.
discover: Rescue mode detected. No discover stopped.
Stopping: dropbear ssh daemon... done.
Stopping: telnetd... done.
Stopping: klogd... done.
Stopping: syslogd... done.
Info: Unmounting kernel filesystems
umount: can't unmount /: Invalid argument
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
[   89.580382] reboot: Restarting system
```
