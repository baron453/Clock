//
//  TimerClock.m
//  Clock
//
//  Created by tran nam on 4/28/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import "TimerClock.h"
#import "WorldClock.h"
#import "CurrentClock.h"
#import "AlarmClock.h"
#import "StopWatchClock.h"
#import "AppDelegate.h"
@interface TimerClock ()
@property NSString *title;
@property NSColor *color;
@property NSInteger itemTimeEnd;
@property NSArray *actionTimeEnd;
@property NSArray *nameSounds;
@property NSArray *nameSoundsInterface;
@property AppDelegate *delegate;
@end

@implementation TimerClock

- (void)windowDidLoad {
    [super windowDidLoad];
    _actionTimeEnd = @[@"Shut Down", @"Restart", @"Sleep",@"Log Out", @"Sounds"];
    _nameSounds = @[@"good_morning"];
    _nameSoundsInterface = @[@"Good Morning"];
    
     _delegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    //NSMenu *menu = [_hourPopup menu];
    NSInteger i;
    for (i = 0; i <24; i++) {
        [_hourPopup addItemWithTitle:[NSString stringWithFormat:@"%ld",i]];
    }
    [_hourPopup selectItemAtIndex:0];
    for (i = 0; i <60; i++) {
        [_MinPopup addItemWithTitle:[NSString stringWithFormat:@"%ld",i]];
    }
    [_MinPopup selectItemAtIndex:0];
    for (i = 0; i <_actionTimeEnd.count; i++) {
        [_actionPopup addItemWithTitle:[NSString stringWithFormat:@"%@",_actionTimeEnd[i]]];
    }
    [_actionPopup selectItemAtIndex:0];
    for (i = 0; i <_nameSoundsInterface.count; i++) {
        [_soundAlert addItemWithTitle:[NSString stringWithFormat:@"%@",_nameSoundsInterface[i]]];
    }
    [_soundAlert selectItemAtIndex:0];
    _title = @"Start";
    _color = [NSColor greenColor];
    [self setButtonTitleFor:_startButton toString:_title withColor:_color];
    _title = @"Pause";
    _color = [NSColor blackColor];
    [self setButtonTitleFor:_pauseButton toString:_title withColor:_color];
}


- (IBAction)pauseOrResume:(id)sender {
    if(!_isPaused){
        _isPaused=YES;
        _title = @"Resume";
        _color = [NSColor blackColor];
        [self setButtonTitleFor:_pauseButton toString:_title withColor:_color];

        //[_pauseButton setTitle:@"Resume"];
    }else{
        _isPaused=NO;
        _title = @"Pause";
        _color = [NSColor blackColor];
        [self setButtonTitleFor:_pauseButton toString:_title withColor:_color];

        //[_pauseButton setTitle:@"Pause"];
    }
    
}
- (IBAction)startOrStop:(id)sender {
    if(!_isStarted){
        _isStarted=YES;
        _isPaused=NO;
        _delegate.showTime = NO;
        [_hourPopup setEnabled:NO];
        [_MinPopup setEnabled:NO];
        [_actionPopup setEnabled:NO];
        [_soundAlert setEnabled:NO];
        _hour = [[_hourPopup titleOfSelectedItem ] integerValue];
        _min = [[_MinPopup titleOfSelectedItem ] integerValue];
        
        [self updateLabel];
        _aTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector (updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_aTimer forMode:NSEventTrackingRunLoopMode];
        //[_aTimer fire];
        _title = @"Stop";
        _color = [NSColor redColor];
        [self setButtonTitleFor:_startButton toString:_title withColor:_color];

        [_pauseButton setEnabled:YES];
        //[_startButton setTitle:@"Stop"];
    }else{
        [self stopIt];
    }
}

