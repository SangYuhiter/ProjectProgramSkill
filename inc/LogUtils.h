#ifndef LOGUTILS_H_
#define LOGUTILS_H_

#include <cstdio>

#ifndef PPS_LOG
#define PPS_LOG(level, tag, format, ...)                                                         \
    do                                                                                           \
    {                                                                                            \
        printf("%s\t%s\t%s:%d %s()\t" format "\n", level, tag, __FILE__, __LINE__, __FUNCTION__, \
               ##__VA_ARGS__);                                                                   \
    } while (0)
#endif

#ifndef PPS_LOG_DEBUG
#define PPS_LOG_DEBUG(format, ...) PPS_LOG("[DEBUG]", "tag", format, ##__VA_ARGS__)
#endif

#ifndef PPS_LOG_INFO
#define PPS_LOG_INFO(format, ...) PPS_LOG("[INFO]", "tag", format, ##__VA_ARGS__)
#endif

#ifndef PPS_LOG_WARN
#define PPS_LOG_WARN(format, ...) PPS_LOG("[WARN]", "tag", format, ##__VA_ARGS__)
#endif

#ifndef PPS_LOG_ERROR
#define PPS_LOG_ERROR(format, ...) PPS_LOG("[ERROR]", "tag", format, ##__VA_ARGS__)
#endif

#ifndef PPS_LOG_ENTRY
#define PPS_LOG_ENTRY() PPS_LOG_DEBUG("<------entry %s------>", __FUNCTION__)
#endif

#ifndef PPS_LOG_EXIT
#define PPS_LOG_EXIT() PPS_LOG_DEBUG("<------exit %s------>", __FUNCTION__)
#endif

#ifndef PPS_LOG_HERE
#define PPS_LOG_HERE() PPS_LOG("<------here------>")
#endif

#endif
