#!/bin/bash

# Проверка наличия конфигурационного файла
config_file="config.conf"
if [ ! -f "$config_file" ]; then
  echo "Ошибка: Конфигурационный файл '$config_file' не найден."
  exit 1
fi

# Загрузка параметров из конфигурационного файла
source "$config_file"

# Массивы для определения цветовой схемы по умолчанию
default_backgrounds=("40" "41") # Черный фон, Красный фон
default_fonts=("37" "34") # Белый текст, Синий текст

# Функция для вывода цветовой схемы
function display_color_scheme() {
  echo "Column 1 background = ${column1_background:-default} (${backgrounds[$column1_background]})"
  echo "Column 1 font color = ${column1_font_color:-default} (${fonts[$column1_font_color]})"
  echo "Column 2 background = ${column2_background:-default} (${backgrounds[$column2_background]})"
  echo "Column 2 font color = ${column2_font_color:-default} (${fonts[$column2_font_color]})"
}

# Массивы для определения цветов для каждого столбца
backgrounds=("default" "black" "red" "green" "yellow" "blue" "purple")
fonts=("default" "white" "red" "green" "yellow" "blue" "purple")

# Вывод информации о системе (используйте ваши команды из Part 3)
# ...

# Отступ в одну пустую строку перед выводом цветовой схемы
echo

# Вывод цветовой схемы
display_color_scheme
