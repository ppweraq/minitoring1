#!/bin/bash

back() {
case "$1" in
        1) echo "\033[47m";; #white
        2) echo "\033[41m";; #red
        3) echo "\033[42m";; #green
        4) echo "\033[44m";; #blue
        5) echo "\033[45m";; ##purple
        6) echo "\033[40m";; #black
esac
}

font () {
case "$1" in
        1) echo "\033[37m";; #white
        2) echo "\033[31m";; #red
        3) echo "\033[32m";; #green
        4) echo "\033[34m";; #blue
        5) echo "\033[35m";; #purple
        6) echo "\033[30m";; #black
esac
}

back1=$(back $1)
font2=$(font $2)
back3=$(back $3)
font4=$(font $4)
zero='\e[0m'