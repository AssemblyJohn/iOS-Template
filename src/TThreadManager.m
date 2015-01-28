#import "TThreadManager.h"

const int MAX_CONCURENT = 2;

@implementation TThreadManager
{
    NSOperationQueue *queue;
}

static TThreadManager *singleton;
+ (void)initialize
{
    static BOOL inited = NO;
    
    if(!inited)
    {
        singleton = [[TThreadManager alloc] init];
    }
}
+ (id)sharedInstance
{
    return singleton;
}

- (id)init
{
    if(self = [super init])
    {
        queue = [[NSOperationQueue alloc] init];
        [queue setMaxConcurrentOperationCount:MAX_CONCURENT];
        
        return self;
    }
    
    return nil;
}

- (void)submitBlock:(void (^)(void))block
{
    [queue addOperationWithBlock:block];
}

- (void)submitBlockDelayed:(void (^)(void))block delay:(NSTimeInterval)delay
{
    [self performSelector:@selector(submitBlock:) withObject:block afterDelay:delay];
}

- (void)submitForUIThread:(void (^)(void))block
{
    dispatch_async(dispatch_get_main_queue(), block);
}

@end
