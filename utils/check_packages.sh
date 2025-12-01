#!/bin/bash
# Функция проверки установленных пакетов

# Глобальный массив для хранения отсутствующих пакетов
declare -a MISSING_PACKAGES

check_packages() {
    echo "==> Проверка установленных пакетов..."

    # Список обязательных пакетов
    local packages=(
        "xl2tpd"
        "strongswan"
        "ppp"
        "remmina"
        "remmina-plugin-rdp"
        "remmina-plugin-vnc"
    )

    for pkg in "${packages[@]}"; do
        if dpkg -s "$pkg" >/dev/null 2>&1; then
            echo "  [+] $pkg установлен"
        else
            echo "  [!] $pkg НЕ установлен"
            MISSING_PACKAGES+=("$pkg")
        fi
    done

    # Если есть отсутствующие пакеты
    if [[ ${#MISSING_PACKAGES[@]} -gt 0 ]]; then
        echo ""
        echo "Необходимые пакеты отсутствуют:"
        for mp in "${MISSING_PACKAGES[@]}"; do
            echo "  - $mp"
        done
        echo ""
        echo "Вы можете установить их с помощью:"
        echo "  sudo apt install ${MISSING_PACKAGES[*]}"
        echo ""
    else
        echo "Все необходимые пакеты уже установлены."
    fi
}