//
//  MyClockController.m
//  MyClock
//
//  Created by Anders Hasselqvist on 4/30/06.
//  Copyright 2006, 2009 Anders Hasselqvist. All rights reserved.
//

#import "MyClockController.h"


@implementation MyClockController

- (void)awakeFromNib
{
    [self timerCreate];

    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem retain];

    [statusItem setHighlightMode:YES];
    [statusItem setMenu:theMenu];
    [statusItem setEnabled:YES];
    [statusItem setLength:150];
    
    [self setTimeInTitle];
}

- (void)timerCreate
{
    NSCalendar *calendar;
    NSDateComponents *comp;
    NSDate *now;
    NSDate *fireDate;
    NSTimeInterval seconds;
    NSRunLoop *myLoop;

    /* Get the current time and calculate the offset to the next minute */
    calendar = [NSCalendar currentCalendar];
    now = [NSDate date];
    comp = [calendar components:NSSecondCalendarUnit
                       fromDate:now];

    seconds = 60 - [comp second];

    fireDate = [NSDate dateWithTimeInterval:seconds
                                  sinceDate:now];

    /* Fire a timer at the beginning of next minute and repeat every minute */
    mainTimer = [[NSTimer alloc] initWithFireDate:fireDate
                                         interval:(60.0)
                                           target:self
                                         selector:@selector(timer:)
                                         userInfo:nil
                                          repeats:YES];
    [mainTimer retain];

    myLoop = [NSRunLoop currentRunLoop];
    [myLoop addTimer:mainTimer forMode:NSDefaultRunLoopMode];
}

- (void)timer:(NSTimer *)timer
{
    NSLog(@"timer fired");
    [self setTimeInTitle];
}

- (void)dealloc
{
    [statusItem release];
    [mainTimer invalidate];
    [mainTimer release];
    
    [super dealloc];
}

- (void)setTimeInTitle
{
    NSCalendarDate *time;
    NSString *titleString;
    
    time = [NSCalendarDate calendarDate];
    [time setCalendarFormat:@"Sweden %H:%M"];
    [time setTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"CET"]];
    titleString = [[NSString alloc] initWithFormat:@"%@", time];
    [statusItem setTitle:[NSString stringWithString:titleString]];
    [titleString release];
}

@end
