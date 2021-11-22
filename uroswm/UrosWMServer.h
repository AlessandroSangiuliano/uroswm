//
// UrosWMServer
// uroswm
//
// Created by slex on 22/11/21.
//

#import <Foundation/Foundation.h>
#import <XCBKit/protocols/server/Server.h>

@class XCBConnection;

@interface UrosWMServer : NSObject <Server>
{
}

@property (strong, nonatomic) NSString *serverName;
@property (strong, nonatomic) XCBConnection *connection;

- (instancetype) initWithName:(NSString *)aName andConnection:(XCBConnection *)aConnection;
- (NSMutableDictionary *) requestWindowsMap;

@end