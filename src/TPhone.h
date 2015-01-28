#import <Foundation/Foundation.h>

@class CTTelephonyNetworkInfo;
@class CTCallCenter;

/**
 * Phone call and call listener utilitary
 */
@interface TPhone : NSObject

@property(strong, nonatomic) CTTelephonyNetworkInfo *ctInfo;
@property(strong, nonatomic) CTCallCenter *ctCenter;

@property(strong, nonatomic) NSString *mcc;
@property(strong, nonatomic) NSString *mnc;
@property(strong, nonatomic) NSString *iso;
@property(strong, nonatomic) NSString *carrierName;

- (void)launchPhoneCall:(NSString *)phoneNumber;
- (void)launchFaceTimePhoneCall:(NSString *)phoneNumber;

@end
