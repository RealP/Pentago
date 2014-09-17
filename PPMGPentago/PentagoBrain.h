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

- (BOOL) hasSwiped;
- (void) flipPlayer;
- (BOOL) isValidMove: (NSString *) move;
+(PentagoBrain *) sharedInstance;

@end
