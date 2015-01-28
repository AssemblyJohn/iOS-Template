#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import "TPhone.h"
#import "TLog.h"

#define TAG @"PHONE"

@interface TPhone()

@property(weak, nonatomic) CTCarrier *carrier;

- (void)listenCalls;

@end

@implementation TPhone

- (id)init {
    if(self = [super init])
    {
        _ctInfo = [[CTTelephonyNetworkInfo alloc] init];
        _ctCenter = [[CTCallCenter alloc] init];
        
        _carrier = [_ctInfo subscriberCellularProvider];
        
        self.carrierName = [_carrier carrierName];
        self.iso = [_carrier isoCountryCode];
        self.mcc = [_carrier mobileCountryCode];
        self.mnc = [_carrier mobileNetworkCode];
        
        [self listenCalls];
        
        return self;
    }
    
    return nil;
}

- (void)launchPhoneCall:(NSString *)phoneNumber
{
    NSLog(@"Calling phone nubmer: %@", phoneNumber);
    
    // this is how a phone call should look
    // @"tel:1-408-555-5555://"
    
    //NSMutableString *str = [NSMutableString stringWithString:@"telprompt://"];
    NSMutableString *str = [NSMutableString stringWithString:@"tel://"];
    [str appendString:phoneNumber];
//    [str appendString:@"://"];
    
    [self openApp:str];
    
}

- (void)launchFaceTimePhoneCall:(NSString *)phoneNumber
{
    // this is how the face-time should look
    // @facetime://phoneNumber;
    
    NSMutableString *str = [NSMutableString stringWithString:@"facetime://"];
    [str appendString:phoneNumber];
    
    [self openApp:str];
}

- (void) openApp:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}


- (void)listenCalls
{
	// TODO: Rig here any callback you need
    UIApplication *app = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        [_ctCenter setCallEventHandler:^(CTCall *call) {
            if([[call callState] isEqual:CTCallStateIncoming]) {
			
            }
            else if([[call callState] isEqual:CTCallStateDialing]) {
			
            }
            else if([[call callState] isEqual:CTCallStateConnected]) {
			
            }
            else if([[call callState] isEqual:CTCallStateDisconnected]) {
			
            }
        }];
    });
    
    [app endBackgroundTask:bgTask];
    bgTask = UIBackgroundTaskInvalid;
}


@end
