#import "TLog.h"

void logInfo(NSString *tag, NSString *msg)
{
    if(LEVEL_INFO)
    {
        NSLog(@"(info) %@: %@", tag, msg);
    }
}

void logDebug(NSString *tag, NSString *msg)
{
    if(LEVEL_DEBUG)
    {
        NSLog(@"(debug) %@: %@", tag, msg);
    }
}

void logWarning(NSString *tag, NSString *msg)
{
    if(LEVEL_WARNING)
    {
        NSLog(@"(warning) %@: %@", tag, msg);
    }
}

void logError(NSString *tag, NSString *msg)
{
    if(LEVEL_ERROR)
    {
        NSLog(@"(error) %@: %@", tag, msg);
    }
}

