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


- (void) flipPlayer
{
    self.player1Turn = !self.player1Turn;
    
}

@end
