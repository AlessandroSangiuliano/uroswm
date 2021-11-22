//
// UrosWMServer
// uroswm
//
// Created by slex on 22/11/21.

#import "UrosWMServer.h"
#import <XCBKit/XCBConnection.h>

@implementation UrosWMServer

@synthesize serverName;
@synthesize connection;
@synthesize conn;

- (instancetype)initWithName:(NSString *)aName andConnection:(XCBConnection *)aConnection;
{
    self = [super init];
    
    if (self == nil)
    {
        NSLog(@"Unable to init...");
        return nil;
    }
    
    serverName = aName;
    connection = aConnection;
    
    return self;
}

- (NSMutableDictionary *)requestWindowsMap
{
    NSLog(@"Request for window map...");
    [connection windowsMap];
}

- (void)becomeServer
{
    conn = [NSConnection new];
    
    if (![conn registerName:serverName])
    {
        NSLog(@"Could not register as server...");
        return;
    }
    
    [conn setRootObject:self];
    
    NSLog(@"UrosWm registered as server...");
    
    [[NSRunLoop currentRunLoop] run];
}

- (void) dealloc
{
    serverName = nil;
    connection = nil;
    conn = nil;
}

@end