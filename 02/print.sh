#!/bin/bash

print_about_os() {
    timedatectl set-timezone Europe/Moscow
    echo "HOSTNAME = $(hostname)"
    echo "TIMEZONE = $(timedatectl | grep 'Time zone' | awk '{print $3, $4, $5}')"
    echo "USER = $(whoami)"
    echo "OS = $(hostnamectl | grep 'Operating System' | sed 's/Operating System://')"
    echo "DATE = $(date | awk '{print $2, $3, $4, $5}')"
    echo "UPTIME = $(uptime -p )"
    echo "UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}')"
    echo "IP = $(ip r | grep 'default' | awk '{print $9}')"
    echo "MASK = $(ip r | grep 'dev' | awk 'NR==2 {print $1; exit}')"
    echo "GATEWAY = $(ip r | grep 'default' | awk '{print $3}')"
    echo "RAM_TOTAL = $(free | awk '/Mem:/{printf "%.3fGb\n", $2/(1024*1024)}')" #конвертация происходит kb to gb /1024^2
    echo "RAM_USED = $(free | awk '/Mem:/{printf "%.3fGb\n", $3/(1024*1024)}')"
    echo "RAM_FREE = $(free | awk '/Mem:/{printf "%.3fGb\n", $4/(1024*1024)}')"
    echo "SPACE_ROOT = $(df / | awk 'NR==2 {printf "%.2f MB\n", $2/1024}')" #disk free df / nr=2 cтрока вторая convert kb to mb /1024
    echo "SPACE_ROOT_USED = $(df / | awk 'NR==2 {printf "%.2f MB\n", $3/1024}')"
    echo "SPACE_ROOT_FREE = $(df / | awk 'NR==2 {printf "%.2f MB\n", $4/1024}')"
}