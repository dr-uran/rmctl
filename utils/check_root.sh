ensure_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Ошибка: скрипт должен быть запущен от root"
        echo "Пример: sudo ./install.sh"
        exit 1
    fi
}