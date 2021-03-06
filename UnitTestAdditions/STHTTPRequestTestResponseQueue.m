#import "STHTTPRequestTestResponseQueue.h"
#import "STHTTPRequestTestResponse.h"

static STHTTPRequestTestResponseQueue *sharedInstance = nil;

@implementation STHTTPRequestTestResponseQueue

+ (instancetype)sharedInstance {
    static STHTTPRequestTestResponseQueue *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    self.responses = [NSMutableArray array];
    return self;
}

/**/

- (void)enqueue:(STHTTPRequestTestResponse *)response {
    NSAssert(response != nil, @"can't enqueue nil");

    [_responses insertObject:response atIndex:0];
}

- (STHTTPRequestTestResponse *)dequeue {
    
    if([_responses count] == 0) {
        NSLog(@"Cannot dequeue response");
        return nil;
    }
    
    NSUInteger lastIndex = [_responses count] - 1;
    
    STHTTPRequestTestResponse *response = _responses[lastIndex];
    
    [_responses removeObjectAtIndex:lastIndex];
    
    return response;
}

@end
