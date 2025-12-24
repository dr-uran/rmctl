#!/bin/bash
# Основной скрипт установки

set -e  # Прекратить выполнение при ошибках

# Подключаем проверку root и требуем права сразу
source "./utils/check_root.sh"
ensure_root "$@"

# Пути к файлам с функциями
CHECK_PACKAGES_SCRIPT="./utils/check_packages.sh"
INSTALL_PACKAGES_SCRIPT="./utils/auto_install_missing_packages.sh"
ADD_USER_SCRIPT="./utils/add_user.sh"
AUTO_LOGIN_SCRIPT="./utils/auto_login.sh"

# Проверяем существование файлов с функциями
if [[ ! -f "$CHECK_PACKAGES_SCRIPT" ]]; then
    echo "Ошибка: Файл $CHECK_PACKAGES_SCRIPT не найден!"
    exit 1
fi

if [[ ! -f "$INSTALL_PACKAGES_SCRIPT" ]]; then
    echo "Ошибка: Файл $INSTALL_PACKAGES_SCRIPT не найден!"
    exit 1
fi

if [[ ! -f "$ADD_USER_SCRIPT" ]]; then
    echo "Ошибка: Файл $ADD_USER_SCRIPT не найден!"
    exit 1
fi

if [[ ! -f "$AUTO_LOGIN_SCRIPT" ]]; then
    echo "Ошибка: Файл $AUTO_LOGIN_SCRIPT не найден!"
    exit 1
fi

# Импортируем функции
source "$CHECK_PACKAGES_SCRIPT"
source "$INSTALL_PACKAGES_SCRIPT"
source "$ADD_USER_SCRIPT"
source "$AUTO_LOGIN_SCRIPT"

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
    auto_install_missing_packages
    
    # После установки проверяем еще раз
    echo ""
    echo "======================================"
    echo "     Повторная проверка пакетов"
    echo "======================================"
    MISSING_PACKAGES=()  # Очищаем массив
    check_packages
fi

echo ""
echo "======================================"
echo "       Установка завершена!"
echo "======================================"