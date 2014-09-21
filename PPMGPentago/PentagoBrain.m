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
    if (self.quadrant0 == nil){
        self.quadrant0 = [[NSMutableArray alloc] initWithCapacity:3];
        [self.quadrant0 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:0];
        [self.quadrant0 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:1];
        [self.quadrant0 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:2];
    }
    if (self.quadrant1 == nil){
        self.quadrant1 = [[NSMutableArray alloc] initWithCapacity:3];
        [self.quadrant1 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:0];
        [self.quadrant1 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:1];
        [self.quadrant1 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:2];
    }
    if (self.quadrant2 == nil){
        self.quadrant2 = [[NSMutableArray alloc] initWithCapacity:3];
        [self.quadrant2 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:0];
        [self.quadrant2 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:1];
        [self.quadrant2 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:2];
    }
    if (self.quadrant3 == nil){
        self.quadrant3 = [[NSMutableArray alloc] initWithCapacity:3];
        [self.quadrant3 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:0];
        [self.quadrant3 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:1];
        [self.quadrant3 insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:2];
    }

    self.player1Turn=YES;
    self.tapHasOccured = 0;
    NSLog(@"Setting didtap = false in intiliaze in pentagobrain.m");
    self.didTap = NO;


}
+(PentagoBrain *) sharedInstance
{
    // Only happens once!!!!
    static PentagoBrain *sharedObject = nil;
   
    if( sharedObject == nil ){
        sharedObject = [[PentagoBrain alloc] init];
        [sharedObject initialize];
    }
    return sharedObject;
}

- (BOOL) hasSwiped
{
    return YES;
}


- (BOOL) getFlipTap
{
    return self.didTap;
}

- (void) flipDidTap
{
    self.didTap = !self.didTap;
    return;
}

-(BOOL) isValidSwipe
{
    if (self.didTap == 1){
        return 1;
    }
    else
    {
        return 0;
    }
}
//add the quadrant then fill in the array
-(BOOL) isValidTap: (NSValue *) point inQuadrant:(int) quad byPlayer:(int)player
{
    int col = (int) [point CGPointValue].x;
    int row = (int) [point CGPointValue].y;
//    NSLog(@"m/ove col = %d row = %d Quadrant = %d", col, row, quad);

    if (player == 1){
        switch (quad)
        {
            case 0:
                if ([self.quadrant0[col][row]  isEqual: @"0"])
                {
                    self.quadrant0[col][row] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant0 = %@", col, row, self.quadrant0);
                    return NO;
                }
            case 1:
                if ([self.quadrant1[col][row]  isEqual: @"0"])
                {
                    self.quadrant1[col][row] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant1 = %@", col, row, self.quadrant1);
                    return NO;
                }
            case 2:
                if ([self.quadrant2[col][row]  isEqual: @"0"])
                {
                    self.quadrant2[col][row] = @1;
                    self.didTap=YES;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant2 = %@", col, row, self.quadrant2);
                    return NO;
                }
            case 3:
                if ([self.quadrant3[col][row]  isEqual: @"0"])
                {
                    self.quadrant3[col][row] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant3 = %@", col, row, self.quadrant3);
                    return NO;
                }
        }
    }
    else{
        switch (quad)
        {
            case 0:
                if ([self.quadrant0[col][row]  isEqual: @"0"])
                {
                    self.quadrant0[col][row] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant0 = %@", col, row, self.quadrant0);
                    return NO;
                }
            case 1:
                if ([self.quadrant1[col][row]  isEqual: @"0"])
                {
                    self.quadrant1[col][row] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant1 = %@", col, row, self.quadrant1);
                    return NO;
                }
            case 2:
                if ([self.quadrant2[col][row]  isEqual: @"0"])
                {
                    self.quadrant2[col][row] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant2 = %@", col, row, self.quadrant2);
                    return NO;
                }
            case 3:
                if ([self.quadrant3[col][row]  isEqual: @"0"])
                {
                    self.quadrant3[col][row] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant3 = %@", col, row, self.quadrant3);
                    return NO;
                }
        }
    }
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
//    self.didTap = NO;    
}

-(void) rotateMatricesRight
{
    //  1 1 0 --> 0 0 1
    //  0 1 0 --> 0 1 1
    //  0 0 0 --> 0 0 0
    // row0 --> col2 . row1 --> col 1 . row2 --> col0
    
    return;
}

@end
