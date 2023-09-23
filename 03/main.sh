#!/bin/bash


if [[ "$#" -ne 4 ]] ; then
    echo "Ошибка: скрипт запускается с параметрами. Введите 4 числовых параметра от 1 до 6"
    exit
elif ! [[ $1 =~ [1-6]$ && $2 =~ [1-6] && $3 =~ [1-6] && $4 =~ [1-6] ]] ; then
# elif  [[ $1 =~ $parametr || $2 =~ $parametr || $3 =~ $parametr || $4 =~ $parametr ]]; then
        echo "Ошибка: Числовые параметры от 1 до 6. Попробуйте еще раз."
        exit
elif [[ $1 -eq $2 ]] || [[ $3 -eq $4 ]]; then
        echo "Ошибка: Цвета шрифта и фона одного столбца не должны совпадать. Попробуйте еще раз."
        exit
fi

source ./print
# back() {
# case "$1" in
#         1) echo "\033[47m";; #white
#         2) echo "\033[41m";; #red
#         3) echo "\033[42m";; #green
#         4) echo "\033[44m";; #blue
#         5) echo "\033[45m";; ##purple
#         6) echo "\033[40m";; #black
# esac
# }

# font () {
# case "$1" in
#         1) echo "\033[37m";; #white
#         2) echo "\033[31m";; #red
#         3) echo "\033[32m";; #green
#         4) echo "\033[34m";; #blue
#         5) echo "\033[35m";; #purple
#         6) echo "\033[30m";; #black
# esac
# }

# back1=$(back $1)
# font2=$(font $2)
# back3=$(back $3)
# font4=$(font $4)
# zero='\e[0m'

# timedatectl set-timezone Europe/Moscow
# echo -e ${back1}${font2}HOSTNAME${NC}= ${back3}${font4}"$(hostname)"${zero}
# echo -e ${back1}${font2}TIMEZONE${zero} = ${back3}${font4}"$(timedatectl | grep 'Time zone' | awk '{print $3, $4, $5}')"${zero}
# echo -e ${back1}${font2}USER${zero} = ${back3}${font4}"$(whoami)"${zero}
# echo -e ${back1}${font2}OS${zero} = ${back3}${font4}"$(hostnamectl | grep 'Operating System' | sed 's/Operating System://')"${zero}
# echo -e ${back1}${font2}DATE${zero} = ${back3}${font4}"$(date | awk '{print $2, $3, $4, $5}')"${zero}
# echo -e ${back1}${font2}UPTIME${zero} = ${back3}${font4}"$(uptime -p )"${zero}
# echo -e ${back1}${font2}UPTIME_SEC${zero} = ${back3}${font4}"$(cat /proc/uptime | awk '{print $1}')"${zero}
# echo -e ${back1}${font2}IP${zero} = ${back3}${font4}"$(ip r | grep 'default' | awk '{print $9}')"${zero}
# echo -e ${back1}${font2}MASK${zero} = ${back3}${font4}"$(ip r | grep 'dev' | awk 'NR==2 {print $1; exit}')"${zero}
# echo -e ${back1}${font2}GATEWAY${zero} = ${back3}${font4}"$(ip r | grep 'default' | awk '{print $3}')"${zero}
# echo -e ${back1}${font2}RAM_TOTAL${zero} = ${back3}${font4}"$(free | awk '/Mem:/{printf "%.3fGb\n", $2/(1024*1024)}')"${zero}
# echo -e ${back1}${font2}RAM_USED${zero} = ${back3}${font4}"$(free | awk '/Mem:/{printf "%.3fGb\n", $3/(1024*1024)}')"${zero}
# echo -e ${back1}${font2}RAM_FREE${zero} = ${back3}${font4}"$(free | awk '/Mem:/{printf "%.3fGb\n", $4/(1024*1024)}')"${zero}
# echo -e ${back1}${font2}SPACE_ROOT${zero} = ${back3}${font4}"$(df / | awk 'NR==2 {printf "%.2f MB\n", $2/1024}')"${zero}
# echo -e ${back1}${font2}SPACE_ROOT_USED${zero} = ${back3}${font4}"$(df / | awk 'NR==2 {printf "%.2f MB\n", $3/1024}')"${zero}
# echo -e ${back1}${font2}SPACE_ROOT_FREE${zero} = ${back3}${font4}"$(df / | awk 'NR==2 {printf "%.2f MB\n", $4/1024}')"${zero}