//
//  timerObject.h
//  Clock
//
//  Created by tran nam on 4/29/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerObject : NSObject
@property NSInteger hour;
@property NSInteger min;
@property NSInteger sec;
@property BOOL isPause;
@property BOOL isStart;

-(void)updateHour:(NSInteger)Hour Min:(NSInteger)Min;
-(void)updateStart:(BOOL)Start Pause:(BOOL)Pause;
-(void)updateTimer;
-(NSString *)updateLabel;
@end
