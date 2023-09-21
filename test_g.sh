#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <path_to_directory>"
    exit 1
fi

directory="$1"

# Функция для вывода информации о каталоге
analyze_directory() {
    echo "Информация о каталоге: $directory"
    echo

    # Общее число папок, включая вложенные
    num_folders=$(find "$directory" -type d | wc -l)
    echo "Общее число папок, включая вложенные: $num_folders"

    # Топ 5 папок с самым большим весом
    echo "Топ 5 папок с самым большим весом в порядке убывания (путь и размер):"
    du -h --max-depth=1 "$directory" | sort -hr | head -n 6

    # Общее число файлов
    num_files=$(find "$directory" -type f | wc -l)
    echo "Общее число файлов: $num_files"

    # Число файлов разных типов
    echo "Число конфигурационных файлов (.conf): $(find "$directory" -type f -name '*.conf' | wc -l)"
    echo "Число текстовых файлов: $(find "$directory" -type f -exec file {} \; | grep -i 'text' | wc -l)"
    echo "Число исполняемых файлов: $(find "$directory" -type f -executable | wc -l)"
    echo "Число лог-файлов (.log): $(find "$directory" -type f -name '*.log' | wc -l)"
    echo "Число архивов: $(find "$directory" -type f -name '*.zip' -o -name '*.tar.gz' -o -name '*.rar' | wc -l)"
    echo "Число символических ссылок: $(find "$directory" -type l | wc -l)"

    # Топ 10 файлов с самым большим весом
    echo "Топ 10 файлов с самым большим весом в порядке убывания (путь, размер и тип):"
    find "$directory" -type f -exec du -h {} \; | sort -hr | head -n 11

    # Топ 10 исполняемых файлов с самым большим весом
    echo "Топ 10 исполняемых файлов с самым большим весом в порядке убывания (путь, размер и хеш):"
    find "$directory" -type f -executable -exec du -h {} \; | sort -hr | head -n 11

    echo
}

# Измеряем время выполнения скрипта
start_time=$(date +%s)
analyze_directory
end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "Время выполнения скрипта: $execution_time секунд"
