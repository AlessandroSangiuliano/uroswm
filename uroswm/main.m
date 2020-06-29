//
//  main.m
//  uroswm
//
//  Created by Alessandro Sangiuliano on 22/06/20.
//  Copyright (c) 2020 Alessandro Sangiuliano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URSEventHandler.h"
#import <XCBKit/utils/XCBShape.h>
#import <AppKit/AppKit.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // insert code here...
        NSLog(@"Starting uroswm...");

        URSEventHandler* ursHandler = [[URSEventHandler alloc] init];
        [ursHandler registerAsWindowManager];
        [ursHandler startEventHandlerLoop];
    }

    return 0;
}
