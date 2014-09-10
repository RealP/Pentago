//
//  PMViewController.m
//  PPMGPentago
//
//  Created by student on 9/10/14.
//  Copyright (c) 2014 PPMGLLC. All rights reserved.
//

#import "PMSubViewController.h"

const int BORDER_WIDTH = 10;
const int TOP_MARGIN = 50;


@interface PMSubViewController () {
    CGRect _gridFrame;
    BOOL gameStarted;
    int subsquareNumber;
    int widthOfSubsquare;
}

@property(nonatomic) CALayer *blueLayer;
@property(nonatomic) UIImageView *gridImageView;
@property (nonatomic) UITapGestureRecognizer *tapGest;
@property(nonatomic) UISwipeGestureRecognizer *rightSwipe;
//@property(nonatomic) int widthOfSubsquare;
@property(nonatomic) UIView *gridView;
@property(nonatomic) CALayer *ballLayer;
@property(nonatomic) UIView *backView;
@property(nonatomic) NSMutableArray *balls;
@end

@implementation PMSubViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    widthOfSubsquare = 145;
    gameStarted = YES;
    
    _gridFrame = CGRectMake(50, 100, 145, 145);
    
    
    // As gridView animates, the coordinates of its frame rotates with it. So, for example, if it
    // rotates by 90 degrees, then its origin is no longer at (0, 0) with respect to its superview,
    // it is at (widthOfSubsquare, 0). So, after the rotation, the coordinates of the points that
    // you tap in the window, when located using:
    
    //     CGPoint p = [tapObject locationInView:self.gridView];
    
    // will be reported with respect to the new origin of gridView, which is no longer consistent
    // with the grid as it appears to the user. So, the tap  points have to get converted back to
    // the user's view point. To do that, I have created a backView. backView will contain the
    // gridView. After the gridView rotates, we get the location of taps in gridView and then
    // we ask for the location of the point to be converted to the coordiantes of the backView. Since
    // the backView doesn't rotate, its origin is consistent with what the user expects to see.
    CGRect ivFrame = CGRectMake(0, 0, widthOfSubsquare, widthOfSubsquare);
    self.gridImageView.frame = ivFrame;
    self.gridView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 145, 145)];
    [self.backView addSubview:self.gridView];
    UIImage *image = [UIImage imageNamed:@"grid.png"];
    [self.gridImageView setImage:image];
    [self.view addSubview:self.gridImageView];
    [self.view addGestureRecognizer: self.tapGest];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addGestureRecognizer:self.rightSwipe];

    CGRect viewFrame = CGRectMake( (BORDER_WIDTH + widthOfSubsquare) * (subsquareNumber % 2) + BORDER_WIDTH,
                                  (BORDER_WIDTH + widthOfSubsquare) * (subsquareNumber / 2) + BORDER_WIDTH + TOP_MARGIN,
                                  widthOfSubsquare, widthOfSubsquare);
    self.view.frame = viewFrame;

//    
//    self.backView = [[UIView alloc] initWithFrame:_gridFrame];
//    self.gridView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 145, 145)];
//    [self.backView addSubview:self.gridView];
//    
//    [self.gridView addGestureRecognizer:self.rightSwipe];
//    [self.gridView addGestureRecognizer:self.tapGest];
//    
//    self.gridImageView.frame = CGRectMake(0, 0, 145, 145);
//    UIImage *image = [UIImage imageNamed:@"grid.png"];
//    self.gridImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 145, 145)];
//    [self.gridImageView setImage:image];
//    [self.gridView addSubview:self.gridImageView];
//    [self.gridView setBackgroundColor:[UIColor blackColor]];
//    [self.view addSubview:self.backView];
//    _balls = [[NSMutableArray alloc] init];
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
//    NSLog(@"Called swipe");
    if( !_rightSwipe ) {
        NSLog(@"Called right-swipe");
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
        [_rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _rightSwipe;
}

-(void) didTapTheView: (UITapGestureRecognizer *) tapObject
{
    // p is the location of the tap in the coordinate system of this view-controller's view (not the view of the
    // the view-controller that includes the subboards.)
    
    CGPoint p = [tapObject locationInView:self.view];
    int squareWidth = widthOfSubsquare / 3;
    // The board is divided into nine equally sized squares and thus width = height.
    UIImageView *iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redMarble.png"]];
    iView.frame = CGRectMake((int) (p.x / squareWidth) * squareWidth,
                             (int) (p.y / squareWidth) * squareWidth,
                             squareWidth - BORDER_WIDTH / 3,
                             squareWidth - BORDER_WIDTH / 3);
    [self.view addSubview:iView];
}

-(void) didSwipeRight: (UISwipeGestureRecognizer *) swipeObject
{
    if( ! gameStarted )
        return;
    CGAffineTransform currTransform = self.gridView.layer.affineTransform;
    [UIView animateWithDuration:1 animations:^ {
        CGAffineTransform newTransform = CGAffineTransformConcat(currTransform, CGAffineTransformMakeRotation(M_PI/2));
        self.gridView.layer.affineTransform = newTransform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            for( UIImageView *iView in self.balls )
                iView.layer.affineTransform = CGAffineTransformConcat(iView.layer.affineTransform,
                                                                      CGAffineTransformMakeRotation(-M_PI/2));
        }];
    }];
    [self.view bringSubviewToFront:self.gridView];
    [self.view addGestureRecognizer:self.rightSwipe];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
