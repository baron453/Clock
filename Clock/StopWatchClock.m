//
//  StopWatchClock.m
//  Clock
//
//  Created by tran nam on 4/30/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import "StopWatchClock.h"
#import "WorldClock.h"
#import "CurrentClock.h"
#import "TimerClock.h"
#import "AlarmClock.h"
#import "StopwatchObject.h"
@interface StopWatchClock ()
@property NSString *title;
@property NSColor *color;

@end

@implementation StopWatchClock

- (void)windowDidLoad {
    [super windowDidLoad];
    _isStarted=NO;
    _totalDay = _totalHour = _totalMin = _totalSec = _totalMiliSec = 0;
    _subDay = _subHour = _subMin = _subSec = _subMiliSec = 0;
    StopwatchObject *time1 = [[StopwatchObject alloc] initWithTime:0 day:(0) hour:(0) min:0 sec:5 mSec:45];
    [self.times addObject:time1];
    StopwatchObject *time2 = [[StopwatchObject alloc] initWithTime:1 day:(0) hour:(0) min:0 sec:6 mSec:27];
    [self.times addObject:time2];
    StopwatchObject *time3 = [[StopwatchObject alloc] initWithTime:2 day:(0) hour:(0) min:0 sec:3 mSec:30];
    [self.times addObject:time3];
    StopwatchObject *time4 = [[StopwatchObject alloc] initWithTime:3 day:(0) hour:(0) min:0 sec:8 mSec:44];
    [self.times addObject:time4];
    StopwatchObject *time5 = [[StopwatchObject alloc] initWithTime:4 day:(0) hour:(0) min:0 sec:14 mSec:12];
    [self.times addObject:time5];
    //self.times = [[NSMutableArray alloc] init];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)startOrCancel:(id)sender {
    if(!_isStarted){
        _isStarted=YES;
        _isLaped=NO;
        [self updateLabel];
        _aTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector (updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_aTimer forMode:NSEventTrackingRunLoopMode];
        //[_aTimer fire];
        _title = @"Stop";
        _color = [NSColor redColor];
        [self setButtonTitleFor:_startButton toString:_title withColor:_color];
        
        _title = @"Lap";
        _color = [NSColor blackColor];
        [self setButtonTitleFor:_lapButton toString:_title withColor:_color];
        [_lapButton setEnabled:YES];
        //[_startButton setTitle:@"Stop"];
    }else{
        [self stopIt];
    }
}

- (IBAction)lapOrReset:(id)sender {
    if(_isStarted){
        NSInteger times = _times.count;
        StopwatchObject *newTime = [[StopwatchObject alloc] initWithTime:times+1 day:_subDay hour:_subHour min:_subMin sec:_subSec mSec:_subMiliSec];
        
        [_times addObject:newTime];
        //[_times insertObject:newTime atIndex:0];
        [_timesTableView reloadData];
        //[_timesTableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:0] withAnimation: NSTableViewAnimationEffectGap];
        //[_timesTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
        
        //[_timesTableView scrollRowToVisible:0];
        _subHour = _subMin = _subSec = _subMiliSec = 0;
    }else{
        [self resetIt];
    }
}

-(void)updateTimer{
    if(_totalMin>=59){
        _totalMin=0;
        _totalHour+=1;
    }
    if(_totalSec>=59){
        _totalSec=0;
        _totalMin+=1;
    }
    if(_totalMiliSec>=99){
        _totalMiliSec=0;
        _totalSec+=1;
    }else{
        _totalMiliSec+=1;
    }
    
    if(_subMin>=59){
        _subMin=0;
        _subHour+=1;
    }
    if(_subSec>=59){
        _subSec=0;
        _subMin+=1;
    }
    if(_subMiliSec>=99){
        _subMiliSec=0;
        _subSec+=1;
    }else{
        _subMiliSec+=1;
    }
    [self updateLabel];
}

