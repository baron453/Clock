//
//  AppDelegate.h
//  Clock
//
//  Created by tran nam on 4/23/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class WorldClock;
@class CurrentClock;
@class TimerClock;
@class AlarmClock;
@class StopWatchClock;
@class TimerObject;
@interface AppDelegate : NSObject <NSApplicationDelegate>{
    WorldClock *worldClock;
    CurrentClock *currentClock;
    TimerClock *timerClock;
}
@property TimerObject *time;
@property NSTimer *aTimer;
@property BOOL showTime;
@property (weak) IBOutlet NSMenu *statusMenu;
@property (strong, nonatomic) NSStatusItem *statusItem;

@end

