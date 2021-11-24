//
// UrosWMServer
// uroswm
//
// Created by slex on 22/11/21.
//

#import <Foundation/Foundation.h>
#import <XCBKit/protocols/server/Server.h>
#import <XCBKit/enums/ERequests.h>
#import <objc/runtime.h>

@class XCBConnection;


@interface UrosWMServer : NSObject <Server>
{
}

@property (strong, nonatomic) NSString *serverName;
@property (strong, nonatomic) XCBConnection *connection;
@property (strong, nonatomic) NSConnection *conn;

- (instancetype) initWithName:(NSString *)aName andConnection:(XCBConnection *)aConnection;
- (id) handleRequestFor:(Request)aRequest;
- (void) becomeServer;

@end