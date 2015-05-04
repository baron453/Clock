//
//  currentClock.h
//  Clock
//
//  Created by tran nam on 4/25/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class WorldClock;
@class StopWatchClock;
@class AlarmClock;
@class TimerClock;
@interface CurrentClock : NSWindowController
@property (strong) IBOutlet NSWindow *currentWindows;

@property (weak) IBOutlet NSTextField *Timer;
@property (weak) IBOutlet NSProgressIndicator *Hour;
@property (weak) IBOutlet NSProgressIndicator *Min;
@property (weak) IBOutlet NSProgressIndicator *Sec;

@property NSTimer *aTimer;
@end
