#!/bin/bash
echo "== IP forwarding"
sysctl -n net.ipv4.ip_forward

echo "== NAT kurallari"
sudo iptables -t nat -S POSTROUTING

echo "== wg0 arayuzu"
ip -br a show wg0 2>&1

echo "== Servisler"
for s in apache2 web-lab web-lab2 wg-quick@wg0; do
  echo "$s: $(systemctl is-active $s) / $(systemctl is-enabled $s 2>/dev/null)"
done
