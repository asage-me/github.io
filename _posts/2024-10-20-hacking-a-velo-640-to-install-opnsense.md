---
layout: post
title: Hacking a Velo 640 to Install OPNsense
date: '2024-10-20 14:56:27 -0400'
---

I was recently made aware of the Velo 640 and its decent hardware. By default this piece of hardware comes with VMware's VeloCloud installed on it, but it's of little use to home users. ServeTheHome has an excellent thread [here](https://forums.servethehome.com/index.php?threads/dell-vep-vmware-edge-velo-cloud-sd-wan-veracloud-vep1400-vep1400-x-firewall-units.39392/) with all the information I needed to wipe the default OS and install OPNsense, which is far more useful. The Velo 600 series (and likely other lines) is just a custom built computer with an Intel x86-64 CPU, so you can install any x86-64 compatible OS. Some people have even had success installing Proxmox and virtualizing their router.

Check out my page [here](/pages/velo/setup) for a detailed guide on how to update the device firmware, which disables the watchdog timer that restarts the device every 5 minutes, install OPNsense, and restore the GE interfaces if they are missing in OPNsense.
