//
//  worldClockData.m
//  Clock
//
//  Created by tran nam on 4/24/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import "worldClockData.h"

@implementation worldClockData
-(id)initWithName:(NSString *)name utc:(NSInteger)utc{
    if((self = [super init])){
        self.name = name;
        self.utc = utc;
    }
    return self;
}

@end
