---
layout: post
title: Hacking a Velo 640 to Install OPNsense
date: '2024-10-20 14:56:27 -0400'
---

I was recently made aware of the Velo 640 and the decent hardware it has in it.  By default this piece of hardware comes with VMware's VeloCloud installed on it, but for home users this is pretty useless.  There is an excellent thread on ServeTheHome [here](https://forums.servethehome.com/index.php?threads/dell-vep-vmware-edge-velo-cloud-sd-wan-veracloud-vep1400-vep1400-x-firewall-units.39392/) that has all the information I needed to wipe the default OS and install something much more useful, OPNsense.  The Velo 600 series line (and I'm assuming the other lines as well) is just a custom built computer with an Intel x86-64 CPU, so you can really install any OS you want on it.  Some people have even had success installing Proxmox and virtualizing their router.

Check out my page [here](/pages/velo/setup) for a detailed guide on how to update the device firmware, which disables the watchdog timer that restarts the device every 5 minutes, install OPNsense, and restore the GE interfaces if they are missing in OPNsense.
