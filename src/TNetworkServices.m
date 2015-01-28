#import "TNetworkServices.h"
#import "TLog.h"

#import "Reachability.h"

typedef enum
{
    HOST,
    INTERNET,
    WIFI
} NetType;

@interface TNetworkServices()

- (void) updateLogWithReachability:(Reachability*) reachability;
- (void)logReachability:(Reachability*) curReach label:(NSString*) targetReachabilityName type:(NetType)type;

@end

@implementation TNetworkServices

- (void)updateReachabilityWithHostIp:(NSString *)hostIp
{
    _remoteHost = [NSString stringWithFormat: @"Remote Host: %@", hostIp];
    
    _hostReachable = [Reachability reachabilityWithHostName: hostIp];
    [_hostReachable startNotifier];
    
    _internetReachable = [Reachability reachabilityForInternetConnection];
    [_internetReachable startNotifier];
    
    _wifiReachable = [Reachability reachabilityForLocalWiFi];
    [_wifiReachable startNotifier];
    
    // Update reachabilities
    [self updateLogWithReachability: _hostReachable];
    [self updateLogWithReachability: _internetReachable];
    [self updateLogWithReachability: _wifiReachable];
}

- (void)updateLogWithReachability:(Reachability*) reachability
{
    if(reachability == _hostReachable)
    {
        [self logReachability: reachability label:[NSString stringWithFormat:@"host reachability(%@)",_remoteHost] type:HOST];
    }
    if(reachability == _internetReachable)
    {
        [self logReachability: reachability label:@"internet reachability" type:INTERNET];
    }
    if(reachability == _wifiReachable)
    {
        [self logReachability: reachability label:@"wifi reachability" type:WIFI];
    }
}

- (void)logReachability:(Reachability*) reach label:(NSString*) targetReachabilityName type:(NetType)type
{
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    BOOL connectionRequired= [reach connectionRequired];
    
    NSString* statusString= @"";
    
    switch (netStatus)
    {
        case NotReachable:
        {
            [self setRechabilityFor:type reachable:NO];
            
            statusString = @"Access Not Available";
            // Minor interface detail - connectionRequired may return yes, even when the host is unreachable.  We cover that up here...
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:
        {
            [self setRechabilityFor:type reachable:YES];
            
            statusString = @"Reachable WWAN";
            break;
        }
        case ReachableViaWiFi:
        {
            [self setRechabilityFor:type reachable:YES];
            
            statusString= @"Reachable WiFi";
            break;
        }
    }
    
    if(DEBUG_MODE)
    {
        if(connectionRequired)
        {
            statusString = [NSString stringWithFormat: @"%@, Connection Required", statusString];
        }
        
        statusString = [NSString stringWithFormat: @"- %@: %@", targetReachabilityName, statusString];
        
        NSLog(@"%@", statusString);
    }
}

- (void)setRechabilityFor:(NetType)type reachable:(BOOL)reachable
{
    switch (type) {
        case HOST:
            _isHostReachable = reachable;
            break;
        case INTERNET:
            _isInternetReachable = reachable;
            break;
        case WIFI:
            _isWifiReachable = reachable;
            break;
    }
}

@end
