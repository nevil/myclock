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
//    mainTimer = [[NSTimer scheduledTimerWithTimeInterval:(10.0)
//                                                  target:self
//                                                selector:@selector(timer:)
//                                                userInfo:nil
//                                                 repeats:YES] retain];
    statusItem = [[[NSStatusBar systemStatusBar]
        statusItemWithLength:NSVariableStatusItemLength] retain];

    [statusItem setHighlightMode:YES];
    [statusItem setMenu:theMenu];
    [statusItem setEnabled:YES];
    [statusItem setLength:150];
    
//    [mainTimer fire];
    [self setTimeInTitle];
}

- (void)timerCreate
{
    NSCalendar *calendar;
    NSDateComponents *comp;
    NSDate *tmpDate;
    NSDate *fireDate;
    int minute;
    NSRunLoop *myLoop;
    
    calendar = [NSCalendar currentCalendar];
    tmpDate = [NSDate date];
    comp = [calendar components:NSEraCalendarUnit|NSYearCalendarUnit|
        NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit
                       fromDate:tmpDate];
    
    minute = [comp minute];
    minute++;
    if (minute == 60)
    {
        minute = 0;
    }
    
    [comp setMinute:minute];
    [comp setSecond:(1)];
    
    fireDate = [calendar dateFromComponents:comp];

    mainTimer = [[[NSTimer alloc] initWithFireDate:fireDate
                                          interval:(1.0)
                                            target:self
                                          selector:@selector(timer:)
                                          userInfo:nil
                                           repeats:YES] retain];

    myLoop = [NSRunLoop currentRunLoop];
    [myLoop addTimer:mainTimer forMode:NSDefaultRunLoopMode];
//    [fireDate release];
//    [comp release];
//    [tmpDate release];
//    [calendar release];
}

- (void)timer:(NSTimer *)timer
{
//    NSLog(@"timer fired");
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
