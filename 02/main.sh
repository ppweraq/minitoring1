#!/bin/bash

# Функция для вывода информации
print_info() {
    timedatectl set-timezone Europe/Moscow
    echo "HOSTNAME = $(hostname)"
    echo "TIMEZONE = $(timedatectl | grep 'Time zone' | awk '{print $3, $4, $5}')"
    echo "USER = $(whoami)"
    echo "OS = $(cat /etc/issue | awk '{print $1, $2, $3}')"
    echo "DATE = $(date '+%d %b %Y %H:%M:%S')"
    echo "UPTIME = $(uptime --p )"
    echo "UPTIME_SEC = $(cat /proc/uptime | awk '{print $1; exit}')"
    echo "IP = $(ip r get 8.8.8.8 | awk '{print $7; exit}')"
    echo "MASK = $(ip -o -f inet addr show | awk '/scope global/ {print $4; exit}')"
    echo "GATEWAY = $(ip -4 route | awk '{print $3; exit}')"
    echo "RAM_TOTAL = $(free | awk '/Mem:/{printf "%.3fGb\n", $2/(1024*1024)}')" #конвертация происходит kb to gb /1024^2
    echo "RAM_USED = $(free | awk '/Mem:/{printf "%.3fGb\n", $3/(1024*1024)}')"
    echo "RAM_FREE = $(free | awk '/Mem:/{printf "%.3fGb\n", $4/(1024*1024)}')"
    echo "SPACE_ROOT = $(df / | awk 'NR==2 {printf "%.2f MB\n", $2/1024}')" #disk free df / nr=2 cтрока вторая convert kb to mb /1024
    echo "SPACE_ROOT_USED = $(df / | awk 'NR==2 {printf "%.2f MB\n", $3/1024}')"
    echo "SPACE_ROOT_FREE = $(df / | awk 'NR==2 {printf "%.2f MB\n", $4/1024}')"
}

if [ "$#" -gt 0 ]; then
  echo "Скрипт запускается без аргументов"
  exit 1
else
    print_info
#   echo -n 
  read -p "Записать данные в файл? (Y/N): " answer
    if [[ "$answer" == ["y || Y"] ]];
    then
        file="$(date "+%d_%m_%y_%H_%M_%S.status")"
        print_info > "$file"
        echo "Создан файл с данными"
    else
        echo "Данные не записаны в файл"
    fi
fi