//
//  MyClockController.h
//  MyClock
//
//  Created by Anders Hasselqvist on 4/30/06.
//  Copyright 2006, 2009 Anders Hasselqvist. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MyClockController : NSObject
{

    // The status item that will be added to the system status bar
    NSStatusItem *statusItem;

    // The menu attached to the statusItem
    IBOutlet NSMenu *theMenu;
    
    // A timer which will update the title string every minute or so
    NSTimer *mainTimer;

}

// Create timer
- (void)timerCreate;

// Called when mainTimer fires
- (void)timer:(NSTimer *)timer;

- (void)setTimeInTitle;

- (void)registerNotifications;

@end
