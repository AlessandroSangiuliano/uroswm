//
// UrosWMClient
// .
//
// Created by slex on 24/11/21.
//

#import <Foundation/Foundation.h>
#import <XCBKit/protocols/client/Client.h>

@interface UrosWMClient : NSObject <Client>
{
}

@property (strong, nonatomic) NSDistributedNotificationCenter *notificationCenter;

- (instancetype) init;
- (void) sendNotification:(NSNotification *)aNotification;

@end