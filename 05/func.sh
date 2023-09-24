#!bin/bash

number_of_folders (){
sudo find "$1" -type d | wc -l
}

top_folders() {
 sudo du -h "$1" | sort -hr | head -n 5 | awk '{print NR " - " $2 ", " $1}'
}

get_file_count() {
  sudo find "$1" -type f | wc -l
}

get_directory_size() {
  sudo du -sb "$1" | awk '{print $1}'
}

get_file_count_by_extension() {
  sudo find "$1" -type f -name "*.$2" | wc -l
}

archive_file (){
  sudo find $1 -regex '.*\(tar\|zip\|gz\|rar\)' | wc -l  
}

symbol_links(){
    sudo find "$1" -type l | wc -l
}



get_top_files() {
# Используем find для поиска файлов в указанной директории и её поддиректориях
# Затем используем du для получения размеров файлов, и sort для сортировки по размеру в обратном порядке
# Наконец, head выбирает первые 10 результатов, и awk форматирует вывод
sudo find "$1" -type f -exec du -sh {} + | sort -hr | head -n "$2" | awk '{printf "%d - %s, %sB\n", $1, $3, $2}'  
}

get_top_executables() {
sudo find "$1" -type f -executable -exec du -sh {} + | sort -hr | head -n "$2" | awk '{cmd = "md5sum " $3; cmd|getline result; printf "%d - %s, %sB, %s\n", $1, $3, $2, result}' | awk '{print $1,$2,$3,$4,$5}'
}