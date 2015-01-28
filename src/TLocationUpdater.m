#import "TLocationUpdater.h"

@implementation TLocationUpdater

{
    CLLocationManager *_locationManager;
    id<LocationReceiver> _receiver;
}

- (id)init
{
    if(self = [super init])
    {
        _locationManager = [[CLLocationManager alloc] init];
        
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        _locationManager.distanceFilter = 10.0;
        
        return self;
    }
    
    return self;
}

- (void)setLocationReceived:(id<LocationReceiver>)receiver
{
    _receiver = receiver;
}

- (void)startUpdates
{
    [_locationManager startUpdatingLocation];
}

- (void)stopUpdates
{
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    // Log received location just to be sure.
    NSLog(@"%@", [NSString stringWithFormat:@"Location received. Coordonates: %f %f accuracy: %f speed: %f timestamp %@", location.coordinate.longitude, location.coordinate.latitude, location.horizontalAccuracy, location.speed, location.timestamp]);
    
    // If the location is valid
    if(location.horizontalAccuracy > 0.0)
    {
        [_receiver onLocationReceived:location];
    }
}

@end
