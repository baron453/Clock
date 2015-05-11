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
#import "TimerClockViewController.h"
@interface AppDelegate ()
@property NSCalendarDate *theDate;
@end

@implementation AppDelegate{
    TimerClockViewController *viewController;
    NSPopover *popover;
    NSEvent *eventMonitor;
    BOOL isShowPop;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    _showTime = YES;
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [_statusItem setView:_view];
    [_statusItem setHighlightMode:YES];
    [_statusItem setMenu:_statusMenu];
    // Insert code here to initialize your application
    if(!viewController){
        viewController=[[TimerClockViewController alloc]initWithNibName:@"TimerClockViewController"bundle:nil];
    }
    
    if(!popover){
        popover=[[NSPopover alloc]init];
        popover.contentViewController=viewController;
    }
    
    //_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    //[_statusItem setTarget:self];
    //
    //[_statusItem setAction:@selector(showTimer)];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showPopver)
                                                 name:@"LeftClickButtonStatusItem"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showMenuItem)
                                                 name:@"RightClickButtonStatusItem"
                                               object:nil];
    self.aTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(ticktack) userInfo:nil repeats:YES];
}


-(void)ticktack{
    if(_showTime){
        _theDate = [NSCalendarDate date];
        [_statusTitle setStringValue:[_theDate descriptionWithCalendarFormat:@"%H:%M:%S" timeZone:nil locale:[NSUserDefaults standardUserDefaults]]];
    }
}

-(void)showPopver{
    if(isShowPop) return [self hidePopover];
    isShowPop = YES;
    [popover showRelativeToRect:_statusItem.view.frame ofView:_statusItem.view preferredEdge:NSMinYEdge];
    if (eventMonitor) {
        [NSEvent removeMonitor:eventMonitor];
        eventMonitor = nil;
    }
    eventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:(NSLeftMouseDownMask | NSRightMouseDownMask | NSKeyUpMask) handler:^(NSEvent *event) {
        [self hidePopover];
    }];
}

-(void)hidePopover{
    //NSLog(@"22");
    //NSString *visibleAsBg = [[PrefrencesManager sharedManager] getValueForKey:kKeepTabAbout];
    //if ([visibleAsBg isEqualToString:kValueNo]){ //--flag on
    isShowPop=NO;
    [popover close];
    if (eventMonitor) {
        [NSEvent removeMonitor:eventMonitor];
        eventMonitor = nil;
    }
        //isState = NO;
    //}
}

-(void)showMenuItem{
    [_statusItem popUpStatusItemMenu:_statusMenu];
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
