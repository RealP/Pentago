//
//  PentagoBrain.h
//  PentagoStudentVersion
//
//  Created by AAK on 2/17/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PentagoBrain : NSObject
@property (nonatomic) BOOL player1Turn;
@property (nonatomic) BOOL didSwipe;
@property (nonatomic) BOOL didTap;

// 0 1
// 2 3
@property(nonatomic) NSArray *quadrant0;
@property(nonatomic) NSMutableArray *quadrant1;
@property(nonatomic) NSMutableArray *quadrant2;
@property(nonatomic) NSMutableArray *quadrant3;

-(BOOL) isValidTap: (NSValue *) point inQuadrant:(int) quad byPlayer:(int)player;

- (BOOL) hasSwiped;
- (void) flipPlayer;
- (BOOL) isValidMove: (NSString *) move;
+(PentagoBrain *) sharedInstance;
- (void) initialize;

@end
