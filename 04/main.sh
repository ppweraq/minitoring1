#!/bin/bash

# Проверка наличия конфигурационного файла

# if [ ! -f "$config_file" ]; then
#   echo "Ошибка: Конфигурационный файл ($config.conf) не найден."
#   exit 1
# fi

source config.conf
param1=$column1_background
param2=$column1_font_color
param3=$column2_background
param4=$column2_font_color

re='^(|[1-6 ]+)$'
if [[ $# -ne 0 ]]; then
        echo "Ошибка: скрипт запускается без параметра"
        exit
elif ! [[ $param1 =~ $re ]] || ! [[ $param2 =~ $re ]] || ! [[ $param3 =~ $re ]] || ! [[ $param4 =~ $re ]];
    then
        echo "Ошибка в конфигурационном файле: Числовые параметры от 1 до 6"
        exit
elif [[ $param1 -eq $param2 ]] || [[ $param3 -eq $param4 ]]; then
        echo "Ошибка в конфигурационном файле: Цвета шрифта и фона одного столбца не должны совпадать"
        exit
fi

back() {
case "$1" in
        1) echo "\033[47m";; 
        2) echo "\033[41m";;
        3) echo "\033[42m";;
        4) echo "\033[44m";;
        5) echo "\033[45m";;
        6) echo "\033[40m";;
esac
}

font () {
case "$1" in
        1) echo "\033[37m";; #font_color="white";; #white
        2) echo "\033[31m";; #font_color="red";; #red
        3) echo "\033[32m";; #font_color="green";; #green
        4) echo "\033[34m";; #font_color="blue";; #blue
        5) echo "\033[35m";; #font_color="purple";; #purple
        6) echo "\033[30m";; #font_color="black";; #black
esac
}

back1=$(back $param1)
font2=$(font $param2)
back3=$(back $param3)
font4=$(font $param4)
zero='\e[0m'

timedatectl set-timezone Europe/Moscow
echo -e ${back1}${font2}HOSTNAME${NC}= ${back3}${font4}"$(hostname)"${zero}
echo -e ${back1}${font2}TIMEZONE${zero} = ${back3}${font4}"$(timedatectl | grep 'Time zone' | awk '{print $3, $4, $5}')"${zero}
echo -e ${back1}${font2}USER${zero} = ${back3}${font4}"$(whoami)"${zero}
echo -e ${back1}${font2}OS${zero} = ${back3}${font4}"$(cat /etc/issue)"${zero}
echo -e ${back1}${font2}DATE${zero} = ${back3}${font4}"$(date | awk '{print $2, $3, $4, $5}' )"${zero} #'+%d %b %Y %H:%M:%S'
echo -e ${back1}${font2}UPTIME${zero} = ${back3}${font4}"$(uptime -p )"${zero}
echo -e ${back1}${font2}UPTIME_SEC${zero} = ${back3}${font4}"$(cat /proc/uptime | awk '{print $1; exit}')"${zero}
echo -e ${back1}${font2}IP${zero} = ${back3}${font4}"$(ip r get 8.8.8.8 | awk '{print $7; exit}')"${zero}
echo -e ${back1}${font2}MASK${zero} = ${back3}${font4}"$(ip -o -f inet addr show | awk '/scope global/ {print $4; exit}')"${zero}
echo -e ${back1}${font2}GATEWAY${zero} = ${back3}${font4}"$(ip r get 8.8.8.8 | awk '{print $3; exit}')"${zero}
echo -e ${back1}${font2}RAM_TOTAL${zero} = ${back3}${font4}"$(free | awk '/Mem:/{printf "%.3fGb\n", $2/(1024*1024)}')"${zero}
echo -e ${back1}${font2}RAM_USED${zero} = ${back3}${font4}"$(free | awk '/Mem:/{printf "%.3fGb\n", $3/(1024*1024)}')"${zero}
echo -e ${back1}${font2}RAM_FREE${zero} = ${back3}${font4}"$(free | awk '/Mem:/{printf "%.3fGb\n", $4/(1024*1024)}')"${zero}
echo -e ${back1}${font2}SPACE_ROOT${zero} = ${back3}${font4}"$(df / | awk 'NR==2 {printf "%.2f MB\n", $2/1024}')"${zero}
echo -e ${back1}${font2}SPACE_ROOT_USED${zero} = ${back3}${font4}"$(df / | awk 'NR==2 {printf "%.2f MB\n", $3/1024}')"${zero}
echo -e ${back1}${font2}SPACE_ROOT_FREE${zero} = ${back3}${font4}"$(df / | awk 'NR==2 {printf "%.2f MB\n", $4/1024}')"${zero}
echo
backgrounds=("gg" "white" "red" "green" "blue" "purple" "black")
fonts=("" "white" "red" "green" "blue" "purple" "black")
# Вывод информации о столбцах
echo "Column 1 background = ${column1_background:-default} (${backgrounds[$column1_background]})"
echo "Column 1 font color = ${column1_font_color:-default} (${fonts[$column1_font_color]})"
echo "Column 2 background = ${column2_background:-default} (${backgrounds[$column2_background]})"
echo "Column 2 font color = ${column2_font_color:-default} (${fonts[$column2_font_color]})"
