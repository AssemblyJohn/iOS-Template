#import <Foundation/Foundation.h>

/**
 * Thread manager utility
 */
@interface TThreadManager : NSObject

+ (id)sharedInstance;

- (void)submitBlock:(void (^)(void))block;
- (void)submitBlockDelayed:(void (^)(void))block delay:(NSTimeInterval)delay;
- (void)submitForUIThread:(void (^)(void))block;

@end
