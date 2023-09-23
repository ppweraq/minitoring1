#!/bin/bash

# Проверка наличия конфигурационного файла

# if [ ! -f "$config_file" ]; then
#   echo "Ошибка: Конфигурационный файл ($config.conf) не найден."
#   exit 1
# fi

source ./config.conf
param1=$column1_background
param2=$column1_font_color
param3=$column2_background
param4=$column2_font_color
    if [[ $param1 == "" ]];
    then
    param1=6 ; column1_background="default"
    fi
    if [[ $param2 == "" ]];
    then
        param2=1 ; column1_font_color="default"
    fi
    if [[ $param3 == "" ]];
    then
        param3=2 ; column2_background="default"
    fi
    if [[ $param4 == "" ]];
    then
        param4=4 ; column2_font_color="default"
    fi

re='^(|[1-6 ]+)$'

# if [[param1 == ""] || [param2 == ""] || [param3 == ""] || [param4 == ""]]; then 
#         get_color_default #$param1 $param2 $param3 $param4
# fi

if [[ $# -ne 0 ]]; then
        echo "Ошибка: скрипт запускается без параметра"
        exit        
elif ! [[ $param1 =~ $re ]] || ! [[ $param2 =~ $re ]] || ! [[ $param3 =~ $re ]] || ! [[ $param4 =~ $re ]];
    then
        echo "Ошибка в конфигурационном файле: Числовые параметры от 1 до 6"
        exit
elif [[ $param1 -eq $param2 ]] || [[ $param3 -eq $param4 ]]; then
        echo "Ошибка в конфигурационном файле: Цвет шрифта и фона одного столбца не должны совпадать"
        exit

fi

source ./print



# get_color_default () {
#         default1_background=6
#         default1_font_color=1
#         default2_background=2
#         default2_font_color=4

#         param1=$default1_background
#         param2=$default1_font_color
#         param3=$default2_background
#         param4=$default2_font_color
# }
