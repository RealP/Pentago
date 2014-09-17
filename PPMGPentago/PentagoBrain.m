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
