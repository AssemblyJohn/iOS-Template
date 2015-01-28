#import <Foundation/Foundation.h>

@class Reachability;

/**
 * Determines wether a host is reachable. Wrapper for the provided reachability class.
 */
@interface TNetworkServices : NSObject
{
    Reachability *_hostReachable;
    Reachability *_internetReachable;
    Reachability *_wifiReachable;
    NSString *_remoteHost;
}

@property (nonatomic, readonly, getter = isHostReachable) BOOL isHostReachable;
@property (nonatomic, readonly, getter = isInternetReachable) BOOL isInternetReachable;
@property (nonatomic, readonly, getter = isWifiReachable) BOOL isWifiReachable;

/**
 * Updates the reachability with the IP of the host. Must be called before we interogate the properties.
 */
- (void)updateReachabilityWithHostIp:(NSString *)hostIp;

@end
