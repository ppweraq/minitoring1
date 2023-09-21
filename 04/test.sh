#!/bin/bash

# Проверка наличия конфигурационного файла
config_file="config.conf"
if [ ! -f "$config_file" ]; then
  echo "Ошибка: Конфигурационный файл '$config_file' не найден."
  exit 1
fi

# Загрузка параметров из конфигурационного файла
source "$config_file"

# Цветовая схема по умолчанию (если параметры не заданы)
 ="40" # Черный фон
default_column1_font="37" # Белый текст
default_column2_bg="41" # Красный фон
default_column2_font="34" # Синий текст

# Функция для вывода цветовой схемы
function display_color_scheme() {
  echo "Column 1 background = ${column1_background:-default} ($column1_bg_color)"
  echo "Column 1 font color = ${column1_font_color:-default} ($column1_font_color)"
  echo "Column 2 background = ${column2_background:-default} ($column2_bg_color)"
  echo "Column 2 font color = ${column2_font_color:-default} ($column2_font_color)"
}

# Определение цветовой схемы для Column 1
case "$column1_background" in
  1) column1_bg_color="black";;
  2) column1_bg_color="red";;
  3) column1_bg_color="green";;
  4) column1_bg_color="yellow";;
  5) column1_bg_color="blue";;
  6) column1_bg_color="purple";;
  *) column1_bg_color="default";;
esac

case "$column1_font_color" in
  1) column1_font_color="white";;
  2) column1_font_color="red";;
  3) column1_font_color="green";;
  4) column1_font_color="yellow";;
  5) column1_font_color="blue";;
  6) column1_font_color="purple";;
  *) column1_font_color="default";;
esac

# Определение цветовой схемы для Column 2
case "$column2_background" in
  1) column2_bg_color="black";;
  2) column2_bg_color="red";;
  3) column2_bg_color="green";;
  4) column2_bg_color="yellow";;
  5) column2_bg_color="blue";;
  6) column2_bg_color="purple";;
  *) column2_bg_color="default";;
esac

case "$column2_font_color" in
  1) column2_font_color="white";;
  2) column2_font_color="red";;
  3) column2_font_color="green";;
  4) column2_font_color="yellow";;
  5) column2_font_color="blue";;
  6) column2_font_color="purple";;
  *) column2_font_color="default";;
esac
zero='\e[0m'

# Вывод информации о системе (используйте ваши команды из Part 3)
timedatectl set-timezone Europe/Moscow
echo -e ${column1_background}${column1_font_color}HOSTNAME${NC}= ${column2_background}${column2_font_color}"$(hostname)"${zero}
echo -e ${column1_background}${column1_font_color}TIMEZONE${zero} = ${column2_background}${column2_font_color}"$(timedatectl | grep 'Time zone' | awk '{print $3, $4, $5}')"${zero}
echo -e ${column1_background}${column1_font_color}USER${zero} = ${column2_background}${column2_font_color}"$(whoami)"${zero}
echo -e ${column1_background}${column1_font_color}OS${zero} = ${column2_background}${column2_font_color}"$(lsb_release -ds)"${zero}
echo -e ${column1_background}${column1_font_color}DATE${zero} = ${column2_background}${column2_font_color}"$(date '+%d %b %Y %H:%M:%S')"${zero}
echo -e ${column1_background}${column1_font_color}UPTIME${zero} = ${column2_background}${column2_font_color}"$(uptime -p | sed 's/up //')"${zero}
echo -e ${column1_background}${column1_font_color}UPTIME_SEC${zero} = ${column2_background}${column2_font_color}"$(cut -d ' ' -f1 /proc/uptime)"${zero}
echo -e ${column1_background}${column1_font_color}IP${zero} = ${column2_background}${column2_font_color}"$(ip route get 8.8.8.8 | awk '{print $7; exit}')"${zero}
echo -e ${column1_background}${column1_font_color}MASK${zero} = ${column2_background}${column2_font_color}"$(ip -o -f inet addr show | awk '/scope global/ {print $4; exit}')"${zero}
echo -e ${column1_background}${column1_font_color}GATEWAY${zero} = ${column2_background}${column2_font_color}"$(ip route get 8.8.8.8 | awk '{print $3; exit}')"${zero}
echo -e ${column1_background}${column1_font_color}RAM_TOTAL${zero} = ${column2_background}${column2_font_color}"$(free -h | awk '/Mem:/ {print $2}')"${zero}
echo -e ${column1_background}${column1_font_color}RAM_USED${zero} = ${column2_background}${column2_font_color}"$(free -h | awk '/Mem:/ {print $3}')"${zero}
echo -e ${column1_background}${column1_font_color}RAM_FREE${zero} = ${column2_background}${column2_font_color}"$(free -h | awk '/Mem:/ {print $4}')"${zero}
echo -e ${column1_background}${column1_font_color}SPACE_ROOT${zero} = ${column2_background}${column2_font_color}"$(df -h / | awk '/\// {print $2}')"${zero}
echo -e ${column1_background}${column1_font_color}SPACE_ROOT_USED${zero} = ${column2_background}${column2_font_color}"$(df -h / | awk '/\// {print $3}')"${zero}
echo -e ${column1_background}${column1_font_color}SPACE_ROOT_FREE${zero} = ${column2_background}${column2_font_color}"$(df -h / | awk '/\// {print $4}')"${zero}

# Отступ в одну пустую строку перед выводом цветовой схемы
echo

# Вывод цветовой схемы
display_color_scheme