- (IBAction)showStopWatch:(id)sender {
    if(!stopwatchClock){
        stopwatchClock = [[StopWatchClock alloc] initWithWindowNibName:@"StopWatchClock"];
    }
    [stopwatchClock showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
    [self close];
}

- (IBAction)showAlarm:(id)sender {
    if(!alarmClock){
        alarmClock = [[AlarmClock alloc] initWithWindowNibName:@"AlarmClock"];
    }
    [alarmClock showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
    [self close];
}

- (IBAction)showWorldClock:(id)sender {
    if(!worldClock){
        worldClock = [[WorldClock alloc] initWithWindowNibName:@"WorldClock"];
    }
    [worldClock showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
    [self close];
}

- (IBAction)actionTimeEnds:(id)sender {
    _itemTimeEnd = [_actionPopup indexOfSelectedItem];
    if(_itemTimeEnd==4){
        [_soundAlert setEnabled:YES];
    }else{
        [_soundAlert setEnabled:NO];
    }
}
-(void)updateTimer{
    if(!_isPaused){
        if(_sec==0 && _min==0 && _hour==0){
            [self stopIt];
            if(_itemTimeEnd==4){
                NSInteger indexSound =[_soundAlert indexOfSelectedItem];
                NSString *soundName = [NSString stringWithFormat:@"%@",_nameSounds[indexSound]];
                NSSound *soundAlarm = [NSSound soundNamed:soundName];
                [soundAlarm play];
                [soundAlarm setLoops:YES];
                NSAlert *alert = [[NSAlert alloc] init];
                [alert setMessageText:@"Alarm"];
                [alert setInformativeText:@"Timer Out."];
                //[alert addButtonWithTitle:@"Cancel"];
                [alert addButtonWithTitle:@"Ok"];
                [alert runModal];
                [soundAlarm stop];
                return;
            }else{
                NSString *scriptAction = [_actionPopup titleOfSelectedItem]; // @"restart"/@"shut down"/@"sleep"/@"log out"
                NSString *scriptSource = [NSString stringWithFormat:@"tell application \"Finder\" to %@", scriptAction];
                NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptSource];
                NSDictionary *errDict = nil;
                if (![appleScript executeAndReturnError:&errDict]) {
                    NSLog(@"scriptError description");
                }
                [self forceKillAllApplication];
                return;
            }
        }
        
        if(_sec<=0){
            _sec=59;
            _min-=1;
        }else{
            _sec-=1;
        }
        
        if(_min<0){
            _min=59;
            _hour-=1;
        }
    }
    [self updateLabel];
}

-(void)updateLabel{
    NSString *aHour =(_hour<10?[NSString stringWithFormat:@"0%ld",_hour]:[NSString stringWithFormat:@"%ld",_hour]);
    NSString *aMin =(_min<10?[NSString stringWithFormat:@"0%ld",_min]:[NSString stringWithFormat:@"%ld",_min]);
    NSString *aSec =(_sec<10?[NSString stringWithFormat:@"0%ld",_sec]:[NSString stringWithFormat:@"%ld",_sec]);
    [_timeTextField setStringValue:[NSString stringWithFormat:@"%@:%@:%@",aHour,aMin,aSec]];
    _delegate.statusItem.title = [NSString stringWithFormat:@"%@:%@:%@",aHour,aMin,aSec];
}

-(void)stopIt{
    if (_aTimer) {
        [_aTimer invalidate];
        _aTimer = nil;
        _isStarted=NO;
        _isPaused=NO;
        _delegate.showTime=YES;
        [_hourPopup setEnabled:YES];
        [_MinPopup setEnabled:YES];
        [_actionPopup setEnabled:YES];
        if(_itemTimeEnd==4)
            [_soundAlert setEnabled:YES];
        else
            [_soundAlert setEnabled:NO];
        _hour = 0;
        _min = 0;
        _sec = 0;
        //[_pauseButton setTitle:@"Pause"];
        //[_startButton setTitle:@"Start"];
        [_timeTextField setStringValue:@"00:00:00"];
        _title = @"Start";
        _color = [NSColor greenColor];
        [self setButtonTitleFor:_startButton toString:_title withColor:_color];
        _title = @"Pause";
        _color = [NSColor blackColor];
        [self setButtonTitleFor:_pauseButton toString:_title withColor:_color];
        [_pauseButton setEnabled:NO];
    }
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

-(void)forceKillAllApplication{
    // If that didn‘t work then try shoot it in the head, also works for OS X < 10.6.
    NSArray *runningApplications = [[NSWorkspace sharedWorkspace] launchedApplications];
    NSString *theName;
    NSNumber *pid;
    for ( NSDictionary *applInfo in runningApplications ) {
        if ( (theName = [applInfo objectForKey:@"NSApplicationName"]) ) {
            if ( (pid = [applInfo objectForKey:@"NSApplicationProcessIdentifier"]) ) {
                //NSLog( @"Process %@ has pid:%@", theName, pid );    //test
                //if( [theName isEqualToString:@"applicationName"] ) {
                    kill( [pid intValue], SIGKILL );
                    //TerminatedAtLeastOne = true;
                //}
            }
        }
    }
    //return TerminatedAtLeastOne;
}
@end
