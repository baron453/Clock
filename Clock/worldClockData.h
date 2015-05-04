
//
//  worldClockData.h
//  Clock
//
//  Created by tran nam on 4/24/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface worldClockData : NSObject

@property (strong) NSString *name;
@property (assign) NSInteger utc;
-(id)initWithName:(NSString *)name utc:(NSInteger)utc;
@end
