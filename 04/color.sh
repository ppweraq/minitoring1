#!/bin/bash

front () {
case "$1" in
        1) echo "\033[37m";; #white
        2) echo "\033[31m";; #red
        3) echo "\033[32m";; #green
        4) echo "\033[34m";; #blue
        5) echo "\033[35m";; #purple
        6) echo "\033[30m";; #black
esac
}

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

back1=$(back $1)
front2=$(front $2)
back3=$(back $3)
front4=$(front $4)
zero='\e[0m