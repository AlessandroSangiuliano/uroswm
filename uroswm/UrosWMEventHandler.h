//
//  UrosWMEventHandler.h
//  uroswm
//
//  Created by Alessandro Sangiuliano on 22/06/20.
//  Copyright (c) 2020 Alessandro Sangiuliano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCBKit/XCBConnection.h>
#import <XCBKit/XCBWindow.h>

@interface UrosWMEventHandler : NSObject

@property (strong, nonatomic) XCBConnection* connection;
@property (strong, nonatomic) XCBWindow* selectionManagerWindow;

- (id) init;

- (void) registerAsWindowManager;
- (void) startEventHandlerLoop;

- (void) dealloc;
@end
