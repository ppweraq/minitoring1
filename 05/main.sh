#!/bin/bash

if ! [[ -s "$1" ]]; then
  echo "Пожалуйста, введите путь директории (например: /bin/)"
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

source ./func.sh

start_timer=$(date +%s)
echo "Total number of folders (including all nested ones) = $(number_of_folders "$1")"
echo "Top 5 folders of maximum size arranged in descending order (path and size):
$(top_folders "$1" 5)"
echo "Total number of files = $(get_file_count "$1")"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $(get_file_count_by_extension "$1" "conf")"
echo "Text files = $(get_file_count_by_extension "$1" "txt")"
echo "Executable files = $(get_file_count_by_extension "$1" "exe")"
echo "Log files (with the extension .log) = $(get_file_count_by_extension "$1" "log")"
echo "Archive files = $(archive_file "$1")"
echo "Symbolic links = $(symbol_links "$1")"
echo "Top 10 files of maximum size arranged in descending order (path, size and type): 
$(get_top_files "$1" 10)"
echo "Top 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):
$(get_top_executables "$1" 10)"
end_timer=$(date +%s) 
timer_amount=$(($end_timer - $start_timer))
echo "Script execution time (in seconds) = $timer_amount"