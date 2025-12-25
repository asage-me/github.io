---
layout: post
title: QNAP Storage Expansion
date: '2025-12-24 13:34:32 -0500'
---

I've been on the very edge of running out of storage space on my NAS (QNAP TS-673A) for a couple years now.  Earlier this month, I hit only 200GB free space on my 10TB RAID array so it was time to take action.

My current setup is running 2 10TB Ironwolf drives and 4 2TB WD Red drives.  The 2 10TB drives are in a RAID 1 (mirror) and the 4 2TB drives are in a RAID 10 (striped mirror).  The 10TB drive RAID array is used for the QNAP system drive (internal software) and all the file shares I have set up (documents, multimedia, ISOs, software, etc).  The 2TB drive RAID array is used for iSCSI for Proxmox VMs and an NFS share for containers.

I have 4 new 10TB WD Red drives to replace the 4 2TB WD Red drives.  The goal is to temporarily move all the VM virtual disks to CEPH storage on the Proxmox cluster, and the containers NFS share will move to the 10TB RAID array.  To do that, some of the shares (software and ISOs) will be moved to an external HDD temporarily to make space.  Once everything is off the 2TB drives, they will be removed and the new 10TB drives will be inserted.  The first task will be to run a full test to make sure they are not DOA.  When the tests pass, the remaining shares will move to external HDDs and the mirror RAID array will be destroyed.  A new RAID 5 array will be created using all 6 of the 10TB drives.  I chose RAID 5 over RAID 6 due to RAID 5 wasting less usable space.  HDDs at large capacity are still very expensive and wasting 2 drives for the sake of redundancy wasn't justified for my use case.  I back up all data, with versioning, split up between 2 20TB external HDDs so even if I were to lose 2 drives in the RAID array at once I still have all the data to be restored.

I've started the process and will make another post with how it went and lessons learned.
