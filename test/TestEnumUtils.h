#ifndef TESTENUMUTILS_H_
#define TESTENUMUTILS_H_

#include "CommonDefines.h"
#include "EnumUtils.h"
#include "LogUtils.h"

void testEnumUtils();

void testEnumUtils(){
    PPS_LOG_ENTRY();

    PPS_LOG_INFO("%s",enumString<ShapeType,ShapeType::RECTANGLE>().c_str());
    PPS_LOG_INFO("%s",enumString<ShapeType,static_cast<ShapeType>(2)>().c_str());

    PPS_LOG_EXIT();
}
#endif
