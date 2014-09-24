//
//  PentagoViewController.m
//  PentagoStudentVersion
//
//  Created by AAK on 2/17/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//  Code Completed by: Paul Pfeffer 9-24-2014

#import "PentagoViewController.h"
#import "PMSubViewController.h"
#import "PentagoBrain.h"

@interface PentagoViewController ()
@property (nonatomic, strong) NSMutableArray *subViewControllers;

@property (nonatomic) PentagoBrain *pBrain;
@property (nonatomic) UILabel * playerTurnLabel;
@end

@implementation PentagoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    //Initializes pBrain
    self.pBrain = [[PentagoBrain alloc] init];
    return self;
}

-(NSMutableArray *) subViewControllers
{
    if( ! _subViewControllers )
        _subViewControllers = [[NSMutableArray alloc] initWithCapacity:4];
    return _subViewControllers;
}

//Work in Progress
//Will be used to display the players turn
- (void) flipPlayerLabel
{
    NSLog(@"Called function flipPlayerLabel in PentagoViewController");
    if (self.playerTurnLabel == nil){
        CGRect frame = [[UIScreen mainScreen] applicationFrame];
        [self.view setFrame:frame];
        self.playerTurnLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.playerTurnLabel.text = @"@Player 1 place your marble";
        self.playerTurnLabel.textColor = [UIColor redColor];
        [self.view addSubview:self.playerTurnLabel];
        [self.playerTurnLabel sizeToFit];
        self.playerTurnLabel.center = CGPointMake(frame.size.width/2, frame.size.height-60);
    }
    self.playerTurnLabel.text = @"@Player 2 place your marble";
    self.playerTurnLabel.textColor = [UIColor greenColor];
    [self.view addSubview:self.playerTurnLabel];
    [self.playerTurnLabel sizeToFit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    [self.view setFrame:frame];
    
    // Image Label at the top of screen displaying Pentago
    UILabel * pentagolabel = [[UILabel alloc] initWithFrame:CGRectZero];
    pentagolabel.text = @"Pentago";
    pentagolabel.textColor = [UIColor whiteColor];
    [self.view addSubview:pentagolabel];
    [pentagolabel sizeToFit];
    pentagolabel.center = CGPointMake(frame.size.width / 2, 40);
    
    // Image Label at the bottom of screen displaying how to win
    UILabel * imageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    imageLabel.text = @"Get 5 in Row!";
    imageLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:imageLabel];
    [imageLabel sizeToFit];
    imageLabel.center = CGPointMake(frame.size.width / 2, frame.size.height-40);
    
    // This is our root view-controller. Each of the quadrants of the game is
    // represented by a different view-controller. We create them here and add their views to the
    // view of the root view-controller.
    for (int i = 0; i < 4; i++) {
        PMSubViewController *p = [[PMSubViewController alloc] initWithSubsquare:i];
        [p.view setBackgroundColor:[UIColor blackColor]];
        [self.subViewControllers addObject: p];
        [self.view addSubview: p.view];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
