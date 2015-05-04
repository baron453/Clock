//
//  AppDelegate.m
//  Clock
//
//  Created by tran nam on 4/23/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import "AppDelegate.h"
#import "WorldClock.h"
#import "CurrentClock.h"
#import "TimerClock.h"
#import "AlarmClock.h"
#import "StopWatchClock.h"
#import "worldClockData.h"
#import "TimerObject.h"
@interface AppDelegate ()
@property NSCalendarDate *theDate;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _showTime = YES;
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [_statusItem setTarget:self];
    //[_statusItem setMenu:_statusMenu];
    [_statusItem setAction:@selector(showTimer)];
    self.aTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(ticktack) userInfo:nil repeats:YES];
}


-(void)ticktack{
    if(_showTime){
        _theDate = [NSCalendarDate date];
        self.statusItem.title =[_theDate descriptionWithCalendarFormat:@"%H:%M:%S" timeZone:nil locale:[NSUserDefaults standardUserDefaults]];
    }
}

- (void)showTimer{
    if(!timerClock){
        timerClock = [[TimerClock alloc] initWithWindowNibName:@"TimerClock"];
    }
    [timerClock showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
@end
