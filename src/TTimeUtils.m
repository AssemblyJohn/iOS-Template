#import "TTimeUtils.h"

#include <sys/time.h>

@implementation TTimeUtils

+ (u_int64_t)getTimeMilli
{
    return (u_int64_t)([[NSDate date] timeIntervalSince1970] * 1000.0);
}

+ (u_int64_t)getTimezoneOffset
{
    return (u_int64_t)([[NSTimeZone localTimeZone] secondsFromGMT] * 1000);
}

+ (u_int64_t)getPreciseMilli
{
    struct timeval time;
    gettimeofday(&time, NULL);
        
    return (time.tv_sec * 1000) + (time.tv_usec / 1000);
}

@end
