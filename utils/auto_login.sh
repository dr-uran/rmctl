#!/bin/bash
# Настройка автоматического входа для пользователя
auto_login() {
USERNAME="user"
AUTO_LOGIN_CONF="/etc/lightdm/lightdm.conf.d/50-auto-login.conf"

# Создаем конфигурационный файл для автоматического входа
cat > "$AUTO_LOGIN_CONF" <<EOF
[Seat:*]
greeter-session=lightdm-gtk-greeter
autologin-user=$USERNAME
autologin-user-timeout=0
EOF
}