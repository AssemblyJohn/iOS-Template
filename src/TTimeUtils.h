#import <Foundation/Foundation.h>
#import <stdint.h>

@interface TTimeUtils : NSObject

/**
 * Used for time
 */
+ (u_int64_t)getTimeMilli;

/**
 * Used for timers
 */
+ (u_int64_t)getPreciseMilli;

/**
 * Timezone offset
 */
+ (u_int64_t)getTimezoneOffset;

@end
