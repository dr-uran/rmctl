#!/bin/bash
# Функция автоматической установки пакетов

install_packages() {
    if [[ ${#MISSING_PACKAGES[@]} -eq 0 ]]; then
        echo "Все необходимые пакеты уже установлены."
        return 0
    fi

    echo "==> Обнаружены отсутствующие пакеты:"
    for pkg in "${MISSING_PACKAGES[@]}"; do
        echo "  - $pkg"
    done

    echo ""
    read -rp "Установить недостающие пакеты? [y/N]: " answer

    if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
        echo "Пропуск установки пакетов."
        return 1
    fi

    echo "Определение пакетного менеджера..."

    # Определяем дистрибутив по наличию пакетного менеджера
    if command -v apt-get >/dev/null 2>&1; then
        PKG_MANAGER="apt"
    elif command -v dnf >/dev/null 2>&1; then
        PKG_MANAGER="dnf"
    elif command -v pacman >/dev/null 2>&1; then
        PKG_MANAGER="pacman"
    else
        echo "Ошибка: Не удалось определить пакетный менеджер."
        return 1
    fi

    echo "Установка пакетов через $PKG_MANAGER..."
    case "$PKG_MANAGER" in
        apt)
            sudo apt update
            sudo apt install -y "${MISSING_PACKAGES[@]}"
            ;;
        dnf)
            sudo dnf install -y "${MISSING_PACKAGES[@]}"
            ;;
        pacman)
            sudo pacman -Sy --noconfirm "${MISSING_PACKAGES[@]}"
            ;;
    esac

    echo "Установка завершена."
}