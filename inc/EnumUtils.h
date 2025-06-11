#ifndef ENUMUTILS_H_
#define ENUMUTILS_H_

#include <string>
#include "LogUtils.h"

template <typename Enum, Enum enumValue>
inline std::string enumString()
{
    // gcc expand macro like below:
    // [with Enum = NIS::AlgoType; Enum enumValue = NIS::AlgoType::ALGO_MERGE_RAW; std::string =
    // std::__cxx11::basic_string<char>]
    // so extract the enumValue as the string
    std::string func(__PRETTY_FUNCTION__);
    PPS_LOG_INFO("%s", func.c_str());
    std::string markBegin = "enumValue = ";
    std::string markEnd = "]";
    auto posBegin = func.find(markBegin) + markBegin.size();
    auto posEnd = func.substr(posBegin, func.size() - posBegin).find(markEnd);
    std::string enumStr = func.substr(posBegin, posEnd);
    return enumStr;
}

#endif
