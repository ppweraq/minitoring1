#!bin/bash

number_of_folders (){
sudo find "$1" -type d | wc -l
}

max_size_folders() {
 sudo du -h "$1" | sort -hr | head -n 5 | awk '{print NR " - " $2 ", " $1}'
}

count_of_file() {
  sudo find "$1" -type f | wc -l
}

count_of_extension_files() {
  sudo find "$1" -type f -name "*.$2" | wc -l
}

archive_file (){
  sudo find $1 -regex '.*\(tar\|zip\|gz\|rar\)' | wc -l  
}

symbol_links(){
    sudo find "$1" -type l | wc -l
}

get_directory_size() {
  sudo du -sb "$1" | awk '{print $1}'
}

top_files () {
sudo find "$1" -type f -exec du -sh {} + | sort -hr | head -n "$2" | awk '{split($2, a, "."); printf "%d - %s, %sB, %s\n", NR, $2, $1, a[length(a)]}'
}

top_exec () {
sudo find "$1" -type f -executable -exec du -sh {} + | sort -hr | head -n "$2" | awk '{cmd = "md5sum " $2; cmd|getline result; printf "%d - %s, %sB, %s\n", NR, $2, $1, result}' | awk '{print $1,$2,$3,$4,$5}'
}