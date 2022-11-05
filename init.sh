#!/bin/bash
# File Name    : init.sh
# Author       : SangYu
# Email        : sangyu.code@gmail.com
# Created Time : 2022年11月05日 星期六 13时05分28秒
# Description  : init the environment

# the root path
GIT_ROOT="$(git rev-parse --show-toplevel)"

# add hooks script execute authority
echo "add execute authority for githooks..."
chmod +x $GIT_ROOT/githooks/pre-commit.sh

# add tools script execute authority
echo "add execute authority for tools..."
chmod +x $GIT_ROOT/tools/format.sh

# soft link the hook script
echo "init git hook script..."
ln -s ../../githooks/pre-commit.sh .git/hooks/pre-commit

echo "init environment successful!!!"

exit 0
