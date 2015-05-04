//
//  timerObject.m
//  Clock
//
//  Created by tran nam on 4/29/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import "TimerObject.h"

@implementation TimerObject

-(id)init{
    if(self = [super init]){
        //-------
    }
    return self;
}
-(void)updateHour:(NSInteger)Hour Min:(NSInteger)Min{
    _hour = Hour;
    _min = Min;
    _sec = 1;
}
-(void)updateStart:(BOOL)Start Pause:(BOOL)Pause{
    _isStart = Start;
    _isPause = Pause;
}
-(void)updateTimer{
    if(_isPause){
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
        if(_sec==0 && _min==0 && _hour==0){
           _isPause = NO;
//            NSString *scriptAction = @"shut down"; // @"restart"/@"shut down"/@"sleep"/@"log out"
//            NSString *scriptSource = [NSString stringWithFormat:@"tell application \"Finder\" to %@", scriptAction];
//            NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptSource];
//            NSDictionary *errDict = nil;
//            if (![appleScript executeAndReturnError:&errDict]) {
//                NSLog(@"scriptError description");
//            }
        }
    }
}

-(NSString *)updateLabel{
    NSString *aHour =(_hour<10?[NSString stringWithFormat:@"0%ld",_hour]:[NSString stringWithFormat:@"%ld",_hour]);
    NSString *aMin =(_min<10?[NSString stringWithFormat:@"0%ld",_min]:[NSString stringWithFormat:@"%ld",_min]);
    NSString *aSec =(_sec<10?[NSString stringWithFormat:@"0%ld",_sec]:[NSString stringWithFormat:@"%ld",_sec]);
    return [NSString stringWithFormat:@"%@:%@:%@",aHour,aMin,aSec];
}

@end
