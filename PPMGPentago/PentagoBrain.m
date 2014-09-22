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
    NSLog(@"%@", self.quadrant0);
    NSLog(@"%@", self.quadrant0[2][0]);
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
                if ([self.quadrant0[row][col]  isEqual: @"0"])
                {
                    self.quadrant0[row][col] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant0 = %@", col, row, self.quadrant0);
                    return NO;
                }
            case 1:
                if ([self.quadrant1[row][col]  isEqual: @"0"])
                {
                    self.quadrant1[row][col] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant1 = %@", col, row, self.quadrant1);
                    return NO;
                }
            case 2:
                if ([self.quadrant2[row][col]  isEqual: @"0"])
                {
                    self.quadrant2[row][col] = @1;
                    self.didTap=YES;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant2 = %@", col, row, self.quadrant2);
                    return NO;
                }
            case 3:
                if ([self.quadrant3[row][col]  isEqual: @"0"])
                {
                    self.quadrant3[row][col] = @1;
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
                if ([self.quadrant0[row][col]  isEqual: @"0"])
                {
                    self.quadrant0[row][col] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant0 = %@", col, row, self.quadrant0);
                    return NO;
                }
            case 1:
                if ([self.quadrant1[row][col]  isEqual: @"0"])
                {
                    self.quadrant1[row][col] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant1 = %@", col, row, self.quadrant1);
                    return NO;
                }
            case 2:
                if ([self.quadrant2[row][col]  isEqual: @"0"])
                {
                    self.quadrant2[row][col] = @1;
                    return YES;
                }
                else
                {
                    NSLog(@"Invalid move col = %d row = %d Quadrant2 = %@", col, row, self.quadrant2);
                    return NO;
                }
            case 3:
                if ([self.quadrant3[row][col]  isEqual: @"0"])
                {
                    self.quadrant3[row][col] = @1;
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

-(void) printArrays
{
    NSLog(@"Quad 0");
    for(int i = 0; i < 3; i++)
        NSLog(@"%@ %@ %@", self.quadrant0[i][0], self.quadrant0[i][1], self.quadrant0[i][2]);
    NSLog(@"Quad 1");
    for(int i = 0; i < 3; i++)
        NSLog(@"%@ %@ %@", self.quadrant1[i][0], self.quadrant1[i][1], self.quadrant1[i][2]);
    NSLog(@"Quad 2");
    for(int i = 0; i < 3; i++)
        NSLog(@"%@ %@ %@", self.quadrant2[i][0], self.quadrant2[i][1], self.quadrant2[i][2]);
    NSLog(@"Quad 3");
    for(int i = 0; i < 3; i++)
        NSLog(@"%@ %@ %@", self.quadrant3[i][0], self.quadrant3[i][1], self.quadrant3[i][2]);

    
}

-(void) rotateMatricesLeft: (int)quad
{
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity: 3] ;
    if (quad==0){
        NSLog(@"Before rotation");
        [self printArrays];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant0[0][2],self.quadrant0[1][2],self.quadrant0[2][2],nil] atIndex:0];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant0[0][1],self.quadrant0[1][1],self.quadrant0[2][1],nil] atIndex:1];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant0[0][0],self.quadrant0[1][0],self.quadrant0[2][0],nil] atIndex:2];
        
        self.quadrant0 = newArray;
        NSLog(@"After rotation");
        [ self printArrays ];
    }
    else if (quad == 1){
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant1[0][2],self.quadrant1[1][2],self.quadrant1[2][2],nil] atIndex:0];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant1[0][1],self.quadrant1[1][1],self.quadrant1[2][1],nil] atIndex:1];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant1[0][0],self.quadrant1[1][0],self.quadrant1[2][0],nil] atIndex:2];
        self.quadrant1 = newArray;
    }
    else if (quad == 2){
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant2[2][0],self.quadrant2[1][0],self.quadrant2[0][0],nil] atIndex:0];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant2[2][1],self.quadrant2[1][1],self.quadrant2[0][1],nil] atIndex:1];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant2[2][2],self.quadrant2[1][2],self.quadrant2[0][2],nil] atIndex:2];
        self.quadrant2 = newArray;
    }
    else if (quad == 3){
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant3[2][0],self.quadrant3[1][0],self.quadrant3[0][0],nil] atIndex:0];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant3[2][1],self.quadrant3[1][1],self.quadrant3[0][1],nil] atIndex:1];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant3[2][2],self.quadrant3[1][2],self.quadrant3[0][2],nil] atIndex:2];
        self.quadrant3 = newArray;
    }
}

-(void) rotateMatricesRight: (int)quad
{
    //  1 1 0 --> 0 0 1
    //  0 1 0 --> 0 1 1
    //  0 0 0 --> 0 0 0
    // row0 --> col2 . row1 --> col 1 . row2 --> col0
    NSLog(@"%@", self.quadrant0);
    NSLog(@"%@", self.quadrant0[2][0]);
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity: 3];
    if (quad==0){
        NSLog(@"Before rotation");
        [self printArrays];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant0[2][0],self.quadrant0[1][0],self.quadrant0[0][0],nil] atIndex:0];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant0[2][1],self.quadrant0[1][1],self.quadrant0[0][1],nil] atIndex:1];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant0[2][2],self.quadrant0[1][2],self.quadrant0[0][2],nil] atIndex:2];

        self.quadrant0 = newArray;
        NSLog(@"After rotation");
        [ self printArrays ];
    }
    else if (quad == 1){
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant1[2][0],self.quadrant1[1][0],self.quadrant1[0][0],nil] atIndex:0];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant1[2][1],self.quadrant1[1][1],self.quadrant1[0][1],nil] atIndex:1];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant1[2][2],self.quadrant1[1][2],self.quadrant1[0][2],nil] atIndex:2];
        self.quadrant1 = newArray;
    }
    else if (quad == 2){
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant2[2][0],self.quadrant2[1][0],self.quadrant2[0][0],nil] atIndex:0];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant2[2][1],self.quadrant2[1][1],self.quadrant2[0][1],nil] atIndex:1];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant2[2][2],self.quadrant2[1][2],self.quadrant2[0][2],nil] atIndex:2];
        self.quadrant2 = newArray;
    }
    else if (quad == 3){
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant3[2][0],self.quadrant3[1][0],self.quadrant3[0][0],nil] atIndex:0];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant3[2][1],self.quadrant3[1][1],self.quadrant3[0][1],nil] atIndex:1];
        [newArray insertObject:[NSMutableArray arrayWithObjects:self.quadrant3[2][2],self.quadrant3[1][2],self.quadrant3[0][2],nil] atIndex:2];
        self.quadrant3 = newArray;
    }
//    [ self printArrays ];

    //    NSMutableArray *newArray = [[NSMutableArray alloc] tWithArray:self.quadrant0 copyItems:YES];
    
//    NSLog(@"quad0 = %@", self.quadrant0);
    NSLog(@"copy of quad = %@", newArray);
    return;
}

@end
