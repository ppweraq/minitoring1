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
  sudo find "$1" -type f -exec du -h {} + | sort -rh | head 10 | awk '{print NR " - " $2 ", " $1}'
}

get_top_executables() {
 sudo find "$1" -type f -executable -exec du -b {} + | sort -rh | head -n 10 | awk '{print NR " - " $2 ", " $1/1024/1024 " MB, " system("md5sum " $2) | getline md5; print md5}'
}

start_time$(date +%s.%N)
echo "Total number of folders (including all nested ones) = $(find "$1" -type d | wc -l)"
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
echo "Top 10 files of maximum size arranged in descending order (path, size and type): $(get_top_files "$1" 10)"
echo "Top 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file): $(get_top_executables "$1" 10)"
end_time=$(date +%s.%N)
execution_time=$("$end_time - $start_time" | bc)
echo "Script execution time (in seconds) = $execution_time"