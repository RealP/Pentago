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

@property(nonatomic) CALayer *blueLayer;
@property(nonatomic) CALayer *ballLayer;

@property(nonatomic) int _widthOfSubsquare;
@property(nonatomic) NSMutableArray *balls;

@property(nonatomic) UIView *gridView;
@property(nonatomic) UIView *backView;

@property (nonatomic) UITapGestureRecognizer *tapGest;
@property(nonatomic) UISwipeGestureRecognizer *rightSwipe;

-(void) didTapTheView: (UITapGestureRecognizer *) tapObject;

@end

@implementation PMSubViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    widthOfSubsquare = 145;
    gameStarted = NO;
    
    //setup grid
    _gridFrame = CGRectMake(0, 0, widthOfSubsquare, widthOfSubsquare);
    
    self.gridView = [[UIView alloc] initWithFrame: _gridFrame];
    [self.gridView addGestureRecognizer:self.rightSwipe];
    [self.gridView addGestureRecognizer:self.tapGest];
    [self.view addSubview:self.gridView];
    
    UIImage *image = [UIImage imageNamed:@"grid.png"];
    
    self.gridImageView.frame = _gridFrame;
    [self.gridImageView setImage:image];
    
    [self.gridView addSubview:self.gridImageView];
    [self.gridView setBackgroundColor:[UIColor blackColor]];
    [self.gridView addGestureRecognizer: self.tapGest];
    [self.gridView addGestureRecognizer:self.rightSwipe];

    CGRect viewFrame = CGRectMake( (BORDER_WIDTH + widthOfSubsquare) * (subsquareNumber % 2) + BORDER_WIDTH,
                                  (BORDER_WIDTH + widthOfSubsquare) * (subsquareNumber / 2) + BORDER_WIDTH + TOP_MARGIN,
                                  widthOfSubsquare, widthOfSubsquare);
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

-(UISwipeGestureRecognizer *) rightSwipe
{
    NSLog(@"Called swipe");
    if( !_rightSwipe ) {
        NSLog(@"Called right-swipe");
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
        [_rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _rightSwipe;
}

-(void) didTapTheView: (UITapGestureRecognizer *) tapObject
{
    // p is the location of the tap in self.gridView. We convert it to the coordinates of the
    // self.backView, which is unchanged.
    
    gameStarted = YES;
    CGPoint bp = [tapObject locationInView:self.gridView];
    
    NSLog(@"tapped at: %@", NSStringFromCGPoint(bp) );
    int squareWidth = widthOfSubsquare / 3;
    // The board is divided into nine equally sized squares and thus width = height.
    UIImageView *iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redMarble.png"]];
    iView.frame = CGRectMake((int) (bp.x / squareWidth) * squareWidth,
                             (int) (bp.y / squareWidth) * squareWidth,
                             squareWidth,
                             squareWidth);
    
    
    self.ballLayer = [CALayer layer];
    [self.ballLayer addSublayer: iView.layer];
    self.ballLayer.frame = CGRectMake(0, 0, widthOfSubsquare, widthOfSubsquare);
    if( [self.balls count] > 0 )
//        self.ballLayer.affineTransform = CGAffineTransformMakeRotation(0.0);
        self.ballLayer.affineTransform = ((UIImageView *) self.balls[0]).layer.affineTransform;
    else
        self.ballLayer.affineTransform = CGAffineTransformIdentity;
    [self.gridView.layer addSublayer:self.ballLayer];
    [self.balls addObject:iView];
//    [self.view addSubview:iView];
//    [self.gridView addSubview:iView];

}


-(void) didSwipeRight: (UISwipeGestureRecognizer *) swipeObject
{
    if( ! gameStarted )
        return;
    NSLog(@"called did swipe right");
    [self.view bringSubviewToFront:self.gridView];
    CGAffineTransform currTransform = self.gridView.layer.affineTransform;
    [UIView animateWithDuration:1 animations:^ {
        CGAffineTransform newTransform = CGAffineTransformConcat(currTransform, CGAffineTransformMakeRotation(M_PI/2));
        self.gridView.layer.affineTransform = newTransform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            for( UIImageView *iView in self.balls )
                iView.layer.affineTransform = CGAffineTransformConcat(iView.layer.affineTransform, CGAffineTransformMakeRotation(-M_PI/2));
        }];
    }];
    [self.view addGestureRecognizer:self.rightSwipe];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
