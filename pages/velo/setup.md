---
layout: page
title: Velo Setup
---

This guide is a compilation of various posts in [this thread](https://forums.servethehome.com/index.php?threads/dell-vep-vmware-edge-velo-cloud-sd-wan-veracloud-vep1400-vep1400-x-firewall-units.39392/).  I decided to make this guide because I ran in to a lot of weird issues where commands didn't work or I had to do more investigation on the information provided.  That said, the thread was very helpful and pointed me in the right directions to get things working.  The steps below are how I got the BIOS updated and OPNsense installed.  The hardest part was getting DiagOS installed to update the BIOS.  Once you get DiagOS installed and booting correctly you should be golden.  The latest downloads for the VEP1400 series devices can be found [here](https://www.dell.com/support/home/en-us/product-support/product/dell-emc-networking-vep1445-vep1485/drivers)

1. If the device won't power on, try spreading apart the power pin in on the Velo with a tiny flat head screw driver.  I had to go pretty aggressive for it to make a good contact but don't go too crazy with it
   - Before
     - ![Power Plug Bad](/assets/img/velo/power-plug-bad.png)
   - After
     - ![Power Plug Good](/assets/img/velo/power-plug-good.png)
2. Install [the drivers for the CP2102](https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers?tab=downloads) that is built in to the Velo
3. Download [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) or your favorite serial port terminal
4. Take the plate off the back that covers the console port.  It's a single screw
   - ![Serial Console Plate On](/assets/img/velo/serial-console-plate-on.png)
   - ![Serial Console Plate Off](/assets/img/velo/serial-console-plate-off.png)
5. Plug the Velo in to your computer (you will need a USB A to Micro USB cable that has the data pins) and go to device manager.  If the drivers do not install automatically, right click the new device that is missing the driver and update it from the driver you downloaded in step 2.  Once the driver is installed take note of the COM port number and use that in PuTTY to connect.  Use these settings, substituting the COM port for your COM port
   - ![Putty Session Settings](/assets/img/velo/putty-session-settings.png)
   - ![Putty Serial Settings](/assets/img/velo/putty-serial-settings.png)
6. Burn [diagos-recovery-x86_64-dellemc_vep1400_c3538-r0.3.43.3.81-27.zip](https://www.dell.com/support/home/en-us/drivers/driversdetails?driverid=dmg5j) to a USB disk with [Rufus](https://rufus.ie/en/)
    >MAKE SURE TO SET TARGET SYSTEM TO UEFI OR INSTALL TO eMMC WILL FAIL!!!  I wasted hours on this.  I verified without a doubt this is the cause by setting up 2 other Velo 640's using the same steps
    {: .prompt-warning }
   - ![Rufus DiagOS Settings](/assets/img/velo/rufus-diagos-settings.png)
7. Download the BIOS image [VEP1400_UFW2.5_External.zip](https://www.dell.com/support/home/en-us/drivers/driversdetails?driverid=dftr4&oscode=nf901&productcode=dell-emc-networking-vep1445-vep1485) (expand Available formats) and put the extracted directory on the root of your DiagOS USB disk
8. Download the SSD Firmware image [Linux_DLMC2b_SFDN004E_20220315.zip](https://www.dell.com/support/home/en-us/drivers/driversdetails?driverid=4xjtp&oscode=nf901&productcode=dell-emc-networking-vep1445-vep1485) You have to download the `SSD-firmware-updater-eula.pdf` and click Accept at the bottom, or just use this [direct link](https://dl.dell.com/downloads/DLD1209).  Put the extracted directory on the root of your DiagOS USB disk
9. The key to a successful DiagOS install to the eMMC is booting the DiagOS Installer USB as UEFI.  If it still fails, some people suggest [Finnix](https://www.finnix.org/), a live Linux distro, to delete all partitions on the eMMC using `sfdisk --delete /dev/mmcblk0` and any other device that starts with `/dev/mmcblk0`
10. Insert the DiagOS installation USB disk you made in one of the 2 side USB A ports and boot from it
    - ![Side USB A Port](/assets/img/velo/side-usb-port.jpg)
11. After the DiagOS installer boots, select option 3 to install to eMMC.  This will take a minute or two and the device with automatically reboot when it's done.  When you see the memory test running, unplug the USB disk so it boots from the eMMC, or just go to the BIOS and select the eMMC as the boot option.  A successful install should look like this [DiagOS Installer Output](/pages/velo/diagos-installer-output)
    > Until you get the BIOS upgraded, any time you have a terminal prompt the first thing you should do is paste in `i2cset -y 1 0x22 0 0 b` so the watchdog doesn't reboot the device every 5 minutes.  After the BIOS is upgraded you don't need to do this any more
    {: .prompt-warning }
    > You will likely have to hit `Del` on boot to go in to the BIOS settings, go to the Save & Exit tab, and specifically boot from the UEFI boot option for your USB disk.  It will try to boot in MBR mode by default and you will get a warning that the disk is not set up for this
    > ![Boot USB UEFI](/assets/img/velo/boot-usb-uefi.png)
    {: .prompt-tip }
    - If the install still fails, create a USB boot disk for Finnix (above) and edit boot/grub/grub.cfg.  Add the following to the end of line 5 `console=tty0 console=ttyS0,115200n8`.  It should look like this
      - ![Grub Config](/assets/img/velo/grub-config.png)
    - Use the `sfdisk` commands above to delete all the partitions and try the install again
      > This grub setting should work for pretty much any distro, however, i2cset isn't available on pretty much anything by default so be aware that it WILL reboot at a set interval until the BIOS is updated.  Don't do anything important without the watchdog disabled and always do a cold boot or wait for a watchdog reset to attempt the partition deletions to give yourself enough time to do it
      {: .prompt-tip }
12. Once DiagOS is installed on the eMMC and booted, log in with the default username and password `root:calvin`
13. Plug in the DiagOS USB installer drive again if you took it out then mount it
    - `mkdir -p /mnt/sdb1`
    - `mount /dev/sdb1 /mnt/sdb1`
14. Copy the firmware file to `/root`
    > If you don't copy to and run from `/root` the update will fail
    {: .prompt-warning }
    - `cp /mnt/sdb1/VEP1400_UFW2.5_External/vep1400x_ufw_2.5 /root`
    - `cp -r /mnt/sdb1/Linux_DLMC2b_SFDN004E_20220315 /root`
15. Change to the `/root` directory if you are not already there
    - `cd /root`
16. Flash the new BIOS
    - `./vep1400x_ufw_2.5 interactive`
    - Choose to Automatically update all firmware components
      > If you don't update everything you could have stability issues
      {: .prompt-warning }
    - ![Firmware Updater](/assets/img/velo/firmware-updater.png)
      > In the versions that are listed, the BIOS version is the number after the -.  In my case I'm going from version 10 to version 20.  The prefix is the same for every BIOS version.  `vep1400x_ufw_2.5` contains multiple BIOS versions for for the 600 line, so the prefix may not be the same for you
      {: .prompt-tip }
17. You will be prompted to reboot the device, go ahead and reboot
    - ![Firmware Update Reboot](/assets/img/velo/firmware-updater-reboot.png)
18. After the reboot, run the BIOS updater again from `/root`, select option 1 to automatically update all firmware components, and it will pick up where it left off
    - `./vep1400x_ufw_2.5 interactive`
    - ![Firmware Updater Updating BIOS](/assets/img/velo/firmware-updater-updating-bios.png)
    - ![Firmware Updater Updating CPLD](/assets/img/velo/firmware-updater-updating-cpld.png)
    - ![Firmware Updater Updating PIC](/assets/img/velo/firmware-updater-updating-pic.png)
    - When it's done it will automatically reboot
      - ![Firmware Updater Done](/assets/img/velo/firmware-updater-done.png)
      - Initializations will take quite some time, leave it go for a while and it will finish.  When the memory tests start it is done
19. Install the SSD Firmware if needed
    - Boot to DiagOS and log in
    - Run this command to check your SSD firmware version
      - `hdparm -I /dev/sda | grep Firmware`
      - ![SSD Firmware](/assets/img/velo/ssd-firmware.png)
      - If you are on version `SFDN0N5E` then you need to update.  If you are on version `SFDN004E` then you are already on the newest version and can skip the rest of these SSD firmware update steps
    - If you didn't copy the SSD firmware files to the eMMC in the BIOS update section, mount the flash drive and copy them now
      - `mount /dev/sdb1 /mnt/sdb1`
      - Copy the files from the flash drive to `/root`
        - `cp -r /mnt/sdb1/Linux_DLMC2b_SFDN004E_20220315 /root`
    - Change to the directory you copied
      - `cd /root/Linux_DLMC2b_SFDN004E_20220315`
    - Use lsblk to identify your SSD
      - `lsblk`
      - Look for the drive that is larger than 16GB, probably /dev/sda.  In my case I have a 16GB flash drive, a 256GB SSD, and a 16GB eMMC
      - ![SSD lsblk](/assets/img/velo/ssd-lsblk.png)
    - Execute the updater
      - `./DLMC2`
      - Put in the disk we identified with `lsblk` when it asks for the device path
      - Wait for it to update
        - ![SSD Updating](/assets/img/velo/ssd-updating.png)
    - After a while it will tell you it was successful.  It takes a minute or two
      - ![SSD Update Successful](/assets/img/velo/ssd-update-successful.png)
    - At this point all the firmware is updated.  Reboot and unplug your USB disk when it gets to the memory test, you won't need this USB installer disk any more
20. After it reboots, hold in the reset button until you see `Factory Reset!!`.  Some people have reported that they don't see all their network interfaces until this is done, some also said they had to hit the reset button on the top of the board near the network ports.  I held the reset button and everything worked fine first try for me on a 640 but on a 640N even after holding the reset button on the back OPNsense only saw the 2 SPF+ ports.  Instructions for resetting the BIOS are [here](/pages/velo/bios-reset)
    - ![Factory Reset](/assets/img/velo/factory-reset.png)
      > You will see `Factory Reset!!` on every boot.  It doesn't appear to actually be resetting anything.  This must be a bug, or simply a warning to tell you it has been reset with the reset button.  If you follow the steps [here](/pages/velo/bios-reset) to reset the BIOS, this warning will also go away
      {: .prompt-tip }
21. Go in to the BIOS and update settings.  If it asks you for a password, the default password is the service tag with an ! on the end ex. `XXXXXXX!`
    - On the Save & Exit tab do a Restore Defaults for good measure
      - ![BIOS Restore Defaults](/assets/img/velo/bios-restore-defaults.png)
    - On the IntelRCSetup tab enter Processor Configuration and Enable Turbo mode.  I don't know if this actually does anything with the CPU in the 640, but more turbo is always more better right?
      - ![BIOS Turbo Mode](/assets/img/velo/bios-turbo-mode.png)
    - On the Security tab remove or change the BIOS password.  If there is already a password it's likely the default (see above)
      - ![BIOS Set Password](/assets/img/velo/bios-set-password.png)
    - On the Save & Exit tab do a Save Changes and Exit
      - ![BIOS Save and Exit](/assets/img/velo/bios-save-exit.png)
22. Download [OPNsense](https://opnsense.org/download/) select serial for the image type
    > The Velo 600 series is literally just a custom built computer with an Intel x86-64 CPU.  You can install any OS you want.  May people have posted that they installed Proxmox and virtualized their router as well
    {: .prompt-tip }
23. Burn your image of choice to a USB drive with Rufus - your only option should be UEFI mode if you chose OPNsense, but if your image doesn't force UEFI make sure to select it
24. Boot from the USB disk and install your image to the 256GB SSD
25. Go in to the BIOS and set the boot order if it still boots to DiagOS
26. In OPNsense when you assign the interfaces you should see these available
    - ![OPNsense Interfaces](/assets/img/velo/opnsense-interfaces.png)
    - Here is a map of the ports on the physical hardware.  The order doesn't really make sense
      - ![OPNsense Interfaces Map](/assets/img/velo/opnsense-interfaces-map.png)
    - If you do not have all of these interfaces follow the steps [here](/pages/velo/bios-reset) to reset the BIOS
27. Your Velo now has OPNsense (or your choice of OS) on it
