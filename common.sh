#!/usr/bin/env bash

## blue to echo
function blue(){
    echo -e "\033[35m[ $1 ]\033[0m"
}
## green to echo
function green(){
    echo -e "\033[32m[ $1 ]\033[0m"
}
## Error to warning with blink
function bred(){
    echo -e "\033[31m\033[01m\033[05m[ $1 ]\033[0m"
}
## Error to warning with blink
function byellow(){
    echo -e "\033[33m\033[01m\033[05m[ $1 ]\033[0m"
}
## Error
function red(){
    echo -e "\033[31m\033[01m[ $1 ]\033[0m"
}
## warning
function yellow(){
    echo -e "\033[33m\033[01m[ $1 ]\033[0m"
}


{"apiUrl":"https://47.75.120.109:50836/0ybLAw1B_N1Qs8k6s7R23w","certSha256":"ECFA2F32EFCADD930EB441A1FD0E2300E72B918B0CE17C9BC07D6FB358058AC5"}