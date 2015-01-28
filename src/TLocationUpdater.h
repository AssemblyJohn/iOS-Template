#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 * Utilitary for location data.
 */

@protocol LocationReceiver <NSObject>

- (void)onLocationReceived:(CLLocation *)location;

@end

@interface TLocationUpdater : NSObject<CLLocationManagerDelegate>

- (void)setLocationReceived:(id<LocationReceiver>)receiver;

- (void)startUpdates;
- (void)stopUpdates;

@end
