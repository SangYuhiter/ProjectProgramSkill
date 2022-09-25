#ifndef TESTLOGUTILS_H_
#define TESTLOGUTILS_H_

#include "LogUtils.h"
void testLogUtils();

void testLogUtils()
{
    PPS_LOG_ENTRY();
    PPS_LOG_DEBUG("test here");
    PPS_LOG_INFO("test here");
    PPS_LOG_WARN("test here");
    PPS_LOG_ERROR("test here");
    PPS_LOG_EXIT();
}

#endif
