#!/bin/bash
# Основной скрипт установки

set -e  

# Пути к файлам с функциями
ADD_L2TP_SCRIPT="./utils/add_l2tp.sh"
AUTO_LOGIN_SCRIPT="./utils/auto_login.sh"
CHECK_PACKAGES_SCRIPT="./utils/check_packages.sh"
CHECK_ROOT_SCRIPT="./utils/check_root.sh"
INSTALL_PACKAGES_SCRIPT="./utils/install_packages.sh"
USERADD_SCRIPT="./utils/useradd.sh"

# Проверяем существование файлов с функциями
if [[ ! -f "$ADD_L2TP_SCRIPT" ]]; then
    echo "Ошибка: Файл $ADD_L2TP_SCRIPT не найден!"
    exit 1
fi

if [[ ! -f "$AUTO_LOGIN_SCRIPT" ]]; then
    echo "Ошибка: Файл $AUTO_LOGIN_SCRIPT не найден!"
    exit 1
fi

if [[ ! -f "$CHECK_PACKAGES_SCRIPT" ]]; then
    echo "Ошибка: Файл $CHECK_PACKAGES_SCRIPT не найден!"
    exit 1
fi

if [[ ! -f "$CHECK_ROOT_SCRIPT" ]]; then
    echo "Ошибка: Файл $CHECK_ROOT_SCRIPT не найден!"
    exit 1
fi

if [[ ! -f "$INSTALL_PACKAGES_SCRIPT" ]]; then
    echo "Ошибка: Файл $INSTALL_PACKAGES_SCRIPT не найден!"
    exit 1
fi

if [[ ! -f "$USERADD_SCRIPT" ]]; then
    echo "Ошибка: Файл $USERADD_SCRIPT не найден!"
    exit 1
fi

# Импортируем функции
source "$ADD_L2TP_SCRIPT"
source "$AUTO_LOGIN_SCRIPT"
source "$CHECK_PACKAGES_SCRIPT"
source "$CHECK_ROOT_SCRIPT"
source "$INSTALL_PACKAGES_SCRIPT"
source "$USERADD_SCRIPT"

# Проверяем права root
ensure_root "$@"

# Основная логика
echo "======================================"
echo "   Скрипт установки необходимых пакетов"
echo "======================================"
echo ""

# Шаг 1: Проверка пакетов
check_packages

# Шаг 2: Если есть отсутствующие пакеты, предлагаем установку
if [[ ${#MISSING_PACKAGES[@]} -gt 0 ]]; then
    echo ""
    install_packages
    
    # После установки проверяем еще раз
    echo ""
    echo "======================================"
    echo "     Повторная проверка пакетов"
    echo "======================================"
    MISSING_PACKAGES=()  # Очищаем массив
    check_packages
fi

# Шаг 3: Добавление пользователя
useradd

# Шаг 4: Настройка автоматического входа
auto_login

# Шаг 5: Добавление L2TP VPN
add_l2tp

echo ""
echo "======================================"
echo "       Установка завершена!"
echo "======================================"