Version: 0.1.0

uroswm is a window manager written in objective-c and using the XCBKit framework

========================================================================================

INSTALL

To install urosw, you need XCBKit installed on your system.

DEPENDENCIES

XCBKit: libxcb, xcb-fixes, libcairo, xcb-icccm, gnustep-base

uroswm: XCBKit

=======================================================================================

TESTING

If you want try the ursowm actual status you can try it using Xephyr:

$: Xephyr -ac -br -screen 1300x900 -reset :1 &
$: DISPLAY=:1
$: uroswm (or uroswm & if need to free the commandline)

Remember that the number :1 is the display you are going to set for Xephyr, it can't run on the one where X11 is running on.

Distributions could have did set as they want/needed the DISPLAY env var, for example actually on ubuntu 
you can't set DISPLAY=:1 because it is used for X11, you have to do DISPLAY:=2 for Xephyr,
while on manjaro you can use :1.



