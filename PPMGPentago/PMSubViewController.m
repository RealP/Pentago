//
//  PMViewController.m
//  PPMGPentago
//
//  Created by student on 9/10/14.
//  Copyright (c) 2014 PPMGLLC. All rights reserved.
//

#import "PMSubViewController.h"
#import "PentagoBrain.h"
#import "PentagoViewController.h"
#import "PMAppDelegate.h"
const int BORDER_WIDTH = 10;
const int TOP_MARGIN = 50;


@interface PMSubViewController () {
    int subsquareNumber;
    int widthOfSubsquare;
    CGRect _gridFrame;
    BOOL gameStarted;
}

@property(nonatomic, strong) PentagoBrain *pBrain;

@property (nonatomic, strong) UIImageView *gridImageView;

//@property(nonatomic) CALayer *blueLayer;
@property(nonatomic) CALayer *ballLayer;

@property(nonatomic) int _widthOfSubsquare;
@property(nonatomic) NSMutableArray *balls;
/////////////////////////////////////////////////////////////////////
@property(nonatomic) UIView *gridView;
@property(nonatomic) UIView *backView;

@property (nonatomic) UITapGestureRecognizer *tapGest;
@property(nonatomic) UISwipeGestureRecognizer *rightSwipe;
@property(nonatomic) UISwipeGestureRecognizer *leftSwipe;
@property(nonatomic) UIAlertView* someError;
//@property(nonatomic)  *PMAppDelegate;
-(void) didTapTheView: (UITapGestureRecognizer *) tapObject;

@end

@implementation PMSubViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    widthOfSubsquare = 145;
    gameStarted = NO;
    self.pBrain = PentagoBrain.sharedInstance;
    [self setUpGrid];
    _balls = [[NSMutableArray alloc] init];
    _someError = [[UIAlertView alloc] initWithTitle: @"You Win" message: @"Press Ok to Play Again" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];

}
-(void)setUpGrid{
    //setup grid
    _gridFrame = CGRectMake(0, 0, widthOfSubsquare, widthOfSubsquare);
    
    self.gridView = [[UIView alloc] initWithFrame: _gridFrame];
    [self.gridView addGestureRecognizer:self.rightSwipe];
    [self.gridView addGestureRecognizer:self.leftSwipe];
    [self.gridView addGestureRecognizer:self.tapGest];
    [self.view addSubview:self.gridView];
    
    UIImage *image = [UIImage imageNamed:@"grid.png"];
    
    self.gridImageView.frame = _gridFrame;
    [self.gridImageView setImage:image];
    
    [self.gridView addSubview:self.gridImageView];
    [self.gridView setBackgroundColor:[UIColor blackColor]];
    [self.gridView addGestureRecognizer: self.tapGest];
    [self.gridView addGestureRecognizer:self.rightSwipe];
    [self.gridView addGestureRecognizer:self.leftSwipe];
    
    self.backView = [[UIView alloc] initWithFrame:_gridFrame];
    [self.backView addSubview:self.gridView];
    
    CGRect viewFrame = CGRectMake( (BORDER_WIDTH + widthOfSubsquare) * (subsquareNumber % 2) + BORDER_WIDTH,
                                  (BORDER_WIDTH + widthOfSubsquare) * (subsquareNumber / 2) + BORDER_WIDTH + TOP_MARGIN,
                                  widthOfSubsquare, widthOfSubsquare);
    [self.view addSubview:self.backView];
    [self.view addSubview:self.gridView];
    self.view.frame = viewFrame;
}
-(id) initWithSubsquare: (int) position
{
    // 0 1
    // 2 3
    if( (self = [super init]) == nil )
        return nil;
    subsquareNumber = position;
    // appFrame is the frame of the entire screen so that appFrame.size.width
    // and appFrame.size.height contain the width and the height of the screen, respectively.
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    widthOfSubsquare = ( appFrame.size.width - 3 * BORDER_WIDTH ) / 2;
    return self;
}

-(UIImageView *) gridImageView
{
    if( ! _gridImageView ) {
        _gridImageView = [[UIImageView alloc] initWithFrame: CGRectZero];
    }
    return _gridImageView;
}

-(UITapGestureRecognizer *) tapGest
{
    if( ! _tapGest ) {
        _tapGest = [[UITapGestureRecognizer alloc]
                    initWithTarget:self action:@selector(didTapTheView:)];
        
        [_tapGest setNumberOfTapsRequired:1];
        [_tapGest setNumberOfTouchesRequired:1];
    }
    return _tapGest;
}

