#!/bin/sh

ifconfig tun0 10.0.0.1 pointopoint 10.0.0.2 mtu 1400 up
echo 1 > /proc/sys/net/ipv4/ip_forward
# iptables -t nat -A POSTROUTING -s 10.0.0.2/32 -o eth0 -j MASQUERADE
sudo nft add table nat
sudo nft add chain nat postrouting { type nat hook postrouting priority 100 \; }
nft add rule ip nat postrouting oifname eth0 ip saddr 10.0.0.2 counter masquerade
