//  PentagoBrain.h
//  PentagoStudentVersion
//  Created by AAK on 2/17/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
// --> Finished by: Paul Pfeffer 9/24/2014

#import <Foundation/Foundation.h>

@interface PentagoBrain : NSObject

// 0 1
// 2 3
@property(nonatomic) NSMutableArray* quadrant0;
@property(nonatomic) NSMutableArray* quadrant1;
@property(nonatomic) NSMutableArray* quadrant2;
@property(nonatomic) NSMutableArray* quadrant3;

@property (nonatomic) BOOL player1Turn;
@property (nonatomic) BOOL didTap;

+(PentagoBrain *) sharedInstance;
- (void) flipPlayer;
- (void) initialize;
-(BOOL) isValidTap: (NSValue *) point inQuadrant:(int) quad byPlayer:(int)player;
-(void) rotateMatricesLeft: (int)quad;
-(void) rotateMatricesRight: (int)quad;
-(int) checkForWin;

@end
