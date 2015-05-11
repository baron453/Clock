//
//  TimerClockViewController.h
//  Clock
//
//  Created by tran nam on 5/10/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TimerClockViewController : NSViewController

@property (nonatomic, weak) IBOutlet NSPopUpButton *hourPopup;
@property (nonatomic, weak) IBOutlet NSPopUpButton *MinPopup;
@property (weak) IBOutlet NSPopUpButton *actionPopup;
@property (weak) IBOutlet NSPopUpButton *soundAlert;
@property (weak) IBOutlet NSView *setTimeView;

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
- (IBAction)actionTimeEnds:(id)sender;
@end
