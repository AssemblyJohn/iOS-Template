#import <Foundation/Foundation.h>

#define DEBUG_MODE 1

static const bool LEVEL_INFO    = 1;
static const bool LEVEL_DEBUG   = 1;
static const bool LEVEL_WARNING = 1;
static const bool LEVEL_ERROR   = 1;

/**
 * Class for logging only if the levels are enabled
 */

// Used with FOUNDATION_EXTERN so it's compatible with C++ files too
FOUNDATION_EXTERN void logInfo(NSString *tag, NSString *msg);
FOUNDATION_EXTERN void logDebug(NSString *tag, NSString *msg);
FOUNDATION_EXTERN void logWarning(NSString *tag, NSString *msg);
FOUNDATION_EXTERN void logError(NSString *tag, NSString *msg);

