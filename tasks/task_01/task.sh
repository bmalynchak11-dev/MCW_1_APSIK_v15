#!/usr/bin/env bash
set -euo pipefail

# 1. Перевірка кількості аргументів
if [ "$#" -ne 1 ]; then
    echo "Використання: task.sh КАТАЛОГ" >&2
    exit 2
fi

TARGET_DIR="$1"

# 2. Перевірка існування каталогу
if [ ! -d "$TARGET_DIR" ]; then
    echo "Помилка: каталог не існує" >&2
    exit 3
fi

fixed_count=0

# Збір звичайних файлів безпосередньо в каталозі (без прихованих) в алфавітному порядку
shopt -s nullglob
files=()
for f in "$TARGET_DIR"/*; do
    if [ -f "$f" ]; then
        files+=("$f")
    fi
done

# 3, 4, 5. Обробка файлів та встановлення прав
for filepath in "${files[@]}"; do
    filename=$(basename "$filepath")
    
    # Визначення очікуваних прав
    case "$filename" in
        *.conf) expected_mode="640" ;;
        *.sh)   expected_mode="750" ;;
        *)      expected_mode="644" ;;
    esac

    # Отримання поточних прав у вісімковому форматі
    current_mode=$(stat -c "%a" "$filepath" 2>/dev/null || stat -f "%Lp" "$filepath")

    if [ "$current_mode" != "$expected_mode" ]; then
        chmod "$expected_mode" "$filepath"
        echo "FIXED $filename"
        fixed_count=$((fixed_count + 1))
    fi
done

# 6. Фінальний вивід
echo "Виправлено: $fixed_count"
exit 0