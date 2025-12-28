#!/bin/bash
# Функция добавления L2TP VPN соединения
add_l2tp() {
    nmcli --wait 10 connection add \
    con-name "Goreltex-Master" \
    type vpn \
    vpn-type l2tp \
    vpn.service-type org.freedesktop.NetworkManager.l2tp \
    vpn.data \
    "gateway=vpn.company.com,ipsec-enabled=yes,ipsec-psk=SHARED_SECRET_KEY,user=myusername,password-flags=0" \
    vpn.secrets "password=mypassword123" \
    ipv4.method auto \
    ipv4.dns-search "corp.company.ru" \
    ipv4.routes "10.0.1.0/24 0.0.0.0,192.168.10.0/24 0.0.0.0,172.16.100.0/22 0.0.0.0" \
    ipv4.ignore-auto-dns true \
    ipv4.dns-priority 50 \
    ipv6.method disabled
}  