//
//  StopWatchClock.h
//  Clock
//
//  Created by tran nam on 4/30/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class WorldClock;
@class TimerClock;
@class AlarmClock;

@interface StopWatchClock : NSWindowController<NSTableViewDataSource, NSTableViewDelegate>{
    WorldClock *worldClock;
    AlarmClock *alarmClock;
    TimerClock *timerClock;
}
@property (assign) NSMutableArray *times;
@property (weak) IBOutlet NSTableView *timesTableView;
@property (weak) IBOutlet NSTextField *subTime;
@property (weak) IBOutlet NSTextField *totalTime;
@property (weak) IBOutlet NSButton *lapButton;
@property (weak) IBOutlet NSButton *startButton;

@property NSInteger totalDay;
@property NSInteger totalHour;
@property NSInteger totalMin;
@property NSInteger totalSec;
@property NSInteger totalMiliSec;

@property NSInteger subDay;
@property NSInteger subHour;
@property NSInteger subMin;
@property NSInteger subSec;
@property NSInteger subMiliSec;

@property NSTimer *aTimer;
@property BOOL isStarted;
@property BOOL isLaped;
- (IBAction)startOrCancel:(id)sender;

- (IBAction)lapOrReset:(id)sender;

- (IBAction)showWorldClock:(id)sender;
- (IBAction)showAlarmClock:(id)sender;
- (IBAction)showTimer:(id)sender;



@end
