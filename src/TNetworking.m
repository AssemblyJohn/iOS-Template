#import "TNetworking.h"

#define DEBUG 1
#define MAX_THREADS 2

@interface TNetworking()

@property(strong, nonatomic) NSOperationQueue *netQueue;

@end

@implementation TNetworking

static NSString *BASE_URL = @"http://127.0.0.1/";
static NSString *TO = @"uploader.php?";

static TNetworking *singleton;
// Called once per object
+ (void)initialize
{
    static BOOL inited = NO;
    
    if(!inited)
    {
        inited = YES;
        singleton = [[TNetworking alloc] init];
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
        _netQueue = [[NSOperationQueue alloc] init];
        [_netQueue setMaxConcurrentOperationCount:MAX_THREADS];
        
        return self;
    }
    
    return nil;
}

- (void) example:(NSString *)json responseReceiver:(void (^)(NSString *, NSData *))response
{
    [self postInner:json responseReceiver:response urlpart:TO];
}

- (void) postInner:(NSString *)json responseReceiver:(void (^)(NSString *, NSData*))responseBlock urlpart:(NSString *)urlpart
{
    // Escape invalid characters
    // NSString *jsonEscaped = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)json, CFSTR(""), CFSTR("?&=%,:+-"), kCFStringEncodingUTF8));
    
    // Build string url and string
    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, urlpart];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if(DEBUG) NSLog(@"URL string: %@ url:%@", urlString, url);
    
    if(url != nil)
    {
        // Prepare request for server
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        
        NSString *data = [NSString stringWithFormat:@"data=%@", json];
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:[NSData dataWithBytes:[data UTF8String] length:[data length]]];
        
        if(DEBUG) NSLog(@"Request: %@", req);
        
        // Make the url async request.
        [NSURLConnection sendAsynchronousRequest:req queue:[self netQueue] completionHandler:^(NSURLResponse *response, NSData* data, NSError *connectionError) {
            // Response from the server
            
            NSString *serverJson = nil;
            
            if(data != nil)
            {
                serverJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
            
            // Return to the response the server json
            responseBlock(serverJson, data);
        }];
    }
    else
    {
        // If the url was invalid then return to the response block a nil value.
        responseBlock(nil, nil);
    }
}

@end
