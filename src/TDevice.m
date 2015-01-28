#import <AudioToolbox/AudioServices.h>

#import "TDevice.h"
#import "TLog.h"

#define TAG @"DEVICE"

@implementation TDevice

+ (void)vibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (void)scheduleNotification:(NSDate *)date body:(NSString *)body soundName:(NSString *)sound;
{
    UILocalNotification *beginNotification = [[UILocalNotification alloc] init];
    
    beginNotification.fireDate = date;
    beginNotification.timeZone = [NSTimeZone defaultTimeZone];
    beginNotification.repeatInterval = 0;
    beginNotification.alertBody = body;
    beginNotification.soundName = sound;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:beginNotification];
}

+ (float)batteryLevel
{
    float level = 0.0f;
    
    UIDeviceBatteryState state = [[UIDevice currentDevice] batteryState];
    if(state == UIDeviceBatteryStateCharging || state == UIDeviceBatteryStateFull)
    {
        level = 1.1f;
    }
    else
    {
        level = [[UIDevice currentDevice] batteryLevel];
    }
    
    logInfo(TAG, [NSString stringWithFormat:@"Battery level: %f", level]);
    
    return level;
}

@end
