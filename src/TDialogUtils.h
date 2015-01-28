#import <Foundation/Foundation.h>

/**
 * Dialog utilitary
 */
@interface TDialogUtils : NSObject

/**
 * Presents a dialog with the "Warning" title, the provided message and a delegate if it's needed.
 */
+ (void)presentWarningWithMessage:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate;
/**
 * Presents the user a notification.
 */
+ (void)scheduleNotification:(NSString *)text;

@end
