//
// UrosWMServer
// uroswm
//
// Created by slex on 22/11/21.

#import "UrosWMServer.h"
#import <XCBKit/XCBConnection.h>
#import <objc/runtime.h>

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

- (id)handleRequestFor:(Request)aRquest
{
    id object;
    
    switch (aRquest)
    {
        case WindowsMapRequest:
        {
            NSLog(@"Request for window map...");
            object = [connection windowsMap];
            break;
        }
        default:
        {
            NSLog(@"Incorect Request...");
            break;
        }
    }
    
    return object;
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