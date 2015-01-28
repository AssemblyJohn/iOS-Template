#import <Foundation/Foundation.h>

@interface TDevice : NSObject

+ (void)vibrate;

/**
 * Schedules a notification
 */
+ (void)scheduleNotification:(NSDate *)date body:(NSString *)body soundName:(NSString *)sound;

/**
 * Returns the battery level in a range of 0-1. If it is charging 1.1 is returned.
 */
+ (float)batteryLevel;

@end
