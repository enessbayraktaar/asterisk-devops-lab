# Asterisk DevOps Lab

Call center (Asterisk) ürünü için Linux, network, otomasyon ve cloud öğrenme lab'ı.

## VM'ler

| VM | OS | IP | Rol |
| --- | --- | --- | --- |
| gw01 | Ubuntu 24.04 | 192.168.56.11 | WireGuard, NAT, web servisleri |
| ops01 | Ubuntu 24.04 | ? | Netleşecek |
| pbx01 | CentOS Stream 9 | 192.168.56.12 | Asterisk (kurulacak) |
| db01 | CentOS Stream 9 | 192.168.56.13 | MariaDB (kurulacak) |
