/*************************************************************************
 @File Name    : test/Test.cpp
 @Author       : SangYu
 @Email        : sangyu.code@gmail.com
 @Created Time : 2022年09月25日 星期日 15时14分02秒
 @Description  :
 ************************************************************************/

#include "LogUtils.h"
#include "TestAdd.h"
#include "TestEnumUtils.h"
#include "TestLogUtils.h"

int main()
{
    PPS_LOG_ENTRY();
    PPS_LOG_INFO("%zu", sizeof(unsigned long int) * 4);

    testLogUtils();

    testEnumUtils();

    testAdd();

    PPS_LOG_EXIT();
    return 0;
}
