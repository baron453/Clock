//
//  StopwatchObject.m
//  Clock
//
//  Created by tran nam on 5/2/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import "StopwatchObject.h"

@implementation StopwatchObject

-(id)initWithTime:(NSInteger)times day:(NSInteger)day hour:(NSInteger)hour min:(NSInteger)min sec:(NSInteger)sec mSec:(NSInteger)mSec{
    if((self = [super init])){
        self.times = times;
        self.day = day;
        self.hour = hour;
        self.min = min;
        self.sec = sec;
        self.mSec = mSec;
    }
    return self;
}

-(NSString *)timeToString{
    
    NSString *aHour =(_hour<10?[NSString stringWithFormat:@"0%ld",_hour]:[NSString stringWithFormat:@"%ld",_hour]);
    NSString *aMin =(_min<10?[NSString stringWithFormat:@"0%ld",_min]:[NSString stringWithFormat:@"%ld",_min]);
    NSString *aSec =(_sec<10?[NSString stringWithFormat:@"0%ld",_sec]:[NSString stringWithFormat:@"%ld",_sec]);
    NSString *aMiliSec =(_mSec<10?[NSString stringWithFormat:@"0%ld",_mSec]:[NSString stringWithFormat:@"%ld",_mSec]);
    if(_hour==0){
        return [NSString stringWithFormat:@"%@:%@.%@",aMin,aSec,aMiliSec];
    }else{
        return [NSString stringWithFormat:@"%@:%@:%@.%@",aHour,aMin,aSec,aMiliSec];
    }
}

-(NSString *)Lap{
    NSString *aLap =[NSString stringWithFormat:@"0%ld",_times];
    return [NSString stringWithFormat:@"Lap %@",aLap];
}
@end
