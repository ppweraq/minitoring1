#!/bin/bash

if ! [[ -s "$1" ]]; then
  echo "Пожалуйста, введите путь директории (например: /var/log/)"
  exit
fi
 
if [[ ! -d "$1" ]]; then
  echo "$1: Каталога не существует"
  exit
fi

last_symbol="${1: -1}"
if [ ${1: -1} != "/" ]; then
  echo Ошибка: в конце параметра отсутствует "/"
  exit
fi

get_directory_size() {
  sudo du -sb "$1" | awk '{print $1}'
}

get_file_count() {
  sudo find "$1" -type f | wc -l
}

get_file_count_by_extension() {
  sudo find "$1" -type f -name "*.$2" | wc -l
}

get_top_folders() {
 sudo du -h "$1"/* 2>/dev/null | sort -hr | head -n 5 | awk '{print NR " - " $2 "/, " $1}'
}

get_top_files() {
  if [ $# -eq 0 ]; then
    echo "Укажите директорию в качестве аргумента."
    exit 1
fi

# Используем find для поиска файлов в указанной директории и её поддиректориях
# Затем используем du для получения размеров файлов, и sort для сортировки по размеру в обратном порядке
# Наконец, head выбирает первые 10 результатов, и awk форматирует вывод
sudo find "$1" -type f -exec du -h {} + | sort -rh | head -n 10 | awk '{print NR " - " $2 ", " $1}' | awk -F '.'| while read line; do
    # Используем file для определения типа файла
    file_type=$(file -b "$line" | cut -d, -f1)
    echo "$line, $file_type"
done
  
  
  # sudo find "$1" -type f -exec du -h {} + | sort -rh | head -n 10 | awk '{print NR " - " $2 ", " $1}'
# find "$1" -type f -exec du -h {} \; | sort -hr | head -n 11 
}

get_top_executables() {
#  sudo find "$1" -type f -executable -exec du -b {} + | sort -rh | head -n 10 | awk '{print NR " - " $2 ", " $1/1024/1024 " MB, " system("md5sum " $2) | getline md5; print md5}'

sudo find "$1" -type f -executable -exec du -h {} + | sort -rh | head -n 10 | awk '{print NR " - " $2 ", " $1} '|  while read line; do
    # Получаем MD5-хеш файла
    md5_hash=$($(md5sum "$1" | awk '{print $1}'))
    echo "$file, $size , $md5_hash"
done

}

start_time=$(date +%s)
echo "Total number of folders (including all nested ones) = $(sudo find "$1" -type d | wc -l)"
echo "Top 5 folders of maximum size arranged in descending order (path and size):
$(get_top_folders "$1" 5)"
echo "Total number of files = $(get_file_count "$1")"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $(get_file_count_by_extension "$1" "conf")"
echo "Text files = $(get_file_count_by_extension "$1" "txt")"
echo "Executable files = $(get_file_count_by_extension "$1" "sh")"
echo "Log files (with the extension .log) = $(get_file_count_by_extension "$1" "log")"
echo "Archive files = $(get_file_count_by_extension "$1" "archive")"
echo "Symbolic links = $(find "$1" -type l | wc -l)"
echo "Top 10 files of maximum size arranged in descending order (path, size and type): 
$(get_top_files "$1")"
echo "Top 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):
 $(get_top_executables "$1" 10)"
end_time=$(date +%s)
execution_time=$("$end_time - $start_time")
echo "Script execution time (in seconds) = $execution_time"