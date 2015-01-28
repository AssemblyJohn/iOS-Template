#import <Foundation/Foundation.h>

/**
 * Class utilitary that posts a JSON request to the server.
 */
@interface TNetworking : NSObject

+ (id)sharedInstance;

/**
 * Posts a JSON to a web service.
 *
 * @return  Returns the response from the server or nil in case an network error took place. The
 *          response is sent to the response receiver block.
 */
- (void) example:(NSString *)json responseReceiver:(void(^)(NSString *, NSData *))response;

@end
