//
//  StopwatchObject.h
//  Clock
//
//  Created by tran nam on 5/2/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopwatchObject : NSObject
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger min;
@property (nonatomic, assign) NSInteger sec;
@property (nonatomic, assign) NSInteger mSec;

-(id)initWithTime:(NSInteger)times day:(NSInteger)day hour:(NSInteger)hour min:(NSInteger)min sec:(NSInteger)sec mSec:(NSInteger)mSec;
-(NSString *)timeToString;
-(NSString *)Lap;
@end
