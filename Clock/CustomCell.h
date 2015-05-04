//
//  CustomCell.h
//  Clock
//
//  Created by tran nam on 4/27/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CustomCell : NSTableCellView

@property (nonatomic, weak) IBOutlet NSTextField *Name;
@property (nonatomic, weak) IBOutlet NSTextField *Clock;
@end
