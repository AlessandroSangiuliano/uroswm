//
//  URSEventHandler.m
//  uroswm
//
//  Created by Alessandro Sangiuliano on 22/06/20.
//  Copyright (c) 2020 Alessandro Sangiuliano. All rights reserved.
//

#import "URSEventHandler.h"
#import <XCBKit/XCBScreen.h>
#import <xcb/xcb.h>

@implementation URSEventHandler

@synthesize connection;
@synthesize selectionManagerWindow;


- (id) init
{
    self  = [super init];

    if (self == nil)
    {
        NSLog(@"Unable to init...");
        return nil;
    }

    connection = [XCBConnection sharedConnection];

    return self;
}

- (void) registerAsWindowManager
{
    XCBScreen *screen = [[connection screens] objectAtIndex:0];
    XCBVisual *visual = [[XCBVisual alloc] initWithVisualId:[screen screen]->root_visual];
    [visual setVisualTypeForScreen:screen];


    selectionManagerWindow = [connection createWindowWithDepth:[screen screen]->root_depth
                                                                     withParentWindow:[screen rootWindow]
                                                                        withXPosition:-1
                                                                        withYPosition:-1
                                                                            withWidth:1
                                                                           withHeight:1
                                                                     withBorrderWidth:0
                                                                         withXCBClass:XCB_COPY_FROM_PARENT
                                                                         withVisualId:visual
                                                                        withValueMask:0
                                                                        withValueList:NULL];

    [connection registerAsWindowManager:YES screenId:1 selectionWindow:selectionManagerWindow];

    screen = nil;
    visual = nil;
}

