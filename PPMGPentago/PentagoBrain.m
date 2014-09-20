//
//  PentagoBrain.m
//  PentagoStudentVersion
//
//  Created by AAK on 2/17/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "PentagoBrain.h"

@implementation PentagoBrain

//method that provides access to one single instance of the petnago brain
-(void) initialize
{
    self.quadrant0 = @[
                                                      @[ @"0", @"0", @"0"],
                                                      @[ @"0", @"0", @"0"],];
    NSLog(@"quaad= == %@",self.quadrant0);

}
+(PentagoBrain *) sharedInstance
{
    // Only happens once!!!!
    static PentagoBrain *sharedObject = nil;
   
    if( sharedObject == nil )
        sharedObject = [[PentagoBrain alloc] init];
    return sharedObject;
}

- (BOOL) hasSwiped
{
    return YES;
}


- (BOOL) tapDownForWhat
{
    
    return YES;
}

//add the quadrant then fill in the array
-(BOOL) isValidTap: (NSValue *) point inQuadrant:(int) quad byPlayer:(int)player
{
    int col = (int) [point CGPointValue].x;
    int row = (int) [point CGPointValue].y;
    if (player == 1){
        switch (quad)
        {
            case 0:
                self.quadrant0[col][row] = @"1";
            case 1:
                self.quadrant1[col][row] = @"1";
            case 2:
                self.quadrant2[col][row] = @"1";
            case 3:
                self.quadrant3[col][row] = @"1";
        }
    }
    else{
        switch (quad)
        {
            case 0:
                self.quadrant0[col][row] = @"2";
            case 1:
                self.quadrant1[col][row] = @"2";
            case 2:
                self.quadrant2[col][row] = @"2";
            case 3:
                self.quadrant3[col][row] = @"2";
        }
    }
    
    NSLog(@"%@",self.quadrant0);
//    NSLog(@"%f", [point CGPointValue].x);
//    NSLog(@" %f", [point CGPointValue].y);
//    NSLog(@" %d", quad);

    return true;
}
- (BOOL) isValidMove: (NSString *) move
{
    
    NSLog(@"Move = %@", (move));
    if( [move isEqualToString:@"tap"] && self.didTap == NO ){
        NSLog(@"Hi ");
        self.didTap = YES;
        return YES;
    }
    else if (self.didTap && [move  isEqual: @"swipe"] ){
        NSLog(@"Calling flipplayer.");
        [self flipPlayer];
        return YES;
    }
    return NO;
}

- (void) flipPlayer
{
    NSLog(@"Called flip player");
    self.player1Turn = !self.player1Turn;
    self.didSwipe = NO;
    self.didTap = NO;    
}

@end
