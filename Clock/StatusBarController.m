//
//  StatusBarController.m
//  Clock
//
//  Created by tran nam on 5/10/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import "StatusBarController.h"

@implementation StatusBarController

- (void)mouseDown:(NSEvent *)event
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LeftClickButtonStatusItem" object:nil];}
- (void)rightMouseDown:(NSEvent *)event{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RightClickButtonStatusItem" object:nil];}


@end
