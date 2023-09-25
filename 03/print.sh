#!/bin/bash

source ./color.sh

timedatectl set-timezone Europe/Moscow
echo -e ${back1}${font2}HOSTNAME=${zero}${back3}${font4}"$(hostname)"${zero}
echo -e ${back1}${font2}TIMEZONE=${zero}${back3}${font4}"$(timedatectl | grep 'Time zone' | awk '{print $3, $4, $5}')"${zero}
echo -e ${back1}${font2}USER=${zero}${back3}${font4}"$(whoami)"${zero}
echo -e ${back1}${font2}OS=${zero}${back3}${font4}"$(hostnamectl | grep 'Operating System' | sed 's/Operating System://')"${zero}
echo -e ${back1}${font2}DATE=${zero}${back3}${font4}"$(date | awk '{print $2, $3, $4, $5}')"${zero}
echo -e ${back1}${font2}UPTIME=${zero}${back3}${font4}"$(uptime -p )"${zero}
echo -e ${back1}${font2}UPTIME_SEC=${zero}${back3}${font4}"$(cat /proc/uptime | awk '{print $1}')"${zero}
echo -e ${back1}${font2}IP=${zero}${back3}${font4}"$(ip r | grep 'default' | awk '{print $9}')"${zero}
echo -e ${back1}${font2}MASK=${zero}${back3}${font4}"$(ip r | grep 'dev' | awk 'NR==2 {print $1; exit}')"${zero}
echo -e ${back1}${font2}GATEWAY=${zero}${back3}${font4}"$(ip r | grep 'default' | awk '{print $3}')"${zero}
echo -e ${back1}${font2}RAM_TOTAL=${zero}${back3}${font4}"$(free | awk '/Mem:/{printf "%.3fGb\n", $2/(1024*1024)}')"${zero}
echo -e ${back1}${font2}RAM_USED=${zero}${back3}${font4}"$(free | awk '/Mem:/{printf "%.3fGb\n", $3/(1024*1024)}')"${zero}
echo -e ${back1}${font2}RAM_FREE=${zero}${back3}${font4}"$(free | awk '/Mem:/{printf "%.3fGb\n", $4/(1024*1024)}')"${zero}
echo -e ${back1}${font2}SPACE_ROOT=${zero}${back3}${font4}"$(df / | awk 'NR==2 {printf "%.2f MB\n", $2/1024}')"${zero}
echo -e ${back1}${font2}SPACE_ROOT_USED=${zero}${back3}${font4}"$(df / | awk 'NR==2 {printf "%.2f MB\n", $3/1024}')"${zero}
echo -e ${back1}${font2}SPACE_ROOT_FREE=${zero}${back3}${font4}"$(df / | awk 'NR==2 {printf "%.2f MB\n", $4/1024}')"${zero}