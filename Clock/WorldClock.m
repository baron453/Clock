//
//  WorldClock.m
//  Clock
//
//  Created by tran nam on 4/24/15.
//  Copyright (c) 2015 tran nam. All rights reserved.
//

#import "WorldClock.h"
#import "worldClockData.h"
#import "CustomCell.h"
#import "CurrentClock.h"
#import "TimerClock.h"
#import "AlarmClock.h"
#import "StopWatchClock.h"

@interface WorldClock ()
@property (weak) IBOutlet NSTextField *nameCountry;
@property (weak) IBOutlet NSTextField *clockCountry;
@property (weak) IBOutlet NSTableView *worldClockTable;

@end

@implementation WorldClock
-(id)init{
    NSLog(@"init speecjsynth");
    self = [super init];
    if(self){
        NSLog(@"set Array");
        worldClockData *clock1 = [[worldClockData alloc] initWithName:@"Hà Nội, VN" utc:7];
        worldClockData *clock2 = [[worldClockData alloc] initWithName:@"Beijing, China" utc:8];
        worldClockData *clock3 = [[worldClockData alloc] initWithName:@"Lilongwe, Malawi" utc:2];
        worldClockData *clock4 = [[worldClockData alloc] initWithName:@"Rangoon, Myanmar" utc:6.5];
        worldClockData *clock5 = [[worldClockData alloc] initWithName:@"Mexico City, Mexico" utc:7];
        worldClockData *clock6 = [[worldClockData alloc] initWithName:@"Vientiane, Laos" utc:7];
        NSMutableArray *clock = [NSMutableArray arrayWithObjects:clock1, clock2, clock3, clock4, clock5, clock6,nil];
        self.worldClock = clock;
    }
    return self;
}- (void)windowDidLoad {
    [super windowDidLoad];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    CustomCell *cellView = (CustomCell *)[tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    if( [tableColumn.identifier isEqualToString:@"Country"] )
    {
        worldClockData *clockData = [self.worldClock objectAtIndex:row];
        NSLog(@"Name %@",clockData.name);
        cellView.Name.stringValue = clockData.name;
        return cellView;
    }
    if( [tableColumn.identifier isEqualToString:@"Clock"] )
    {
        worldClockData *clockData = [self.worldClock objectAtIndex:row];
        NSLog(@"Cloclk %ld",clockData.utc);
        cellView.Clock.stringValue = [NSString stringWithFormat:@"%ld",clockData.utc];
        return cellView;
    }
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tv
{
    NSLog(@"count: %ld", self.worldClock.count);
    return (NSInteger)[self.worldClock count];
}

//-(void)awakeFromNib{
//    
//}


- (IBAction)addCountry:(id)sender {
    worldClockData *newCountry = [[worldClockData alloc] initWithName:@"NamTran" utc:9];
    
    [self.worldClock addObject:newCountry];
    NSInteger newRowIndex = self.worldClock.count-2;
    //[_worldClock insertObject:newCountry atIndex:0];
    //[_worldClockTable reloadData];
    [_worldClockTable insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:0] withAnimation: NSTableViewAnimationEffectGap];
    [_worldClockTable selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    
    [_worldClockTable scrollRowToVisible:0];
}

- (IBAction)deleteCountry:(id)sender {
}

- (IBAction)showAlarm:(id)sender {
}

- (IBAction)showStopwatch:(id)sender {
}

- (IBAction)showTimer:(id)sender {
}

- (IBAction)quitApp:(id)sender {
}
@end
