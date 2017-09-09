#!/bin/bash

set -e

function run_cmd() {
    t=`date`
    echo "$t: $1"
    eval $1
}

function stop_container() {
    container_name=$1
    cmd="docker ps -a -f name='^/$container_name$' | grep '$container_name' | awk '{print \$1}' | xargs -I {} docker rm -f --volumes {}"
    run_cmd "$cmd"
}

prj_path=$(cd $(dirname $0); pwd -P)
SCRIPTFILE=`basename $0`


app_image=liaohuqiu/ossutil
app_container=ossutil

function run() {
    local args=''
    local dir=`pwd`
    args="$args -v $dir:$dir"
    args="$args -w $dir"
    run_cmd "docker run $args --rm -it --name $app_container $app_image bash"
}

function stop() {
    stop_container $app_container
}

function restart() {
    stop
    run
}
 

function help() {
        cat <<-EOF
    
    Usage: manager.sh [options]

            Valid options are:

            run
            stop
            restart
            
            -h                      show this help message and exit

EOF
}

action=${1:-help}
$action "$@"
