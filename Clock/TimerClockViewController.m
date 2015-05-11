//
//  TimerClockViewController.m
//  Clock
//
//  Created by tran nam on 5/10/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import "TimerClockViewController.h"
#import "AppDelegate.h"
@interface TimerClockViewController ()
//@property NSString *titles;
//@property NSColor *color;
@property NSInteger itemTimeEnd;
@property NSArray *actionTimeEnd;
@property NSArray *nameSounds;
@property NSArray *nameSoundsInterface;
@property AppDelegate *delegate;
@end

@implementation TimerClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _actionTimeEnd = @[@"Shut Down", @"Restart", @"Sleep",@"Log Out", @"Sounds"];
    _nameSounds = @[@"good_morning"];
    _nameSoundsInterface = @[@"Good Morning"];
    //[self.window setLevel: NSStatusWindowLevel];
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
}

- (IBAction)pauseOrResume:(id)sender {
    if(!_isPaused){
        _isPaused=YES;
        [_pauseButton setImage:[NSImage imageNamed:@"resume.png"]];
        //        _title = @"Resume";
        //        _color = [NSColor blackColor];
        //        [self setButtonTitleFor:_pauseButton toString:_title withColor:_color];
        
    }else{
        _isPaused=NO;
        [_pauseButton setImage:[NSImage imageNamed:@"pause.png"]];
        //        _title = @"Pause";
        //        _color = [NSColor blackColor];
        //        [self setButtonTitleFor:_pauseButton toString:_title withColor:_color];
        
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
        _sec = 1;
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.duration = 0.5;
            _setTimeView.animator.alphaValue = 0;
            [_startButton setEnabled:NO];
        } completionHandler:^{
                _setTimeView.hidden = YES;
                _setTimeView.alphaValue = 1;
            [_startButton setEnabled:YES];
            }];
        //[_setTimeView setHidden:YES];
        [_timeTextField setHidden:NO];
        [self updateTimer];
        _aTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector (updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_aTimer forMode:NSEventTrackingRunLoopMode];
        //[_aTimer fire];
        [_startButton setImage:[NSImage imageNamed:@"cancel.png"]];
        //        _title = @"Stop";
        //        _color = [NSColor redColor];
        //        [self setButtonTitleFor:_startButton toString:_title withColor:_color];
        
        [_pauseButton setEnabled:YES];
        //[_startButton setTitle:@"Stop"];
    }else{
        [self stopIt];
    }
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
                return [self stopIt];
            }else{
                NSString *scriptAction = [_actionPopup titleOfSelectedItem]; // @"restart"/@"shut down"/@"sleep"/@"log out"
                NSString *scriptSource = [NSString stringWithFormat:@"tell application \"Finder\" to %@", scriptAction];
                NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptSource];
                NSDictionary *errDict = nil;
                if (![appleScript executeAndReturnError:&errDict]) {
                    NSLog(@"scriptError description");
                }
                return [self forceKillAllApplication];
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
    [_delegate.statusTitle setStringValue:[NSString stringWithFormat:@"%@:%@:%@",aHour,aMin,aSec]];
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
        [_setTimeView setHidden:NO];
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.duration = 0.5;
            _timeTextField.animator.alphaValue = 0;
            [_startButton setEnabled:NO];
        } completionHandler:^{
            _timeTextField.hidden = YES;
            _timeTextField.alphaValue = 1;
            [_startButton setEnabled:YES];
        }];

        //[_timeTextField setHidden:YES];
        if(_itemTimeEnd==4)
            [_soundAlert setEnabled:YES];
        else
            [_soundAlert setEnabled:NO];
        _hour = 0;
        _min = 0;
        _sec = 1;
        //[_pauseButton setTitle:@"Pause"];
        //[_startButton setTitle:@"Start"];
        [_timeTextField setStringValue:@"00:00:00"];
        [_startButton setImage:[NSImage imageNamed:@"start.png"]];
        [_pauseButton setImage:[NSImage imageNamed:@"pause.png"]];
        //        _title = @"Start";
        //        _color = [NSColor greenColor];
        //        [self setButtonTitleFor:_startButton toString:_title withColor:_color];
        //        _title = @"Pause";
        //        _color = [NSColor blackColor];
        //        [self setButtonTitleFor:_pauseButton toString:_title withColor:_color];
        [_pauseButton setEnabled:NO];
    }
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
