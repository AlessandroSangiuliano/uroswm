//
// UrosWMClient
// .
//
// Created by slex on 24/11/21.

#import "UrosWMClient.h"

@implementation UrosWMClient

@synthesize notificationCenter;

- (instancetype)init
{
    self = [super init];
    
    if (self == nil)
    {
        NSLog(@"Unable to init...");
        return nil;
    }
    
    notificationCenter = [NSDistributedNotificationCenter defaultCenter];
    
    return self;
}

- (void)sendNotification:(NSNotification *)aNotification
{
    NSLog(@"Posting notification...");
    [notificationCenter postNotification:aNotification];
}

-(void)dealloc
{
    notificationCenter = nil;
}


@end