//
//  TimerClock.h
//  Clock
//
//  Created by tran nam on 4/28/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class WorldClock;
@class StopWatchClock;
@class AlarmClock;
@interface TimerClock : NSWindowController{
    WorldClock *worldClock;
    AlarmClock *alarmClock;
    StopWatchClock *stopwatchClock;

}
@property (nonatomic, weak) IBOutlet NSPopUpButton *hourPopup;
@property (nonatomic, weak) IBOutlet NSPopUpButton *MinPopup;
@property (weak) IBOutlet NSPopUpButton *actionPopup;
@property (weak) IBOutlet NSPopUpButton *soundAlert;

@property (nonatomic, weak) IBOutlet NSTextField *timeTextField;
@property (nonatomic, weak) IBOutlet NSButton *startButton;
@property (nonatomic, weak) IBOutlet NSButton *pauseButton;
@property NSInteger hour;
@property NSInteger min;
@property NSInteger sec;
@property NSTimer *aTimer;
@property NSSound *soundAlarm;
@property BOOL isStarted;
@property BOOL isPaused;

- (IBAction)pauseOrResume:(id)sender;
- (IBAction)startOrStop:(id)sender;
- (IBAction)showStopWatch:(id)sender;
- (IBAction)showAlarm:(id)sender;
- (IBAction)showWorldClock:(id)sender;
- (IBAction)actionTimeEnds:(id)sender;

@end
