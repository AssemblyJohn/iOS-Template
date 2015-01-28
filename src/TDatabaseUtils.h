#import <Foundation/Foundation.h>

@interface TDatabaseUtils : NSObject

/**
 * Saved any changes made in the database.
 */
+ (void)commitChanges;

/**
 * Deletes an object from the db. Must call commit after changes.
 */
+ (void)deleteObject:(NSManagedObject *)obj;

/**
 * Inserts a entity description for a specific name. Must call commit after changes.
 */
+ (id)insertEntityWithDescription:(NSString *)name;

/**
 * Retrieves all entities with a specific name.
 */
+ (NSArray *)getEntitiesWithName:(NSString *)name withSortOrder:(BOOL)withSort sortKey:(NSString*)key ascending:(BOOL)asc withPredicate:(BOOL)withPredicate predicate:(NSPredicate *)predicate;

@end
