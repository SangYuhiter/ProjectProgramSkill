#ifndef LOGUTILS_H_
#define LOGUTILS_H_

#include <cstdio>
#include <cstring>

#include <sys/syscall.h>
#include <time.h>
#include <unistd.h>

#define gettid() syscall(SYS_gettid)

static const char *getFileName(const char *pSrc)
{
    const char *pFileName = strrchr(pSrc, '/');
    if (pFileName)
        pFileName++;
    else
        pFileName = pSrc;
    return pFileName;
}

#ifndef PPS_LOG
#define PPS_LOG(priority, tag, fmt, ...)                                                     \
    do                                                                                       \
{                                                                                        \
    struct timespec spec;                                                                \
    clock_gettime(CLOCK_REALTIME, &spec);                                                \
    struct tm pCurrentTime = {};                                                         \
    localtime_r((time_t *)&spec.tv_sec, &pCurrentTime);                                  \
    printf("%02d-%02d %02d:%02d:%02d:%09ld  %4d  %4ld [%s]\t%s\t%s:%d %s() " fmt "\n",    \
            (pCurrentTime.tm_mon + 1), pCurrentTime.tm_mday, pCurrentTime.tm_hour,        \
            pCurrentTime.tm_min, pCurrentTime.tm_sec, spec.tv_nsec, getpid(), gettid(),   \
            priority, tag, getFileName(__FILE__), __LINE__, __FUNCTION__, ##__VA_ARGS__); \
} while (0)
#endif

#ifndef PPS_LOG_DEBUG
#define PPS_LOG_DEBUG(format, ...) PPS_LOG("DEBUG", "tag", format, ##__VA_ARGS__)
#endif

#ifndef PPS_LOG_INFO
#define PPS_LOG_INFO(format, ...) PPS_LOG("INFO", "tag", format, ##__VA_ARGS__)
#endif

#ifndef PPS_LOG_WARN
#define PPS_LOG_WARN(format, ...) PPS_LOG("WARN", "tag", format, ##__VA_ARGS__)
#endif

#ifndef PPS_LOG_ERROR
#define PPS_LOG_ERROR(format, ...) PPS_LOG("ERROR", "tag", format, ##__VA_ARGS__)
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
