#import "TAppDelegate.h"
#import "TLog.h"

#import <sys/sysctl.h>

#define TAG @"APPDELEGATE"

@implementation TAppDelegate

// Synthesise these so we can use the '_' notation before them
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{	
    // Enable battery monitoring
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
	
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{    

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

// If the app was built with Core Data option this is not required
#pragma mark Core Data here

- (NSManagedObjectContext *)managedObjectContext
{
    if(_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordonator = [self persistentStoreCoordinator];
    if(coordonator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordonator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *) managedObjectModel
{
    if(_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
	#warning Add the app name at the URL resource instead of 'iOSTemplate'	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iOSTemplate" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iOSTemplate.sqlite"];
    
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        logError(TAG, [NSString stringWithFormat:@"Unresolved error %@, %@", error, [error userInfo]]);
        
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
