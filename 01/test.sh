#!/bin/bash

parametr='^[1-3]$'
if [[ $1 =~ $parametr ]]; then
    echo hello $1
elif [[ $1 != $parametr && $2 != $parametr ]]; then
    echo error
fi