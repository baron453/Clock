//
//  WorldClock.h
//  Clock
//
//  Created by tran nam on 4/24/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class WorldClock;
@class StopWatchClock;
@class AlarmClock;

@interface WorldClock : NSWindowController<NSTableViewDataSource,NSApplicationDelegate>
@property (nonatomic, strong) NSMutableArray *worldClock;
- (IBAction)addCountry:(id)sender;
- (IBAction)deleteCountry:(id)sender;
- (IBAction)showAlarm:(id)sender;
- (IBAction)showStopwatch:(id)sender;
- (IBAction)showTimer:(id)sender;
- (IBAction)quitApp:(id)sender;

@end
