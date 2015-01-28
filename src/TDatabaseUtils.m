#import "TDatabaseUtils.h"
#import "TLog.h"

#define TAG @"DATABASE_UTILS"

@interface TDatabaseUtils()

/**
 * Retrieves the main delegate of the applications.
 */
+ (TAppDelegate *)getMainDelegate;

@end

@implementation TDatabaseUtils

+ (TAppDelegate *)getMainDelegate
{
    return (TAppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (NSArray *)getEntitiesWithName:(NSString *)name withSortOrder:(BOOL)withSort sortKey:(NSString *)key ascending:(BOOL)asc withPredicate:(BOOL)withPredicate predicate:(NSPredicate *)predicate
{    
    NSManagedObjectContext *context = [[self getMainDelegate] managedObjectContext];
    
    // Create fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // For entiry
    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:context];
    // Set entity
    [fetchRequest setEntity:entity];
    
    if(withSort)
    {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:asc];
        
        // Build the descriptors and set
        NSArray *sortDescriptors = @[sortDescriptor];
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    
    if(withPredicate)
    {
        [fetchRequest setPredicate:predicate];
    }
    
    NSError *error;
    
    // Only if we don't need owned  entities
    // fetchRequest.includesSubentities = NO;
    
    // Execute fetch request
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil)
    {
        // Handle the error.
        logError(TAG, @"Error in fetching objects from the db!");
        #warning Remove abort for a real build
        abort();
    }
    
    return fetchedObjects;
}

+ (id)insertEntityWithDescription:(NSString *)name
{
    NSManagedObjectContext *context = [[self getMainDelegate] managedObjectContext];
    
	// Insert it. Note that if will not be persisted before calling 'commit'
    id entity = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:context];
    
    return entity;
}

+ (void)deleteObject:(NSManagedObject *)obj
{
    NSManagedObjectContext *managedObjectContext = [self.getMainDelegate managedObjectContext];
    
    [managedObjectContext deleteObject:obj];
}

+ (void)commitChanges
{
    NSError *error = nil;
    
    NSManagedObjectContext *managedObjectContext = [self.getMainDelegate managedObjectContext];
    
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
    {
        #warning Remove this from here after we get the data working
        logError(TAG, [NSString stringWithFormat:@"Unresolved error %@, %@", error,[error userInfo]]);
        abort();
    }
    else
    {
        logDebug(TAG, @"Saved with success!");
    }
}

@end
