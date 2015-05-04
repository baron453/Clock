//
//  currentClock.m
//  Clock
//
//  Created by tran nam on 4/25/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import "CurrentClock.h"
#import "WorldClock.h"
#import "TimerClock.h"
#import "AlarmClock.h"
#import "StopWatchClock.h"

@interface CurrentClock ()

@end

@implementation CurrentClock

- (void)windowDidLoad {
    [super windowDidLoad];
    //[self.currentWindows makeKeyAndOrderFront:self];
    //[NSApp activateIgnoringOtherApps:YES];
    //[self.currentWindows setLevel:NSStatusWindowLevel];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)awakeFromNib{
    [self.Hour setMinValue:0];
    [self.Hour setMaxValue:23];
    
    [self.Min setMinValue:0];
    [self.Min setMaxValue:59];
    
    [self.Sec setMinValue:0];
    [self.Sec setMaxValue:59];

    self.aTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector (tick) userInfo:nil repeats:YES];
    [self.aTimer fire];
}

-(void)tick{
    NSCalendarDate *theDate;
    theDate = [NSCalendarDate date];
    [self.Timer setStringValue:[theDate descriptionWithCalendarFormat:@"%H:%M:%S" timeZone:nil locale:[NSUserDefaults standardUserDefaults]]];
    [self.Hour setDoubleValue:(double)[theDate hourOfDay]];
    [self.Min setDoubleValue:(double)[theDate minuteOfHour]];
    [self.Sec setDoubleValue:(double)[theDate secondOfMinute]];
}


@end
