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
#import <XCBKit/services/TitleBarSettingsService.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // insert code here...
        NSLog(@"Starting uroswm...");

        TitleBarSettingsService *settings = [TitleBarSettingsService sharedInstance];
        [settings setHeight:25];
        XCBPoint closePosition = XCBMakePoint(3.5,3.8);
        XCBPoint minimizePosition = XCBMakePoint(3,8);
        XCBPoint maximizePosition = XCBMakePoint(3,3);
        [settings setClosePosition:closePosition];
        [settings setMinimizePosition:minimizePosition];
        [settings setMaximizePosition:maximizePosition];

        URSEventHandler* ursHandler = [[URSEventHandler alloc] init];
        [ursHandler registerAsWindowManager];
        [ursHandler startEventHandlerLoop];
    }

    return 0;
}
