#!/bin/bash
# Скрипт для создания пользователя без пароля в системе
useradd() {
    echo "==> Создание пользователя 'user' без пароля..."

USERNAME="user"

# Создаем пользователя с домашней директорией и оболочкой /bin/bash
sudo useradd -m -s /bin/bash "$USERNAME"

# Устанавливаем пустой  пароль
sudo passwd -d "$USERNAME"
}