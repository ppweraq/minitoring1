#!/bin/bash

source ./print.sh

if [ "$#" -gt 0 ]; then
  echo "Скрипт запускается без аргументов"
  exit 1
else
    print_about_os
  read -p "Записать данные в файл? (Y/N): " answer
    if [[ "$answer" == ["y || Y"] ]];
    then
        file="$(date "+%d_%m_%y_%H_%M_%S.status")"
        print_about_os > "$file"
        echo "Создан файл с данными"
    else
        echo "Данные не записаны в файл"
    fi
fi