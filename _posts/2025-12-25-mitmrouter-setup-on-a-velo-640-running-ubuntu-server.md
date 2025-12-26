---
layout: post
title: mitmrouter Setup on a Velo 640 Running Ubuntu Server
date: '2025-12-25 20:00:13 -0500'
---

Matt Brown has a tool called mitmrouter [here](https://github.com/nmatt0/mitmrouter).  mitmrouter turns your device into a WiFi access point that can intercept and inspect network traffic from connected devices. This is useful for security research, IoT device analysis, and understanding how applications communicate over the network. By positioning yourself in the middle of the network traffic (man-in-the-middle), you can capture packets, monitor DNS requests, and even decrypt HTTPS traffic if you install your certificate on the target device.

He also has an excellent YouTube channel [here](https://www.youtube.com/@mattbrwn/videos) with hours of great content.  I recommend checking it out, I have learned a lot from him so far.

The Velo 640 seemed like an excellent choice for the mitmrouter since it already has many ethernet ports and a wifi card.  It's also fast enough that there should be no noticeable slowdowns when using the device being inspected.  Here are the steps I followed to get it installed:

1. Install ubuntu minimum install
    - Since the installer defaults to GUI mode, it is necessary to edit the grub boot loader by pressing e on the install option.  Once in the grub editor, add `console=ttyS0,115200n8` after `/casper/vmlinuz` and before `---`.  The entire line should read `linux        /casper/vmlinuz console=ttyS0,115200n8 ---`
    - Press Ctrl+x to boot with this modified entry
    - After installing, the OS should keep the grub entry, but if you don't see any output on boot you can make the same edit to `/etc/default/grub` and then use `sudo update-grub` to make the changes active
2. Install pre-reqs
    - `sudo apt install vim nano hostapd dnsmasq bridge-utils net-tools psmisc iptables`
3. Modify the script (full script below)
    - The parts of the script to edit are the interfaces and the addition of the port variable to dnsmasq
      > Ubuntu server runs systemd-resolved by default so we will get a port in use error and dnsmasq will fail to start.  Since dnsmasq also gives out DHCP for the WIFI and LAN connection, nothing will get an IP address when trying to connect.  If we disable systemd-resolved then we won't have DNS for the mitmrouter host while the script is not running.  We don't need dnsmasq for DNS, so a much simpler approach is to just change the port for dnsmasq and allow systemd-resolved to do its job responding on port 53 for all DNS requests.
      {: .prompt-tip }
4. If your device has no internet, check the value for ipv4 forwarding with `sysctl net.ipv4.ip_forward`.  If it is set to 0 you will need to change it to 1 with `sudo sysctl -w net.ipv4.ip_forward=1`.  This command is only temporary and will revert to 0 after a reboot.  To make the change permanent, edit `/etc/sysctl.conf` and uncomment the line `net.ipv4.ip_forward=1`.  As of writing this, it is on line 28.
5. Start the mitmrouter service as a script on boot
   - Create the service file `sudo nano /etc/systemd/system/mitmrouter.service` and insert the following:

    ``` bash
    [Unit]
    Description=My Custom Script Service
    After=network.target

    [Service]
    Type=simple
    ExecStart=/home/mitmadmin/mitmrouter/mitmrouter.sh up
    ExecStop=/home/mitmadmin/mitmrouter/mitmrouter.sh down
    Restart=on-failure
    User=root

    [Install]
    WantedBy=multi-user.target
    ```
   - Use `sudo systemctl daemon-reload` to load the new service, then `sudo systemctl enable mitmrouter.service` to enable it on boot, and finally `sudo systemctl start mitmrouter.service` to start it
   - Since we are running this service as root you will notice the modified script below does not include sudo
6. There are more things to set up to properly intercept traffic.  This post will solely focus on installing Ubuntu Server minimum on the Velo 640, getting the pre-reqs set up, and setting up a service for the script.  As is, you should be able to connect to the new SSID and browse the web like you would from any standard access point.  Later we will look at ways to set up a packet capture and send port 443 traffic to a proxy.  Using the packet capture we can see all plain text transmissions (non https/tls traffic) and with the proxy we will be able to insert our own certificate to decrypt the traffic and see all that data.  Note that unless you have a way of adding the root cert for the proxy to your target device, your traffic will likely not work unless there is a very insecure setting of not validating certificates.

Modified script:

``` bash
#!/bin/bash

# VARIABLES
BR_IFACE="br0"
WAN_IFACE="ens2f0"
LAN_IFACE="ens2f1"
WIFI_IFACE="wlp4s0"
WIFI_SSID="mitm-iot"
WIFI_PASSWORD="password"

LAN_IP="192.168.200.1"
LAN_SUBNET="255.255.255.0"
LAN_DHCP_START="192.168.200.10"
LAN_DHCP_END="192.168.200.100"
LAN_DNS_SERVER="1.1.1.1"

DNSMASQ_CONF="tmp_dnsmasq.conf"
HOSTAPD_CONF="tmp_hostapd.conf"

if [ "$1" != "up" ] && [ "$1" != "down" ] || [ $# != 1 ]; then
    echo "missing required argument"
    echo "$0: <up/down>"
    exit
fi

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}") 
cd $SCRIPT_RELATIVE_DIR

echo "== stop router services"
killall wpa_supplicant
killall dnsmasq

echo "== reset all network interfaces"
ifconfig $LAN_IFACE 0.0.0.0
ifconfig $LAN_IFACE down
ifconfig $BR_IFACE 0.0.0.0
ifconfig $BR_IFACE down
ifconfig $WIFI_IFACE 0.0.0.0
ifconfig $WIFI_IFACE down
brctl delbr $BR_IFACE

if [ $1 = "up" ]; then

    echo "== create dnsmasq config file"
    echo "interface=${BR_IFACE}" > $DNSMASQ_CONF
    echo "port=5353" >> $DNSMASQ_CONF
    echo "dhcp-range=${LAN_DHCP_START},${LAN_DHCP_END},${LAN_SUBNET},12h" >> $DNSMASQ_CONF
    echo "dhcp-option=6,${LAN_DNS_SERVER}" >> $DNSMASQ_CONF
    
    echo "create hostapd config file"
    echo "interface=${WIFI_IFACE}" > $HOSTAPD_CONF
    echo "bridge=${BR_IFACE}" >> $HOSTAPD_CONF
    echo "ssid=${WIFI_SSID}" >> $HOSTAPD_CONF
    echo "country_code=US" >> $HOSTAPD_CONF
    echo "hw_mode=g" >> $HOSTAPD_CONF
    echo "channel=11" >> $HOSTAPD_CONF
    echo "wpa=2" >> $HOSTAPD_CONF
    echo "wpa_passphrase=${WIFI_PASSWORD}" >> $HOSTAPD_CONF
    echo "wpa_key_mgmt=WPA-PSK" >> $HOSTAPD_CONF
    echo "wpa_pairwise=CCMP" >> $HOSTAPD_CONF
    echo "ieee80211n=1" >> $HOSTAPD_CONF
    #echo "ieee80211w=1" >> $HOSTAPD_CONF # PMF
    
    echo "== bring up interfaces and bridge"
    ifconfig $WIFI_IFACE up
    ifconfig $WAN_IFACE up
    ifconfig $LAN_IFACE up
    brctl addbr $BR_IFACE
    brctl addif $BR_IFACE $LAN_IFACE
    ifconfig $BR_IFACE up
    
    echo "== setup iptables"
    iptables --flush
    iptables -t nat --flush
    iptables -t nat -A POSTROUTING -o $WAN_IFACE -j MASQUERADE
    iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i $BR_IFACE -o $WAN_IFACE -j ACCEPT
    # optional mitm rules
    #iptables -t nat -A PREROUTING -i $BR_IFACE -p tcp -d 1.2.3.4 --dport 443 -j REDIRECT --to-ports 8081
    
    
    echo "== setting static IP on bridge interface"
    ifconfig $BR_IFACE inet $LAN_IP netmask $LAN_SUBNET
    
    echo "== starting dnsmasq"
    dnsmasq -C $DNSMASQ_CONF
    
    echo "== starting hostapd"
    hostapd $HOSTAPD_CONF
fi
```
