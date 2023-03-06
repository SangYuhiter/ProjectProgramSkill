#!/bin/sh
# File Name    : format.sh
# Author       : SangYu
# Email        : sangyu.code@gmail.com
# Created Time : 2022年11月05日 星期六 13时05分28秒
# Description  : use clang format the code

# the root path
GIT_ROOT="$(git rev-parse --show-toplevel)"
CHECK_DIR=($GIT_ROOT/inc $GIT_ROOT/src $GIT_ROOT/test)

# the ignore root path
IGNORE_ROOT="$GIT_ROOT/src/"
IGNORE_RE_STR="*_ignore"

funcCheckWhetherNeedFormat()
{
    for ignoreDir in `ls $IGNORE_ROOT`
    do
        absolutePath=$IGNORE_ROOT/$ignoreDir
        # find ignore dir
        for ignoreDir in `ls $absolutePath | grep -Ei "$IGNORE_RE_STR"`
        do
            IgnoreDir=$absolutePath/$ignoreDir
            if [ $(echo $1 | grep -c "$IgnoreDir") -eq 1 ]
            then
                echo no need format $1
                return 0
            fi
        done
    done
    return 1
}

funcFormatFile()
{
    if [ $(ls $1 | grep -cEi "\.cpp$|\.h$") -eq 1 ]
    then
        funcCheckWhetherNeedFormat $1
        if [ $? -eq 1 ]
        then
            echo format $1 begin
            clang-format -i $1
            echo format $1 end
        fi
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
    for path in ${CHECK_DIR[*]}
    do
        funcFormatDir $path
    done
else
    funcFormatDir $1
fi

exit 0