-(void)updateLabel{
    NSString *aTotalHour =(_totalHour<10?[NSString stringWithFormat:@"0%ld",_totalHour]:[NSString stringWithFormat:@"%ld",_totalHour]);
    NSString *aTotalMin =(_totalMin<10?[NSString stringWithFormat:@"0%ld",_totalMin]:[NSString stringWithFormat:@"%ld",_totalMin]);
    NSString *aTotalSec =(_totalSec<10?[NSString stringWithFormat:@"0%ld",_totalSec]:[NSString stringWithFormat:@"%ld",_totalSec]);
    NSString *aTotalMiliSec =(_totalMiliSec<10?[NSString stringWithFormat:@"0%ld",_totalMiliSec]:[NSString stringWithFormat:@"%ld",_totalMiliSec]);
    
    NSString *aSubHour =(_subHour<10?[NSString stringWithFormat:@"0%ld",_subHour]:[NSString stringWithFormat:@"%ld",_subHour]);
    NSString *aSubMin =(_subMin<10?[NSString stringWithFormat:@"0%ld",_subMin]:[NSString stringWithFormat:@"%ld",_subMin]);
    NSString *aSubSec =(_subSec<10?[NSString stringWithFormat:@"0%ld",_subSec]:[NSString stringWithFormat:@"%ld",_subSec]);
    NSString *aSubMiliSec =(_subMiliSec<10?[NSString stringWithFormat:@"0%ld",_subMiliSec]:[NSString stringWithFormat:@"%ld",_subMiliSec]);
    if(_totalHour==0){
        [_totalTime setStringValue:[NSString stringWithFormat:@"%@:%@.%@",aTotalMin,aTotalSec,aTotalMiliSec]];
    }else{
        [_totalTime setStringValue:[NSString stringWithFormat:@"%@:%@:%@.%@",aTotalHour,aTotalMin,aTotalSec,aTotalMiliSec]];
    }
    if(_subHour==0){
        [_subTime setStringValue:[NSString stringWithFormat:@"%@:%@.%@",aSubMin,aSubSec,aSubMiliSec]];
    }else{
        [_subTime setStringValue:[NSString stringWithFormat:@"%@:%@:%@.%@",aSubHour,aSubMin,aSubSec,aSubMiliSec]];
    }
    
}
-(void)stopIt{
    if (_aTimer) {
        [_aTimer invalidate];
        _aTimer = nil;
        _isStarted=NO;
        //[_pauseButton setTitle:@"Pause"];
        //[_startButton setTitle:@"Start"];
        _title = @"Start";
        _color = [NSColor greenColor];
        [self setButtonTitleFor:_startButton toString:_title withColor:_color];
        _title = @"Reset";
        _color = [NSColor blackColor];
        [self setButtonTitleFor:_lapButton toString:_title withColor:_color];
    }
}

-(void)resetIt{
    _totalHour = _totalMin = _totalSec = _totalMiliSec = 0;
    _subHour = _subMin = _subSec = _subMiliSec = 0;
    [_totalTime setStringValue:@"00:00.00"];
    [_subTime setStringValue:@"00:00.00"];
    _title = @"Lap";
    _color = [NSColor blackColor];
    [self setButtonTitleFor:_lapButton toString:_title withColor:_color];
    [_lapButton setEnabled:NO];
}

- (IBAction)showWorldClock:(id)sender {
    if(!worldClock){
        worldClock = [[WorldClock alloc] initWithWindowNibName:@"WorldClock"];
    }
    [worldClock showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
    [self close];
}

- (IBAction)showAlarmClock:(id)sender {
    if(!alarmClock){
        alarmClock = [[AlarmClock alloc] initWithWindowNibName:@"AlarmClock"];
    }
    [alarmClock showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
    [self close];
}

- (IBAction)showTimer:(id)sender {
    if(!timerClock){
        timerClock = [[TimerClock alloc] initWithWindowNibName:@"TimerClock"];
    }
    [timerClock showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
    [self close];
}

- (void)setButtonTitleFor:(NSButton*)button toString:(NSString*)title withColor:(NSColor*)color
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSCenterTextAlignment];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName, style, NSParagraphStyleAttributeName, nil];
    NSAttributedString *attrString = [[NSAttributedString alloc]initWithString:title attributes:attrsDictionary];
    [button setAttributedTitle:attrString];
    [button setFont:[NSFont fontWithName:@"Helvetica Neue" size:20]];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.times count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSLog(@"sdasd");
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    // Since this is a single-column table view, this would not be necessary.
    // But it's a good practice to do it in order by remember it when a table is multicolumn.
    if( [tableColumn.identifier isEqualToString:@"Lap"] )
    {
        StopwatchObject *timeDoc = [self.times objectAtIndex:row];
        cellView.textField.stringValue = [timeDoc Lap];
        return cellView;
    }
    if( [tableColumn.identifier isEqualToString:@"Time"] )
    {
        StopwatchObject *timeDoc = [self.times objectAtIndex:row];
        cellView.textField.stringValue = [timeDoc timeToString];
        return cellView;
    }
    return cellView;
}
@end