- (void) startEventHandlerLoop
{
    xcb_generic_event_t *e;

    while ((e = xcb_wait_for_event([connection connection])))
    {
        switch (e->response_type & ~0x80)
        {
            case XCB_VISIBILITY_NOTIFY:
                NSLog(@"");
                xcb_visibility_notify_event_t* visibilityEvent = (xcb_visibility_notify_event_t*)e;
                NSLog(@"Visibility Event for window: %u", visibilityEvent->window);
                [connection handleVisibilityEvent:visibilityEvent];
                break;
            case XCB_EXPOSE:
                NSLog(@"");
                xcb_expose_event_t * exposeEvent = (xcb_expose_event_t *)e;
                NSLog(@"Expose for window %u", exposeEvent->window);
                [connection handleExpose:exposeEvent];
                [connection flush];
                [connection setNeedFlush:NO];
                break;

            case XCB_MOTION_NOTIFY:
                NSLog(@"");
                xcb_motion_notify_event_t *motionEvent = (xcb_motion_notify_event_t *)e;
                NSLog(@"Motion Notify for window %u: ", motionEvent->event);
                [connection handleMotionNotify:motionEvent];
                [connection flush];
                [connection setNeedFlush:NO];
                break;

            case XCB_ENTER_NOTIFY:
                NSLog(@"");
                xcb_enter_notify_event_t* enterEvent = (xcb_enter_notify_event_t*)e;
                NSLog(@"Enter notify for window %u", enterEvent->event);
                [connection handleEnterNotify:enterEvent];
                [connection flush];
                break;

            case XCB_LEAVE_NOTIFY:
                NSLog(@"");
                xcb_leave_notify_event_t* leaveEvent = (xcb_leave_notify_event_t*)e;
                NSLog(@"Leave notify for window %u", leaveEvent->event);
                [connection handleLeaveNotify:leaveEvent];
                [connection flush];
                break;

            case XCB_FOCUS_IN:
                NSLog(@"");
                xcb_focus_in_event_t* focusInEvent = (xcb_focus_in_event_t*)e;
                NSLog(@"Focus In Event for window %u", focusInEvent->event);
                //[connection handleFocusIn:focusInEvent];
                break;

            case XCB_FOCUS_OUT:
                NSLog(@"");
                xcb_focus_out_event_t* focusOutEvent = (xcb_focus_out_event_t*)e;
                NSLog(@"Focus Out Event for window %u", focusOutEvent->event);
                //[connection handleFocusOut:focusOutEvent];
                break;

            case XCB_BUTTON_PRESS:
                NSLog(@"");
                xcb_button_press_event_t* pressEvent = (xcb_button_press_event_t*)e;
                NSLog(@"Button Press Event for window %u: ", pressEvent->event);
                [connection handleButtonPress:pressEvent];
                [connection flush];
                [connection setNeedFlush:NO];
                break;

            case XCB_BUTTON_RELEASE:
                NSLog(@"");
                xcb_button_release_event_t* releaseEvent = (xcb_button_release_event_t*)e;
                NSLog(@"Button Release Event for window %u: ", releaseEvent->event);
                [connection handleButtonRelease:releaseEvent];
                [connection flush];
                [connection setNeedFlush:NO];
                break;

            case XCB_MAP_NOTIFY:
                NSLog(@"");
                xcb_map_notify_event_t *notifyEvent = (xcb_map_notify_event_t*)e;
                NSLog(@"MAP NOTIFY for window %u", notifyEvent->window);
                [connection handleMapNotify:notifyEvent];
                break;

            case XCB_MAP_REQUEST:
                NSLog(@"");
                xcb_map_request_event_t* mapRequestEvent = (xcb_map_request_event_t*)e;
                NSLog(@"Map Request for window %u", mapRequestEvent->window);
                [connection handleMapRequest:mapRequestEvent];
                [connection flush];
                [connection setNeedFlush:NO];
                break;

            case XCB_UNMAP_NOTIFY:
                NSLog(@"");
                xcb_unmap_notify_event_t* unmapNotifyEvent = (xcb_unmap_notify_event_t*)e;
                NSLog(@"Unmap Notify for window %u", unmapNotifyEvent->window);
                [connection handleUnMapNotify:unmapNotifyEvent];
                break;

            case XCB_DESTROY_NOTIFY:
                NSLog(@"");
                xcb_destroy_notify_event_t *destroyNotify = (xcb_destroy_notify_event_t*)e;
                NSLog(@"Destroy Notify for window: %u", destroyNotify->window);
                [connection handleDestroyNotify:destroyNotify];
                [connection flush];
                [connection setNeedFlush:NO];
                break;

            case XCB_CLIENT_MESSAGE:
                NSLog(@"");
                xcb_client_message_event_t *clientMessageEvent = (xcb_client_message_event_t *)e;
                NSLog(@"Cient message event: %u", clientMessageEvent->window);
                [connection handleClientMessage:clientMessageEvent];
                [connection flush];
                [connection setNeedFlush:NO];
                break;

            case XCB_CONFIGURE_REQUEST:
                NSLog(@"");
                xcb_configure_request_event_t* configRequest = (xcb_configure_request_event_t*)e;
                NSLog(@"Configure request for window %u", configRequest->window);
                [connection handleConfigureWindowRequest:configRequest];
                [connection flush];
                [connection setNeedFlush:NO];
                break;

            case XCB_CONFIGURE_NOTIFY:
                NSLog(@"");
                xcb_configure_notify_event_t* configureNotify = (xcb_configure_notify_event_t*)e;
                NSLog(@"Configure notify for window %u", configureNotify->window);
                [connection handleConfigureNotify:configureNotify];
                [connection flush];
                [connection setNeedFlush:NO];
                break;
            case XCB_PROPERTY_NOTIFY:
                NSLog(@"");
                xcb_property_notify_event_t* propEvent = (xcb_property_notify_event_t*)e;
                NSLog(@"Window %u notify property change", propEvent->window);
                break;
            default:
                break;
        }
        free(e);
    }

}

- (void) dealloc
{
    connection = nil;
    selectionManagerWindow = nil;
}
@end