-(UISwipeGestureRecognizer *) leftSwipe
{
    if( !_leftSwipe ) {
        _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
        [_leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
    return _leftSwipe;
}

-(UISwipeGestureRecognizer *) rightSwipe
{
    if( !_rightSwipe ) {
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
        [_rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _rightSwipe;
}

-(void) didTapTheView: (UITapGestureRecognizer *) tapObject
{
    // bp is the location of the tap in self.backView so the balls are placed in right location since gridview rotates
    gameStarted = YES;
    CGPoint bp = [tapObject locationInView:self.backView];
    int squareWidth = widthOfSubsquare / 3;
    CGPoint tapInGrid = CGPointMake(bp.x/squareWidth, bp.y/squareWidth);
    if (self.pBrain.didTap || ![self.pBrain isValidTap:[NSValue valueWithCGPoint:tapInGrid] inQuadrant:subsquareNumber byPlayer:self.pBrain.player1Turn]){
        return;
    }

//    self.pBrain.didTap = YES;
    UIImageView *iView = [[UIImageView alloc] init];
    if(self.pBrain.player1Turn){
        iView.image = [UIImage imageNamed:@"greenMarble"];
    }
    else{
        iView.image = [UIImage imageNamed:@"redMarble"];
    }
    iView.frame = CGRectMake((int) (bp.x / squareWidth) * squareWidth,
                             (int) (bp.y / squareWidth) * squareWidth,
                             squareWidth,
                             squareWidth);
    
    self.ballLayer = [CALayer layer];
    [self.ballLayer addSublayer: iView.layer];
    self.ballLayer.frame = CGRectMake(0, 0, widthOfSubsquare, widthOfSubsquare);
    if( [self.balls count] > 0 )
        self.ballLayer.affineTransform = ((UIImageView *) self.balls[0]).layer.affineTransform; // balls rotate correctly
    else
        self.ballLayer.affineTransform = CGAffineTransformIdentity;
    [self.gridView.layer addSublayer:self.ballLayer];
    [self.balls addObject:iView];
    [self isThereAWinner];
    [self.pBrain flipPlayer];

}

- (void) isThereAWinner
{
    int whoWon = 0;
    whoWon = [self.pBrain checkForWin];
    if (whoWon == 1){
        NSLog(@"PLAYER 1 WINS");
        [_someError show];
        //        [self.pBrain restartGame];
        //        [self setUpGrid];
        //        [(PMAppDelegate *)[[UIApplication sharedApplication] delegate]resetApp];
    }
    else if (whoWon == 2){
        NSLog(@"PLAYER 2 WINS");
        [_someError show];
        //        [self.pBrain restartGame];
        //        [self setUpGrid];
        //        [(PMAppDelegate *)[[UIApplication sharedApplication] delegate]resetApp];
    }
    return;
}

-(void) didSwipeLeft: (UISwipeGestureRecognizer *) swipeObject
{
    // if(!self.pBrain.didTap || !gameStarted)
    // {
    //     return;
    // }
   if (! gameStarted)
       return;
    NSLog(@"In did swipeLeft didTap === %d", self.pBrain.didTap);

    [self.pBrain rotateMatricesLeft:subsquareNumber];
    CGAffineTransform currTransform = self.gridView.layer.affineTransform;
    //Rotate grid
    [UIView animateWithDuration:.5 animations:^ {
        CGAffineTransform newTransform = CGAffineTransformConcat(currTransform, CGAffineTransformMakeRotation(M_PI*1.5));
        self.gridView.layer.affineTransform = newTransform;
    } completion:^(BOOL finished) {
        //Rotate Balls
        [UIView animateWithDuration:.25 animations:^{
            for( UIImageView *iView in self.balls )
                iView.layer.affineTransform = CGAffineTransformConcat(iView.layer.affineTransform, CGAffineTransformMakeRotation(M_PI/2));
        }];
    }];
    [self.view bringSubviewToFront:self.gridView];
    [self.view addGestureRecognizer:self.leftSwipe];
    [self.view addGestureRecognizer:self.rightSwipe];
    NSLog(@"Setting didtap to no in didswipe left pmsubview.m");
    self.pBrain.didTap = NO;
    [self isThereAWinner];

}
-(void) didSwipeRight: (UISwipeGestureRecognizer *) swipeObject
{
    // if player tapped nd rotated return
    //else tell brain player rotated
    // and its time to switch turns
//    NSLog(@"In did swipe didTap === %d", self.pBrain.didTap);
    // if(!self.pBrain.didTap || ! gameStarted){
    //     return;
    // }
   if (! gameStarted)
       return;
    [self.pBrain rotateMatricesRight:subsquareNumber];
    NSLog(@"called did swipe right");
    CGAffineTransform currTransform = self.gridView.layer.affineTransform;
    //Rotate grid
    [UIView animateWithDuration:.5 animations:^ {
        CGAffineTransform newTransform = CGAffineTransformConcat(currTransform, CGAffineTransformMakeRotation(M_PI/2));
        self.gridView.layer.affineTransform = newTransform;
    } completion:^(BOOL finished) {
        //Rotate Balls
        [UIView animateWithDuration:.25 animations:^{
            for( UIImageView *iView in self.balls )
                iView.layer.affineTransform = CGAffineTransformConcat(iView.layer.affineTransform, CGAffineTransformMakeRotation(-M_PI/2));
        }];
    }];
    [self.view bringSubviewToFront:self.gridView];
    [self.view addGestureRecognizer:self.rightSwipe];
    [self.view addGestureRecognizer:self.leftSwipe];
    NSLog(@"Setting didtap to no in didswipe left pmsubview.m");
    self.pBrain.didTap = NO;
    [self isThereAWinner];

}
//-(PentagoBrain *) pBrain
//{
//    if( ! _pBrain ){
//        _pBrain = [PentagoBrain sharedInstance];
//        _pBrain.initialize;}
//    return _pBrain;
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
