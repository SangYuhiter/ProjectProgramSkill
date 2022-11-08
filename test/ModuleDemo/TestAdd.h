#ifndef TESTADD_H
#define TESTADD_H

#include "Add.h"
#include "LogUtils.h"

void testAdd()
{
    PPS_LOG_ENTRY();
    int a = 33, b = 66;
    PPS_LOG_INFO("number:%d add %d equal %d", a, b, Add::add<int>(a, b));
    PPS_LOG_EXIT();
}

#endif
