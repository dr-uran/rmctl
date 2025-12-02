#!/bin/bash
# Скрипт: проверка прав root и попытка перезапуска с sudo

ensure_root() {
    if [ "$(id -u)" -ne 0 ]; then
        if command -v sudo >/dev/null 2>&1; then
            echo "Необходимы права root. Попытка перезапуска с sudo..."
            exec sudo -E bash "$0" "$@"
        else
            echo "Ошибка: нужны права root. Пожалуйста, запустите скрипт от root или установите sudo."
            exit 1
        fi
    fi
}