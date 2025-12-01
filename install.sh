#!/bin/bash
# Основной скрипт установки

set -e  # Прекратить выполнение при ошибках

# Пути к файлам с функциями
CHECK_PACKAGES_SCRIPT="./utils/check_packages.sh"
INSTALL_PACKAGES_SCRIPT="./utils/install_packages.sh"

# Проверяем существование файлов с функциями
if [[ ! -f "$CHECK_PACKAGES_SCRIPT" ]]; then
    echo "Ошибка: Файл $CHECK_PACKAGES_SCRIPT не найден!"
    exit 1
fi

if [[ ! -f "$INSTALL_PACKAGES_SCRIPT" ]]; then
    echo "Ошибка: Файл $INSTALL_PACKAGES_SCRIPT не найден!"
    exit 1
fi

# Импортируем функции
source "$CHECK_PACKAGES_SCRIPT"
source "$INSTALL_PACKAGES_SCRIPT"

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