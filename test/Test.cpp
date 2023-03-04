/*************************************************************************
 @File Name    : test/Test.cpp
 @Author       : SangYu
 @Email        : sangyu.code@gmail.com
 @Created Time : 2022年09月25日 星期日 15时14分02秒
 @Description  :
 ************************************************************************/

#include "CommonIncs.h"
#include "LogUtils.h"
#include "TestAdd.h"
#include "TestEnumUtils.h"
#include "TestLogUtils.h"

enum class TestType
{
    TEST_TYPE_INVALID = -1,
    TEST_LOG_UTILS,
    TEST_ENUM_UTILS,
    TEST_ADD,
    TEST_TYPE_NUM,
};

std::vector<std::string> testTypeStrings = {
    "TEST_LOG_UTILS",
    "TEST_ENUM_UTILS",
    "TEST_ADD",
    "TEST_TYPE_NUM",
};

int main()
{
    PPS_LOG_ENTRY();

    PPS_LOG_INFO("Please select a option as below:");
    for (int i = static_cast<int>(TestType::TEST_LOG_UTILS);
         i < static_cast<int>(TestType::TEST_TYPE_NUM); ++i)
    {
        PPS_LOG_INFO("%d------%s", i, testTypeStrings[i].c_str());
    }
    int selectType;
    PPS_LOG_INFO("input option:");
    scanf("%d", &selectType);
    if (selectType <= static_cast<int>(TestType::TEST_TYPE_INVALID) ||
        selectType >= static_cast<int>(TestType::TEST_TYPE_NUM))
    {
        PPS_LOG_ERROR("ERROR input option:%d,will route to TEST_LOG", selectType);
        selectType = static_cast<int>(TestType::TEST_LOG_UTILS);
    }

    switch (static_cast<TestType>(selectType))
    {
        case TestType::TEST_LOG_UTILS:
            testLogUtils();
            break;
        case TestType::TEST_ENUM_UTILS:
            testEnumUtils();
            break;
        case TestType::TEST_ADD:
            testAdd();
            break;
        default:
            break;
    }

    PPS_LOG_EXIT();
    return 0;
}
