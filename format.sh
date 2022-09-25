#!/bin/bash

format_dir=(inc src test)

for dir in ${format_dir[*]};do
    for file in `ls $dir`;do
        format_file=$dir/$file
        if [ -f $format_file ];then
            echo "clang-format $format_file begin"
            clang-format -i $format_file
            echo "clang-format $format_file end"
        fi
    done
done
