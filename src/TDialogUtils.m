#import "TDialogUtils.h"

@implementation TDialogUtils

+ (void)presentWarningWithMessage:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate
{
	// The strings need to be generated here
    NSString *warning = NSLocalizedString(@"Warning", @"Warning title");
    NSString *ok      = NSLocalizedString(@"Cancel", @"Cancel title");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:warning message:message delegate:delegate cancelButtonTitle:ok otherButtonTitles:nil];
    
    [alert show];
}

+ (void) scheduleNotification:(NSString *)text
{
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *oldNotifs = [app scheduledLocalNotifications];
    
    if([oldNotifs count] > 0)
        [app cancelAllLocalNotifications];
    
    UILocalNotification *alarm = [[UILocalNotification alloc] init];
    
    if(alarm)
    {
        NSDate *dateFire = [NSDate date];
        
        alarm.fireDate = dateFire;
        
        alarm.timeZone = [NSTimeZone localTimeZone];
        alarm.repeatInterval = 0;
        alarm.soundName = nil;
        alarm.alertBody = text;
        
        [app scheduleLocalNotification:alarm];
    }
}

@end
