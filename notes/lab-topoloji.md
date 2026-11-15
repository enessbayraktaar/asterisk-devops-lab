# Lab topolojisi

```
                 [ Internet / ev modemi 192.168.1.1 ]
                                 |
+---------------- Windows 11 host (VirtualBox) ----------------+
|                 [ VirtualBox NAT 10.0.2.0/24 ]               |
|                   kapi: 10.0.2.2                             |
|              enp0s3 |                    | enp0s3            |
|        +------------+---+         +------+---------+         |
|        | gw01           |  wg0    | ops01          |         |
|        | .56.11         |=========| .56.12         |         |
|        | wg 10.10.10.1  | UDP     | wg 10.10.10.2  |         |
|        +------------+---+ 51820   +------+---------+         |
|              enp0s8 |                    | enp0s8            |
|   [ Host-only ag 192.168.56.0/24, Windows: 192.168.56.1 ]    |
+--------------------------------------------------------------+
```

## Aglar
| Ag | Adres | Ne icin |
| --- | --- | --- |
| VirtualBox NAT | 10.0.2.0/24, kapi 10.0.2.2 | VM'lerin internete cikisi (her VM'de 10.0.2.15, birbirlerini goremezler) |
| Host-only | 192.168.56.0/24 | VM'ler arasi ve Windows <-> VM trafigi |
| WireGuard (wg0) | 10.10.10.0/24 | gw01-ops01 arasi sifreli tunel, host-only uzerinden tasinir |

## Makineler
| VM | Host-only | wg0 | Rol |
| --- | --- | --- | --- |
| gw01 | 192.168.56.11 | 10.10.10.1 (sunucu) | WireGuard sunucu, NAT, Apache |
| ops01 | 192.168.56.12 | 10.10.10.2 (istemci) | Split tunnel istemci, Apache, ileride Ansible |
| pbx01 | 192.168.56.13 | - | Asterisk (Hafta 3) |
| db01 | 192.168.56.14 | - | MariaDB (Hafta 8) |
| mon01 | 192.168.56.15 | - | Izleme (Faz 7) |

## Split tunnel
ops01 AllowedIPs = 10.10.10.1/32, 8.8.8.8/32
- 8.8.8.8 trafigi: ops01 wg0 -> gw01 wg0 -> gw01 MASQUERADE -> enp0s3 -> internet
- Diger her sey: ops01 enp0s3 uzerinden direkt cikar

## Bilinen durum (15 Kasim)
- Iki uçta da wg-quick@wg0 disabled -> reboot sonrasi tunel yok (bkz. troubleshooting/01)
