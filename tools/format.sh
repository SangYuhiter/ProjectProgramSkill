#!/bin/sh
# File Name    : format.sh
# Author       : SangYu
# Email        : sangyu.code@gmail.com
# Created Time : 2022年11月05日 星期六 13时05分28秒
# Description  : use clang format the code

# the root path
GIT_ROOT="$(git rev-parse --show-toplevel)"
rootPath=$GIT_ROOT

funcFormatFile()
{
    if [ $(ls $1 | grep -cEi "\.cpp$|\.h$") -eq 1 ]
    then
        echo format $1 begin
        clang-format -i $1
        echo format $1 end
    fi
}

funcFormatDir()
{
    if [ -f $1 ]
    then
        funcFormatFile $1
    elif [ -d $1 ]
    then
        for file in `ls $1`
        do
            formatFile=$1/$file
            if [ -f $formatFile ]
            then
                funcFormatFile $formatFile
            elif [ -d $formatFile ]
            then
                funcFormatDir $formatFile
            else
                echo "unsupported parameter!!! not file nor dir"
            fi
        done
    else
        echo "unsupported parameter!!! not file nor dir"

    fi
}

if [ -z "$1" ]
then
    funcFormatDir $rootPath
else
    funcFormatDir $1
fi

exit 0
