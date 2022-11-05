#!/bin/sh
# File Name    : format.sh
# Author       : SangYu
# Email        : sangyu.code@gmail.com
# Created Time : 2022年11月05日 星期六 13时05分28秒
# Description  : pre-commit git hooks

# pre commit we need check the code format that follow the
# .clang-format
# the pre-commit demo refs from
# https://codeinthehole.com/tips/tips-for-using-a-git-pre-commit-hook/

# the root path
GIT_ROOT="$(git rev-parse --show-toplevel)"

# save the unstaged files
STASH_NAME="pre-commit-$(date +%s)"
git stash save --quiet --keep-index --include-untracked $STASH_NAME

cached_files=$(git diff --cached --name-only)

# format the file by the shell.
for file in $cached_files
do
    $GIT_ROOT/tools/format.sh $GIT_ROOT/$file
done

diff_file_count=$(git diff --name-only | wc -l)
diff_files=$(git diff --name-only)

if [ $diff_file_count -gt 0 ]
then
    echo "Error:You still have" $diff_file_count "changed file in auto-format process as below:\n"
    echo $diff_files "\n"

    cat <<\EOF
Please git status check whether need to git add them.

If you know what you are doing you can disable this format process in your code as below:

    int formatted_code;
    // clang-format off
    void    unformatted_code  ;
    // clang-format on
    void formatted_code_again;

(refs:https://releases.llvm.org/10.0.0/tools/clang/docs/ClangFormatStyleOptions.html#disabling-formatting-on-a-piece-of-code)
EOF
    # before exit we need pop the stash files
    git stash pop --quiet
    exit 1
fi

# wait for add auto test here

# before exit we need pop the stash files
git stash pop --quiet

exit 0
